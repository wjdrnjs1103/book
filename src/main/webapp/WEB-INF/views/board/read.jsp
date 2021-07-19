<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="writer" value="${boardVO.writer }" />
<c:set var="commgrpno" value="${boardVO.commgrpno }" />


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

    // 로그인 여부에 따른 수정/삭제 버튼 visible
    if ('${sessionScope.id}' == '') {  // 로그인 안되어있으면 수정/삭제 버튼 숨김
      $('#btn_update').hide();
      $('#btn_delete').hide();
    } else{                            // 로그인되어 있으면 수정/삭제 버튼 보임
    	$('#btn_update').show();
      $('#btn_delete').show();
    }
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
            location.href="read.do?boardno=3&word=&now_page=1";            
            
          } else {
            alert('로그인에 실패했습니다. 다시 시도해주세요.');
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

  <%-- 게시글 글쓰기 버튼 클릭 --%>
  function b_c_btn(commgrpno, now_page) {
    var f = $('#frm_login');
    console.log('-> commgrpno: ' + commgrpno); 
    console.log('-> now_page: ' + now_page); 
    // console.log('-> id:' + '${sessionScope.id}');

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();        // 로그인폼 출력  
      
    } else {  // 로그인 한 경우
    	  location.href='/board/create.do?commgrpno=' + commgrpno+'&word=&now_page=' +now_page;
    }
  }
  
  <%-- 게시글 수정 버튼 클릭 --%>
  function b_u_btn(boardno, now_page) {
    var f = $('#frm_login');
    $('#boardno', f).val(boardno);
    // console.log('-> boardno: ' + boardno); 
    // console.log('-> id:' + '${sessionScope.id}');

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
    	  $('#div_login').show();        // 로그인폼 출력  
      
    } else {  // 로그인 한 경우
        var writer = $.trim('${boardVO.writer}');
        var session = $.trim('${sessionScope.id}');
        // console.log("게시글 작성자 ID: " + writer);
        // console.log("홈페이지 접속 ID: " + session);
        
        // 홈페이지 로그인한 계정과 게시글 작성자가 같은지 비교
        if($.trim(session) != $.trim(writer)){
          // console.log('-->' + '${boardVO.writer}')
          alert('작성자만 수정할 수 있습니다.');
          return;
        }
        else{ 
          alert('수정 페이지로 이동');
          board_update_ajax(now_page);
        }
    }
  }

  <%-- 게시글 삭제 버튼 클릭 --%>
  function b_d_btn(commgrpno, boardno, now_page) {
    var f = $('#frm_login');
    boardno = $('#boardno', f).val(boardno);

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();        // 로그인폼 출력    

    } else {  // 로그인 한 경우
        var writer = $.trim('${boardVO.writer}');
        var session = $.trim('${sessionScope.id}');
        var name = $.trim('${sessionScope.mname}'); // 지금 로그인한 member의 mname을 admin이라는 변수에 저장
        console.log("게시글 작성자 ID: " + writer);
        console.log("session ID: " + session);
        console.log("사용자 이름: "+ name);
        
        // 삭제 가능 : memberVO.mname=관리자, 게시글 작성자만 가능
        // 홈페이지 로그인한 계정(세션)과 게시글 작성자가 같은지 비교
        if(($.trim(name) != '관리자') && ($.trim(session) != $.trim(writer))){
          // console.log('-->' + '${boardVO.writer}')
          alert('작성자만 삭제할 수 있습니다.');
          return;
        }
        else{ 
          if(name == '관리자'){
              alert('관리자 권한으로 삭제 페이지 이동');
          }else{
          }
          board_delete_ajax(commgrpno, boardno, now_page);
        }
    }
  }
    
  <%-- 게시글 수정 --%>
  function board_update_ajax(now_page) {
    var f = $('#frm_login');
    var boardno = $('#boardno', f).val();  
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'boardno=' + boardno;
    // console.log('-> board_update_ajax: ' + boardno);
    // return;
    location.href='/board/update.do?boardno=' + boardno +'&word=&now_page=' + now_page;
  }

  <%-- 게시글 삭제 --%>
  function board_delete_ajax(commgrpno, boardno, now_page) {
    var f = $('#frm_login');
    var boardno = $('#boardno', f).val();  
    
    //console.log(params);
    // console.log('-> board_delete_ajax: ' + boardno);
    location.href='/board/delete.do?boardno=' + boardno +'&word=&now_page='+now_page;

  }
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

<div class="py-5">
  
    <DIV class='container'> 
        <DIV class='title_line_none'>
          <c:choose>
            <c:when test="${commgrpno == 1}">
              <a href="./list_by_commgrpno_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:when>
            <c:when test="${commgrpno == 2}">
              <a href="./list_by_commgrpno_notice_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:when>
            <c:otherwise>
              <a href="./list_by_commgrpno_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:otherwise>
          </c:choose>
          <%-- <a href="./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>  --%>
        </DIV>
        
        <DIV class='menu_line_none'></DIV>
        
        <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
        <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
            <FORM name='frm_login' id='frm_login' method='POST' action='/register/login.do' class="form-horizontal">
              <input type="hidden" name="boardno" id="boardno" value="boardno">
              <input type="hidden" name="commgrpno" id="commgrpno" value="commgrpno">
              
              <div class="form-group">
                <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
                <div class="col-md-8">
                  <input type='text' class="form-control" name='id' id='id' 
                             value='${ck_id }' required="required" 
                             style='width: 30%;' placeholder="아이디" autofocus="autofocus">
                  <Label>   
                    <input type='checkbox' name='id_save' value='Y' 
                              ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
                  </Label>                   
                </div>
           
              </div>   
           
              <div class="form-group">
                <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
                <div class="col-md-8">
                  <input type='password' class="form-control" name='passwd' id='passwd' 
                            value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
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
        
        <div class="board_read">
            <DIV style="padding: 5px;"> 
                <div>
                    <div class="div_line_t_b" style="padding: 25px 0px 35px 40px; width: 100%; border-bottom: dotted 1px #B4B4B4;">
                      <div>
                        <span style="color: #454545; font-size: 1.4em; font-weight: bold;">${boardVO.title }</span><br>
                      </div>
                      <div style="padding: 5px 0px 0px 0px; color: #808080">
                        <span style="color: black; font-size: 0.94em; font-weight: bold;">${boardVO.writer }</span><br>
                        <span style="font-size: 0.87em;">${boardVO.brdate.substring(0, 16) }</span>
                        <span class='menu_sep2'>　</span>
                        <span style="font-size: 0.87em;">조회 ${boardVO.bcnt}</span>　
                        <span style="font-size: 0.87em;">추천 ${boardVO.brecom}</span>
                      </div>
                    </div>
                </div>
                
                <div style="padding: 10px 20px 30px 20px;" >
                    <div style="margin-left: 20px;">
                      <span>${boardVO.bcon }
                      </span>
                    </div>
                </div>
                
                <div style="margin-top: 20%; margin-left:8px; padding-left:5px; width: 100%;"> 
                  <span style="font-size: 1.1em; font-weight: bold;">댓글 ${boardVO.breplycnt }</span>
                  <div style="margin-top:15px; margin-bottom:20px; padding: 10px 20px 30px 20px; height: 120px; width: 98%; border: solid 2px #e6e6e6; border-radius: 5px;">
                    <span style="font-weight: bold; font-size: 0.96em;">댓쓴이 : ${id}</span><br>
                    <input style="margin-top:10px; border: none; width: 100%; height: 40px;"></input>
                    <div style="text-align: right; ">
                       <button type="button" class="btn btn-outline-light" style="margin-bottom: 5px;"> 등록</button>
                    </div>
                  </div>
                  
                </div>
            
            </DIV> 
        </div>
        <div style="width:100%; margin-top: 10px;">
          <div style="width:50%; float:left;">         
            <button type="button" class="btn_yelㅣow" id="btn_create" style="margin-right: 4px;"  
                    onclick="b_c_btn(${commgrpno},${param.now_page })">글쓰기</button>
            <button type="button" class="btn_gray" id="btn_update" name="btn_update" style="border: solid 1px;" 
                    onclick="b_u_btn(${param.boardno},${param.now_page })">수정</button>
            <button type="button" class="btn_gray" id="btn_delete" name="btn_delete" style="border: solid 1px;" 
                    onclick="b_d_btn(${commgrpno}, ${param.boardno}, ${param.now_page})">삭제 </button>
          </div>
          <div style="width:50%; float:right; text-align: right; margin-top:1px;">
             <c:choose>
                <c:when test="${commgrpno == 1}">
                  <button type='button' onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=1&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:when>
                <c:when test="${commgrpno == 2}">
                  <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=2&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:when>
                <c:otherwise>
                  <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=3&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:otherwise>
             </c:choose>
            <%-- <button type="button" onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno}&word=${param.word }&now_page=${param.now_page }'" 
            class="btn_gray">목록</button> --%>
          </div>
        </div>
        
        <%-- 추가적으로 광고를 넣을 DIV, css 추가 --%>
        <div class="c_bottom_ad">
          광고
        </div>
        
    </div>
</div>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

