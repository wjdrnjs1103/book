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
  function read_update_ajax(bookgrpno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김 
    $('#panel_delete').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display",""); // show, 숨겨진 태그 출력 
    
    // console.log('-> bookgrpno:' + bookgrpno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'bookgrpno=' + bookgrpno; // 공백이 값으로 있으면 안됨.

    $.ajax(
      {
        url: '/bookgrp/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          // {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
          var bookgrpno = rdata.bookgrpno;
          var name = rdata.name;
          var seqno = rdata.seqno;
          var rdate = rdata.rdate;

          var frm_update = $('#frm_update');
          $('#bookgrpno', frm_update).val(bookgrpno);
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
  function read_delete_ajax(bookgrpno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display","none"); // hide, 태그를 숨김  
    $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
    // return;
    
    // console.log('-> bookgrpno:' + bookgrpno);
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'bookgrpno=' + bookgrpno; // 공백이 값으로 있으면 안됨.
    
    $.ajax(
      {
        url: '/bookgrp/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
          // {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
          var bookgrpno = rdata.bookgrpno;
          var name = rdata.name;
          var seqno = rdata.seqno;
          // var rdate = rdata.rdate;
          var count_by_bookgrpno = parseInt(rdata.count_by_bookgrpno);
          console.log('count_by_bookgrpno: ' + count_by_bookgrpno);

          var frm_delete = $('#frm_delete');
          $('#bookgrpno', frm_delete).val(bookgrpno);
          
          $('#frm_delete_name').html(name);
          $('#frm_delete_seqno').html(seqno);
          
          if (count_by_bookgrpno > 0) { // 자식 레코드가 있다면
      
            $('#frm_delete_count_by_bookgrpno_panel').html('관련자료 ' + count_by_bookgrpno + ' 건');
            $('#frm_delete_count_by_bookgrpno').show();

            // alert($('#a_list_by_bookgrpno').attr('href')); // ../book/list_by_bookgrpno.do?bookgrpno=
            $('#a_list_by_bookgrpno').attr('href', '../book/list_by_bookgrpno.do?bookgrpno=' + bookgrpno);
            
          } else {
            $('#frm_delete_count_by_bookgrpno').hide();
          }
          // console.log('-> btn_recom: ' + $('#btn_recom').val());  // X
          // console.log('-> btn_recom: ' + $('#btn_recom').html());
          // $('#btn_recom').html('♥('+rdata.recom+')');
          // $('#span_animation').hide();
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

    // $('#span_animation').css('text-align', 'center');
    // $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
    // $('#span_animation').show(); // 숨겨진 태그의 출력
  } 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
 
 <section class="py-5">

     <DIV class='container c_bottom_10'> 
          <DIV class='title_line'>
            <a href="./list.do" class='link-primary'>전공도서</a>
          </DIV>
          
  <!-- 신규 등록 -->

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      
    
      <label>그룹 이름:</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
       
       <button type="submit" id='submit' class="btn btn-dark">등록</button>
       <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
    </FORM>
  </DIV>

   
  <!-- 수정 -->
  <DIV id='panel_update' 
          style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
                    text-align: center; display: none;'>
    <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
      <input type='hidden' name='bookgrpno' id='bookgrpno' value=''>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">      

      <label>그룹 이름</label>
      <input type='text' name='name' id='name' value='' required="required" style='width: 25%;'
                 autofocus="autofocus">
  
      <label>순서</label>
      <input type='number' name='seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
       
       <button type="submit" id='submit' class="btn btn-dark">저장</button>
       <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
    </FORM>
  </DIV>
  
  <%-- 삭제 --%>
  <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
          width: 100%; text-align: center; display: none;'>
    <div class="msg_warning">전공도서 그룹을 삭제하면 복구 할 수 없습니다.</div>
    <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type='hidden' name='bookgrpno' id='bookgrpno' value=''>
        
      <label>그룹 이름</label><span id='frm_delete_name'></span>  
      <label>순서</label>: <span id='frm_delete_seqno'></span>
      
      <%-- 자식 레코드 갯수 출력 --%>
      <div id='frm_delete_count_by_bookgrpno' 
             style='color: #FF0000; font-weight: bold; display: none; margin: 10px auto;'>
        <span id='frm_delete_count_by_bookgrpno_panel'></span>     
        『<A id='a_list_by_bookgrpno' href="../book/list_by_bookgrpno.do?bookgrpno=${bookgrpno }">관련 자료 삭제하기</A>』
      </div>
       
      <button type="submit" id='submit' class="btn btn-dark">삭제</button>
       <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
    </FORM>
  </DIV>
      
   <TABLE class='table mt-5'>
          <colgroup>
            <col style='width: 15%;'/>
            <col style='width: 40%;'/>
            <col style='width: 20%;'/> 
            <col style='width: 25%;'/>
          </colgroup>
         
          <thead>  
           <TR class="table_title">
            <TH class="th_bs">게시판 번호</TH>
            <TH class="th_bs">이름</TH>
            <TH class="th_bs">등록일</TH>
            <TH class="th_bs">기타</TH>
          </TR>
          </thead>
    
    <tbody>
    <c:forEach var="bookgrpVO" items="${list}">
      <c:set var="bookgrpno" value="${bookgrpVO.bookgrpno }" />
      <TR>
        <TD class="td_bs">${bookgrpVO.seqno }</TD>
        <TD class="td_bs_left">
          <A href="../book/list_by_bookgrpno.do?bookgrpno=${bookgrpno }">${bookgrpVO.name }</A>
        </TD>
        <TD class="td_bs">${bookgrpVO.rdate.substring(0, 10) }</TD>
        
        <TD class="td_bs">
          <%-- <A href="./read_update.do?bookgrpno=${bookgrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A> --%>
          <%-- Ajax 기반 수정폼--%>
          <A href="javascript: read_update_ajax(${bookgrpno })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
          
          <%-- <A href="./read_delete.do?bookgrpno=${bookgrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A> --%>
          <%-- Ajax 기반 Delete폼--%>
          <A href="javascript: read_delete_ajax(${bookgrpno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
          
          <A href="./update_seqno_up.do?bookgrpno=${bookgrpno }" title="우선순위 상향"><span class="glyphicon glyphicon-arrow-up"></span></A>
          <A href="./update_seqno_down.do?bookgrpno=${bookgrpno }" title="우선순위 하향"><span class="glyphicon glyphicon-arrow-down"></span></A>         
        </TD>   
      </TR>   
    </c:forEach> 
    </tbody>
   
  </TABLE>
</DIV>
</section>


 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

