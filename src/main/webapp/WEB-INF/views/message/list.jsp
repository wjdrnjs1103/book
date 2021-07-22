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
  $('#btn_delete_cancel').on('click', cancel);
});

function cancel() {
  $('#panel_delete').css("display","none");
}

// 삭제 폼(자식 레코드가 없는 경우의 삭제)
function read_delete_ajax(messageno) {
  $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 
  // return;
  
  // console.log('-> bookgrpno:' + bookgrpno);
  var params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'messageno=' + messageno; // 공백이 값으로 있으면 안됨.
   
  $.ajax(
    {
      url: '/message/read_ajax.do',
      type: 'get',  // get, post
      cache: false, // 응답 결과 임시 저장 취소
      async: true,  // true: 비동기 통신
      dataType: 'json', // 응답 형식: json, html, xml...
      data: params,      // 데이터
      success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
        // {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
        var messageno = rdata.messageno;
        var title = rdata.title;
        var send_member = rdata.send_member;
        var s_date = rdata.s_date;

        var frm_delete = $('#frm_delete');
        $('#messageno', frm_delete).val(messageno);
        
        $('#frm_delete_name').html(send_member);
        
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
        쪽지함 > <a href="/product/list_by_bookno_search_paging.do" class='link-primary'>도시목록</a>
      </DIV>
      
      <%-- 삭제 --%>
      <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
              width: 100%; text-align: center; display: none;'>
        <div class="msg_warning">삭제하시겠습니까?</div>
        <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
          <input type='hidden' name='messageno' id='messageno' value=''>
            
          <label>보낸사람:</label><span id='frm_delete_name'></span>  
          
           
          <button type="submit" id='submit' class="btn btn-dark">삭제</button>
           <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
        </FORM>
      </DIV>  
      
      <TABLE class='table mt-5'>
        <colgroup>
          <col style='width: 10;'/>
          <col style='width: 10%;'/>
          <col style='width: 10%;'/>
          <col style='width: 30%;'/>  
          <col style='width: 20%;'/>  
          <col style='width: 20%;'/>
        </colgroup>
        <thead>  
          <TR class="table_title">
            <TH class="th_bs">번호</TH>
            <TH class="th_bs">상품번호</TH>
            <TH class="th_bs">보낸사람</TH>
            <TH class="th_bs_left">제목</TH>
            <TH class="th_bs">날짜</TH>
            <TH class="th_bs">기타</TH>
          </TR>
        </thead>
        
        <tbody>
        <c:forEach var="messageVO" items="${list}">
          <TR>
            <TD class="td_bs">${messageVO.messageno }</TD>
            <TD class="td_bs">
              <A href="">${messageVO.productno }</A>
            </TD>
            <TD class="td_bs">
              <A href="">${messageVO.sender }</A>
            </TD>
            <TD class="td_bs_left">
              <A href="/message/read.do?messageno=${messageVO.messageno }&sender=${messageVO.sender}">${messageVO.title }</A>
            </TD>
            <TD class="td_bs">${messageVO.s_date.substring(0, 10) }</TD>
     
            
            <TD class="td_bs">
              <%-- Ajax 기반 Delete폼--%>
              <A href="javascript: read_delete_ajax(${messageVO.messageno})" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>    
            </TD>   
          </TR>   
        </c:forEach> 
        </tbody>
      </TABLE>
    
    </DIV><!-- container c_bottom_10 end -->
    
  </section>
  
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

