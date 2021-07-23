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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<script type="text/javascript">
$(function(){
  $('#btn_login').on('click', login_ajax);
  $('#btn_loadDefault').on('click', loadDefault);
});

function loadDefault() {
  $('#id').val('admin');
  $('#passwd').val('1234');
}

<%-- 로그인 --%>
function login_ajax() {
  var params = "";
  params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  // params += '&${ _csrf.parameterName }=${ _csrf.token }';
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
          // 쇼핑카트에 insert 처리 Ajax 호출
          cart_ajax_post();            
          
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

<%-- 찜하기에 상품 추가 --%>
function cart_ajax(productno, stateno) {
  var f = $('#frm_login');
  $('#productno', f).val(productno); // 쇼핑카트 등록시 사용할 상품 번호를 저장.

  //stateno = 2;
  console.log('-> productno:' +$('#productno', f).val());
  console.log('-> stateno:' + stateno);
  
  console.log('-> only productno:' + productno);

  if (stateno == 2 ){ // 판매 되었을 경우
    
    msg="이미 판매가 완료된 상품입니다";
    window.confirm(msg);
    return;
    
  } else {

    if('${sessionScope.id}'=='') {// 로그인이 안 되어 있는 경우
      // location.href='/register/login.do';
       $('#div_login').show();    // 로그인폼 출력 
     } else {// 로그인이 되어 있는 경우
       cart_ajax_post();
     } // if session end
  }// if stateno end
}// cart_ajax end
 
 <%-- 찜하기에 상품 등록 --%>
 function cart_ajax_post() {
   var f = $('#frm_login');
   var productno = $('#productno', f).val();
 
   console.log('->cart productno:' + productno);
 
   var params = "";
   params += 'productno=' + productno;
   //console.log("-> cart_ajax_post: "+params);
 
   $.ajax(
       {
         url: '/cart/create.do',
         type: 'post',  // get, post
         cache: false, // 응답 결과 임시 저장 취소
         async: true,  // true: 비동기 통신
         dataType: 'json', // 응답 형식: json, html, xml...
         data: params,      // 데이터
         success: function(rdata) { // 응답이 온경우
           var str='';
           console.log('->cart_ajax_post cnt:'+rdata.cnt); // 1: 찜하기 등록 성공
 
           if (rdata.cnt == 1) {
             var sw = confirm('선택한 상품을 찜하는데 성공하였습니다. \n 찜하기 목록으로 이동하시겠습니까?');
             if (sw == true) {
               // 찜하기로 이동
               location.href='/cart/list.do?bookno='+${bookVO.bookno};
             }
           } else {
             alert('선택한 상품을 찜하는데 실패했습니다. \n 잠시 후 다시 시도해주세요.')
           } // if end
         },//success
         // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
         error: function(request, status, error) { // callback 함수
           console.log(error);
         }
       }
     );// $.ajax end 
 }
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 

<div class="py-5">

    <DIV class='container c_bottom_10'>
<DIV class='title_line'>
  <A href="../bookgrp/list.do" class='title_link'>전공도서 그룹</A> > 
  <A href="../book/list_by_bookgrpno.do?bookgrpno=${bookgrpVO.bookgrpno }" class='title_link'>${bookgrpVO.name }</A> >
  <A href="./list_by_bookno_search_paging.do?bookno=${bookVO.bookno }" class='title_link'>${bookVO.name }</A>
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?bookno=${bookVO.bookno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_bookno_grid.do?bookno=${bookVO.bookno }">갤러리형</A>
  </ASIDE> 

  <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_bookno_search_paging.do'>
      <input type='hidden' name='bookno' value='${bookVO.bookno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class="btn btn-dark">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_bookno_search_paging.do?bookno=${bookVO.bookno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
      <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
  <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
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
        <button type="button" id='btn_login' class="btn btn-warning btn-md">로그인</button>
        <button type='button' onclick="location.href='./create.do'" class="btn btn-warning btn-md">회원가입</button>
        <button type='button' id='btn_loadDefault' class="btn btn-danger btn-md">테스트 계정</button>
        <button type='button' id='btn_cancel' class="btn btn-warning btn-md"
                    onclick="$('#div_login').hide();">취소</button>
      </div>
    </div>   
    
  </FORM>
  </DIV>
  <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
  
  <table class="table mt-5" style='width: 100%;'>
    <colgroup>
      <col style="width: 10%;"></col>
      <col style="width: 60%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 10%;"></col>
    </colgroup>
    
    <%-- table 내용 --%>
    <tbody>
      <c:forEach var="productVO" items="${list }">
        <c:set var="productno" value="${productVO.productno }" />
        <c:set var="title" value="${productVO.title }" />
        <c:set var="content" value="${productVO.content }" />
        <c:set var="file1" value="${productVO.file1 }" />
        <c:set var="thumb1" value="${productVO.thumb1 }" />
        <c:set var="price" value="${productVO.price }" />
        <c:set var="stateno" value="${productVO.stateno }" />
        
        <tr> 
          <td style='vertical-align: middle; text-align: center;'>
            <c:choose>
              <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                <%-- /static/product/storage/ --%>
                <a href="./read.do?productno=${productno}&now_page=${param.now_page }&word=${param.word }&stateno=${stateno}"><IMG src="/product/storage/${thumb1 }" style="width: 130px; height: 170px;"></a> 
              </c:when>
              <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                ${file1}
              </c:otherwise>
            </c:choose>
          </td>  
          <td style='vertical-align: middle;'>
            <a href="./read.do?productno=${productno}&now_page=${param.now_page }&stateno=${stateno}"><strong>${title}</strong><br> ${content}</a> 
          </td> 
          <td style='vertical-align: middle; text-align: center;'>
          
           <%-- <del><fmt:formatNumber value="${productVO.price}" pattern="#,###" /></del><br>
            <span style="color: #FF0000; font-size: 1.2em;">${productVO.dc} %</span>
            <strong><fmt:formatNumber value="${productVO.saleprice}" pattern="#,###" /></strong><br>
            <span style="font-size: 0.8em;">포인트: <fmt:formatNumber value="${productVO.point}" pattern="#,###" /></span>
            <strong><fmt:formatDatevalue="${productVO.rdate}" type="date" /></strong>                                                                                     --%>
            <span style="font-size: 1.1em;">가격: ${productVO.price}원</span>
                        
            <br>
            <button type='button' id='btn_cart' class="btn btn-danger" style='margin-bottom: 2px;'
                        onclick="cart_ajax(${productno}, ${stateno })">찜하기 </button><br>
             
            <c:choose>
              <c:when test="${stateno ==1 }">
                <h4>판매중</h4>
              </c:when>
              <c:otherwise>
                <h4>판매 완료</h4>
              </c:otherwise>
            </c:choose><br>
            <span style="font-size: 0.8em;">${productVO.rdate}</span>
            
          </td>
          <td style='vertical-align: middle; text-align: center;'>
            <A href="./update_text.do?productno=${productno}&now_page=${now_page }"><span class="glyphicon glyphicon-pencil"></span></A>
            <A href="./delete.do?productno=${productno}&now_page=${now_page }"><span class="glyphicon glyphicon-trash"></span></A>
          </td>
        </tr>
      </c:forEach>
      
    </tbody>
  </table>
  <DIV class='bottom_menu'>${paging }</DIV>
</DIV>
</DIV>
</DIV>


 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>