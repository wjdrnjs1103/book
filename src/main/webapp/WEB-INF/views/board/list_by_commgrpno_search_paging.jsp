<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="shrink-to-fit=no initial-scale=1, width=device-width" /> 
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team2</title>
 
<!-- /static 기준, Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />


<script type="text/javascript">
  $(function() {
    // var contentsno = 0;
    //$('#btn_create').on('click', function() { b_c_btn(commgrpno)});
    $('#btn_login').on('click', login_ajax);
    $('#btn_loadDefault').on('click', loadDefault);
  });

  function loadDefault() {
      $('#id').val('user1');
      $('#passwd').val('1234');
  } 
    
  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    
    $.ajax(
      {
        url: '/register/login_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
          
          if (rdata.cnt == 1) {
            $('#div_login').hide();
            // alert('로그인 성공');
            // 쇼핑카트에 insert 처리 Ajax 호출
            board_create_ajax();            
            
          } else {
            alert('로그인에 실패했습니다. 잠시후 다시 시도해주세요.');
            location.href='/register/login.do';
            
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END
  }
  
  <%-- 게시판에 글쓰기 --%>
  function b_c_btn(commgrpno) {
    var f = $('#frm_login');
    $('#commgrpno', f).val(commgrpno);  // 게시글 등록시 사용할 커뮤니티 번호를 저장.
    
    console.log('-> commgrpno: ' + $('#commgrpno', f).val()); 
    
    // console.log('-> id:' + '${sessionScope.id}');
    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
      $('#div_login').show();    // 로그인폼 출력  
      
    } else {  // 로그인 한 경우
  	  board_create_ajax();
  	}  
  }
    
  <%-- 게시글 등록 --%>
  function board_create_ajax() {
    var f = $('#frm_login');
    var commgrpno = $('#commgrpno', f).val();  // 쇼핑카트 등록시 사용할 상품 번호.
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'commgrpno=' + commgrpno;
    // console.log('-> board_create_ajax: ' + commgrpno);
    // return;
    location.href='/board/create.do?commgrpno=' + commgrpno +'&word=&now_page=1';
  }
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

<div class="py-5">
  
    <DIV class='container c_bottom'> 
        <DIV class='title_line_none'>
          <!-- <a href="../commgrp/list.do" class='title_link'>커뮤니티</a> -->
          <a href="./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
        </DIV>

        <ASIDE class="aside_right">
          <A href="javascript:location.reload();">새로고침</A>
          <span class='menu_divide' >　</span>
          <A href="./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno }&word=${param.word }&now_page=${param.now_page}" title="기본 목록형"><IMG style="width:24px;"src='/css/images/list_gray.png'></A>        
          <span class='menu_divide' >　</span>
          <A href="./list_by_commgrpno_grid_paging.do?commgrpno=${param.commgrpno }&word=&now_page=1"><IMG style="width:24px;"src='/css/images/photo_gray.png'></A>        
<%--                     <A href="./list_by_commgrpno_grid.do?commgrpno=${param.commgrpno }&now_page=${param.now_page}"><IMG style="width:24px;"src='/css/images/photo_gray.png'></A>         --%>
        </ASIDE> 
        
        <DIV class='menu_line'></DIV>
        
        <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
        <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
          <FORM name='frm_login' id='frm_login' method='POST' action='/register/login.do' class="form-horizontal">
            <input type="hidden" name="commgrpno" id="commgrpno" value="commgrpno">
            
            <div class="form-group">
              <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
              <div class="col-md-7">
                <input type='text' class="form-control" name='id' id='id' 
                           value='${ck_id }' required="required" 
                           style='width: 40%;' placeholder="아이디" autofocus="autofocus">
                <Label>   
                  <input type='checkbox' name='id_save' value='Y' 
                            ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
                </Label>                   
              </div>
            </div>   
         
            <div class="form-group">
              <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
              <div class="col-md-7">
                <input type='password' class="form-control" name='passwd' id='passwd' 
                          value='${ck_passwd }' required="required" style='width: 40%;' placeholder="패스워드">
                <Label>
                  <input type='checkbox' name='passwd_save' value='Y' 
                            ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
                </Label>
              </div>
            </div>   
         
            <div class="form-group">
              <div class="col-md-offset-4 col-md-8">
                <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
                <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
                <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button>
                <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                            onclick="$('#div_login').hide();">취소</button>
              </div>
            </div>   
            
          </FORM>
        </DIV>
        <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
        
        <TABLE class='table table_top_margin'>
          <colgroup>
            <col style='width: 10%;'/>
            <col style='width: 62%;'/>
            <col style='width: 10%;'/> 
            <col style='width: 10%;'/> 
            <col style='width: 8%;'/>
          </colgroup>
         
          <thead>  
            <TR class="table_title">
              <TH class="th_bs">번호</TH>
              <TH class="th_bs">제목</TH>
              <TH class="th_bs_left">작성자</TH>
              <TH class="th_bs">작성일</TH>
              <TH class="th_bs">조회</TH>
            </TR>
          </thead>
          
          <tbody  style="font-size: 1.08em;">
            <c:forEach var="boardVO" items="${list}" varStatus="status">
              <c:set var="commgrpno" value="${boardVO.commgrpno }" />
              <c:set var="boardno" value="${boardVO.boardno }" />
              <c:set var="title" value="${boardVO.title }" />
              <c:set var="bcon" value="${boardVO.bcon }" />
              <c:set var="word" value="${boardVO.word }" />
              <c:set var="bcnt" value="${boardVO.bcnt }" />
              <c:set var="writer" value="${list2[status.index].writer }" />
              <c:set var="brdate" value="${boardVO.brdate }" />

              <TR>
                <TD class="td_bs">${boardno }</TD>
                <TD class="td_bs_left">
                  <A href="./read.do?boardno=${boardno }&word=${param.word }&now_page=${param.now_page }">${title }</A>
                </TD>
                <TD class="td_bs_left">${writer}</TD>
                <TD class="td_bs">${brdate.substring(0, 10) }</TD>
                <TD class="td_bs">${bcnt}</TD>
               
              </TR>   
            </c:forEach> 
          </tbody>
        </TABLE>

        <div class="content_body_bottom ">
          <button type='button' class="btn" id="btn_create" style="border: solid 1px;" 
                  onclick="b_c_btn(${commgrpno})">글쓰기</button>  
<%--           <button type='button' class="btn" id="board style="border: solid 1px;" 
                  onclick="location.href='./create.do?commgrpno=${param.commgrpno }&word=${param.word }&now_page=${param.now_page }'">글쓰기</button>   --%>
        </div>
          
        <DIV class='content_body_bottom_c_page'>${paging }</DIV>    

        <%-- 검색 --%>
        <div class="content_body_bottom_c_search">
          <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search_paging.do'>
            <input type='hidden' name='commgrpno' value='${param.commgrpno }'>
            <input type='hidden' name='now_page' value='${param.now_page }'>
            
            <%-- 상세 검색 기능 구현 해야함 --%>
            <select class="input_search_word_" style='width:10%;'>
              <option value='all'${param.search_option == "all" ? "selected='selected'":""}>전체 검색</option>
              <option value='title'${param.search_option == "title" ? "selected='selected'":""}>제목</option>
              <option value='bcon'${param.search_option == "bcon" ? "selected='selected'":""}>내용</option>                    
            </select> 
            
            <c:choose>
              <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='${param.word }' style='width: 25%;'>
              </c:when>
              <c:otherwise> <%-- 검색하지 않는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='' style='width: 25%;'>
              </c:otherwise>
            </c:choose>
            
            
            <button type='submit' class="btn_yelㅣow margin_l_10">검색</button>
            
            <c:if test="${param.word.length() > 0 }">
              <button type='button' class="btn_gray"
                           onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=${commgrpVO.commgrpno}&word=&now_page=1'">검색 취소</button>  
            </c:if>    
          </form>
        </div>
        
        <%-- 추가적으로 광고를 넣을 DIV, css 추가 --%>
        <div class="c_bottom_ad">
          광고
        </div>
        
        
    </DIV>
</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

