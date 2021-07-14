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
 
<!-- /static 기준 -->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<!-- Favicon-->
<link rel="icon" type="/image/x-icon" href="assets/favicon.ico" />

<script type="text/javascript">
  $(function() {
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
  });

  function cancel() {
    $('#panel_create').css("display","");  
    $('#panel_update').css("display","none"); 
    $('#panel_delete').css("display","none");
  }

  // 수정폼
  function read_update_ajax(commgrpno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김 
    $('#panel_delete').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display",""); // show, 숨겨진 태그 출력 
    
    // console.log('-> categrpno:' + categrpno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'commgrpno=' + commgrpno; // 공백이 값으로 있으면 안됨.
    $.ajax(
      {
        url: '/commgrp/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          // {"commgrpno":1,"seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
          var commgrpno = rdata.commgrpno;
          var name = rdata.name;
          var seqno = rdata.seqno;
          var rdate = rdata.rdate;

          var frm_update = $('#frm_update');
          $('#commgrpno', frm_update).val(commgrpno);
          $('#name', frm_update).val(name);
          $('#seqno', frm_update).val(seqno);
          $('#rdate', frm_update).val(rdate);
          
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END
  } 

  // 삭제 폼(자식 레코드가 없는 경우의 삭제)
  function read_delete_ajax(commgrpno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display","none"); // hide, 태그를 숨김  
    $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
    // return;
    
    // console.log('-> categrpno:' + categrpno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'commgrpno=' + commgrpno; // 공백이 값으로 있으면 안됨.
    $.ajax(
      {
        url: '/commgrp/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          // {"commgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
          var commgrpno = rdata.commgrpno;
          var name = rdata.name;
          var seqno = rdata.seqno;

          var frm_delete = $('#frm_delete');
          $('#commgrpno', frm_delete).val(commgrpno);
          
          $('#frm_delete_name').html(name);
          $('#frm_delete_seqno').html(seqno);
          
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  } 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

  <section class="py-5">
    
        <DIV class='container c_bottom_10'> 
          <DIV class='title_line'>
            <a href="./list.do" class='link-primary'>커뮤니티</a>
          </DIV>
        
          <!-- 신규 등록 -->
          <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
            <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
              <label>그룹 이름: </label>
              <input type='text' name='name' id='name' value='' required="required" style='width: 22%;'
                         autofocus="autofocus">
              　
              <label>순서: </label>
              <input type='number' name='seqno' id='seqno' value='1' required="required" 
                        min='1' max='1000' step='1' style='width: 5%;'>
          
               
              <button type="submit" id='submit' class="btn_gray margin_l_10">등록</button>
              <button type="button" onclick="cancel();"  class="btn_gray">취소</button>
            </FORM>
          </DIV>
           
          <!-- 수정 -->
          <DIV id='panel_update' 
                  style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
                            text-align: center; display: none;'>
            <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
              <input type='hidden' name='commgrpno' id='commgrpno' value=''>
              
              <label>그룹 이름</label>
              <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'
                         autofocus="autofocus">
          
              <label>순서</label>
              <input type='number' name='seqno' id='seqno' value='1' required="required" 
                        min='1' max='1000' step='1' style='width: 5%;'>
               
              <button type="submit" id='submit' class="btn_gray margin_l_10">저장</button>
              <button type="button" id='btn_update_cancel' class="btn_gray">취소</button>
            </FORM>
          </DIV>
          
          <%-- 삭제 --%>
          <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
                  width: 100%; text-align: center; display: none;'>
            <div class="msg_warning">카테고리 그룹을 삭제하면 복구 할 수 없습니다.</div>
            <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
              <input type='hidden' name='commgrpno' id='commgrpno' value=''>
                
              <label>그룹 이름 : </label><span id='frm_delete_name'></span>  　
              <label>순서 : </label>: <span id='frm_delete_seqno'></span>
               
              <button type="submit" id='submit' class="btn_gray margin_l_10">삭제</button>
              <button type="button" id='btn_delete_cancel' class="btn_gray">취소</button>
            </FORM>
          </DIV>
              
          <TABLE class='table mt-5'>
            <colgroup>
              <col style='width: 15;'/>
              <col style='width: 15%;'/>
              <col style='width: 40%;'/>  
              <col style='width: 15%;'/>  
              <col style='width: 15%;'/>
            </colgroup>
           
            <thead>  
              <TR class="table_title">
                <TH class="th_bs">출력 순서</TH>
                <TH class="th_bs">게시판 번호</TH>
                <TH class="th_bs">그룹</TH>
                <TH class="th_bs">등록일</TH>
                <TH class="th_bs">기타</TH>
              </TR>
            </thead>
            
            <tbody>
            <c:forEach var="commgrpVO" items="${list}">
              <c:set var="commgrpno" value="${commgrpVO.commgrpno }" />
              <TR>
                <TD class="td_bs">${commgrpVO.seqno }</TD>
                <TD class="td_bs">${commgrpVO.commgrpno }</TD>
                <TD class="td_bs_left">
                  <A href="../board/list_by_commgrpno_search_paging.do?commgrpno=${commgrpno}&word=&now_page=1">${commgrpVO.name }</A>
                </TD>
                <TD class="td_bs">${commgrpVO.rdate.substring(0, 10) }</TD>
         
                
                <TD class="td_bs">
                  <%-- Ajax 기반 수정폼--%>
                  <A href="javascript: read_update_ajax(${commgrpno })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
                  <%-- Ajax 기반 Delete폼--%>
                  <A href="javascript: read_delete_ajax(${commgrpno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
                  <A href="./update_seqno_up.do?commgrpno=${commgrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
                  <A href="./update_seqno_down.do?commgrpno=${commgrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
                </TD>   
              </TR>   
            </c:forEach> 
            </tbody>
         </TABLE>
       </div>
       
  </section>

 
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

