<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title></title>
<style type="text/css">
  .basket_label {
    font-family: Malgun Gothic;
    font-size: 28px;
    float: left;
    text-align: left;
  }
  
  .basket_price {
    font-size: 33px;
    color: #ff3333;
    text-align: right;
  }
  
  .title_line {
    text-align: left;
    border-bottom: solid 3px #555555;
    width: 100%;
    margin: 20px auto;
    font-size: 20px;    
  }
  
    .content_body {
    width: 90%;
    margin: 10px auto; // margin 해결
  }
  
    .aside_right {
    float: right;
    font-size: 0.9em;
  }
</style>
<link href="../css/style.css" rel="Stylesheet" type="text/css">
 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
<script type="text/javascript">
  function delete_func(interestedno) {  // GET -> POST 전송, 상품 삭제
    var frm = $('#frm_delete');
    $('#interestedno', frm).val(interestedno);
    
    //alert('interestedno:' +$('#interestedno', frm).val());
    //frm.attr('action', './delete.do');
    //$('#interestedno',  frm).val(interestedno);
    
    frm.submit();
  }   

</script>

<style type="text/css">

    
</style>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
<%-- GET -> POST: 상품 삭제용 폼 --%>
<form name='frm_delete' id='frm_delete' action='./delete.do' method='get'>
  <input type='hidden' name='interestedno' id='interestedno'>
</form>
 
<DIV class='title_line'>
  찜하기
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <c:if test="${interestedno != null}">
      <A href="/product/list_by_cateno_search_paging?productno=${productno}">쇼핑 계속하기</A>
      <span class='menu_divide' >│</span>    
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
  </ASIDE> 

  <DIV class='menu_line'></DIV>

  <table class="table table-striped" style='width: 100%;'>
    <colgroup>
      <col style="width: 20%;"></col>
      <col style="width: 40%;"></col>
      <col style="width: 20%;"></col>
      <col style="width: 20%;"></col>
    </colgroup>
    <%-- table 컬럼 --%>
<!--     <thead>
      <tr>
        <th style='text-align: center;'>파일</th>
        <th style='text-align: center;'>상품명</th>
        <th style='text-align: center;'>정가, 할인률, 판매가, 포인트</th>
        <th style='text-align: center;'>기타</th>
      </tr>
    
    </thead> -->
    
    <%-- table 내용 --%>
    <tbody>
      <c:choose>
        <c:when test="${list.size() > 0 }">
          <c:forEach var="interestedVO" items="${list }">
            <c:set var="interestedno" value="${interestedVO.interestedno }" />
            <c:set var="productno" value="${interestedVO.productno }" />
            <c:set var="title" value="${interestedVO.title }" />
            <c:set var="thumb1" value="${interestedVO.thumb1 }" />
            <c:set var="price" value="${interestedVO.price }" />
            <c:set var="memberno" value="${interestedVO.memberno }" />
            <c:set var="sdate" value="${interestedVO.sdate }" />
            
            <tr> 
              <td style='vertical-align: middle; text-align: center;'>
                <c:choose>
                  <c:when test="${thumb1.endsWith('jpg') || thumb1.endsWith('png') || thumb1.endsWith('gif')}">
                    <%-- /static/contents/storage/ --%>
                    <%-- 
                    <a href="/product/read.do?productno=${productno}"><IMG src="/product/storage/${thumb1 }" style="width: 120px; height: 80px;"></a> 
                    --%>
                  </c:when>
                  <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                    ${product.file1}
                  </c:otherwise>
                </c:choose>
              </td>  
              <td style='vertical-align: middle;'>
                <a href="/product/read.do?productno=${productno}"><strong>${title}</strong></a> 
              </td> 
              <td style='vertical-align: middle; text-align: center;'>
                <fmt:formatNumber value="${price }" pattern="#,###" /><br>
              </td>
              
              <td style='vertical-align: middle; text-align: center;'>
                <A href="javascript: delete_func(${interestedno })"><span class="glyphicon glyphicon-remove"></span></A>
              </td>
            </tr>
          </c:forEach>
        
        </c:when>
        <c:otherwise>
          <tr>
            <td colspan="6" style="text-align: center; font-size: 1.3em;">아직 관심 상품이 없습니다.</td>
          </tr>
        </c:otherwise>
      </c:choose>
      
      
    </tbody>
  </table>
  
  <table class="table table-striped" style='margin-top: 50px; margin-bottom: 50px; width: 100%;'>
    <tbody>
      <tr>
        <td style='width: 50%;'>
          <div class='basket_label'>상품 금액</div>
        </td>
        <td style='width: 50%;'>
          <div class='basket_price'><fmt:formatNumber value="${tot_sum }" pattern="#,###" /> 원</div>
          
        </td>
        <td style='width: 50%;'>
          
          <form name='frm' id='frm' style='margin-top: 50px;' action="/payment/create.do" method='get'>
            <button type='submit' id='btn_order' class='btn btn-outline-dark' style='font-size: 1.5em;'>주문하기</button>
          </form>
        <td>
      </tr>
    </tbody>
  </table>   
</DIV>

 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

