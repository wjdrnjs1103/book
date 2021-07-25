<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="reviewno" value="${param.reviewno }" />

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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<script type="text/javascript">

 $(function(){
   $('#btn_login').on('click', login_ajax);
   $('#btn_loadDefault').on('click', loadDefault);
 });

 <%-- 테스트용 로그인 --%>
 function loadDefault() {
   $('#id').val('admin');
   $('#passwd').val('1234');
 }
 


 <%-- 로그인 --%>
 function login_ajax() {
   var params = "";
   params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
   // console.log(params);
   // return;
   
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
           review_update_ajax(reviewno);            
           
         } else {
           alert('로그인에 실패했습니다.<br>잠시후 다시 시도해주세요.');
           
         }
       },
       // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
       error: function(request, status, error) { // callback 함수
         console.log(error);
       }
     }
   );  //  $.ajax END

 }  

 <%-- 등록된 리뷰 수정 버튼 --%>
 function r_u_btn(reviewno) {
   var f = $('#frm_login');
   $('#reviewno', f).val(reviewno);
   console.log('-> reviewno: ' + reviewno); 
   
   // console.log('-> id:' + '${sessionScope.id}');
   if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
     $('#div_login').show();    // 로그인폼 출력  
     
   } else {  // 로그인 한 경우
     var session = $.trim('${sessionScope.id}');
     var name = $.trim('${sessionScope.mname}');
     var writer = $.trim('${reviewVO.writer}');

     if(($.trim(session) != $.trim(writer)) && ($.trim(name) != '관리자') ){
        alert('작성자만 수정할 수 있습니다.');
        return;
     }else{
        alert('수정 페이지로 이동');
        review_update_ajax(reviewno);
     }
     
   }  
 }

 <%-- 등록된 리뷰 삭제 버튼 --%>
 function r_d_btn(reviewno) {
   var f = $('#frm_login');
   $('#reviewno', f).val(reviewno);
   console.log('-> reviewno: ' + reviewno); 
   
   if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
     $('#div_login').show();    // 로그인폼 출력  
     
   } else {  // 로그인 한 경우
     var session = $.trim('${sessionScope.id}');
     var name = $.trim('${sessionScope.mname}');
     var writer = $.trim('${reviewVO.writer}');

     if(($.trim(session) != $.trim(writer)) && ($.trim(name) != '관리자') ){
        alert('작성자만 삭제할 수 있습니다.');
        return;
     }else{
        alert('삭제 페이지로 이동');
        review_delete_ajax(reviewno);
     }
     
   }  
 }
   
 <%-- 리뷰 수정 --%>
 function review_update_ajax(reviewno) {
   var f = $('#frm_login');
   location.href='/review/update.do?reviewno=' + reviewno;
 }

 <%-- 리뷰 삭제 --%>
 function review_delete_ajax(reviewno) {
   var f = $('#frm_login');
   location.href='/review/delete.do?reviewno=' + reviewno;
 }

</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 

<div class="py-5">

    <DIV class='container c_bottom_10'>
 
<DIV class='title_line'>
  <A href="../product/read.do?productno=${productVO.productno }" class='title_link'>${productVO.title }</A> > 
  <A href="./list_by_productno.do?productno=${productVO.productno }" class='title_link'>리뷰</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_productno.do?productno=${reviewVO.productno }">목록</A>      
  </ASIDE> 
  
  
  <DIV class='menu_line' ></DIV>
  
  <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='padding-top:10px; width: 80%; margin: 0px auto; display: none;'>
  <FORM name='frm_login' id='frm_login' method='POST' action='/register/login.do' class="form-horizontal">
    <input type="hidden" name="productno" id="productno" value="productno">
    
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
        <button type="button" id='btn_login' class="btn btn-dark btn-md">로그인</button>
        <button type='button' onclick="location.href='./create.do'" class="btn btn-dark btn-md">회원가입</button>
        <button type='button' id='btn_loadDefault' class="btn btn-dark btn-md">테스트 계정</button>
        <button type='button' id='btn_cancel' class="btn btn-dark btn-md"
                    onclick="$('#div_login').hide();">취소</button>
      </div>
    </div>   
    
  </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  <fieldset class="fieldset_basic">
    <ul>
      <li class="li_none">
        <c:set var="file1" value="${reviewVO.file1.toLowerCase() }" />
        
        <c:if test="${file1.endsWith('jpg') || file1.endsWith('png') || file1.endsWith('gif')}">
          <DIV style="width: 44%; float: left; margin-left: 10%;">
            <IMG src="/review/storage/${reviewVO.file1 }" style="width: 80%;">
          </DIV>
          <DIV style="width: 43%; height: 260px; float: right; margin-right: 10px;">
           <form style="padding-top: 70px; font-size: 1.0em;">
              <h5>작성자 : ${reviewVO.writer }</h5>
              <h5>상품 : ${productVO.title }</h5>
              <h5>내용 : ${reviewVO.content }</h5>
              <h5>평점 : ${reviewVO.score } 　 조회 : ${reviewVO.rcnt +1}</h5>
              <h6 style="color: #BEBEBE;">첨부파일 : ${file1 }</h6>
              <button type='button' id="btn_update" onclick="r_u_btn(${reviewno})" class="btn btn-success">수정</button>
              <button type='button' id="btn_delete" onclick="r_d_btn(${reviewno})" class="btn btn-warning">삭제</button>
            </form>
          </DIV> 
        </c:if>  
      </li>

      <li class="li_none">
         
      </li>   
    </ul>
  </fieldset>

</DIV>
</DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
