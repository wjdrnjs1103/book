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
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
  <section class="py-5">
    <DIV class='container c_bottom_10'>
      <DIV class='title_line'>
        ${id }님의 구매상품 리뷰목록
      </DIV>
      
      <TABLE class='table mt-5'>
        <colgroup>
          <col style='width: 7%;'/>
          <col style='width: 20%;'/>
          <col style='width: 36%;'/>  
          <col style='width: 10%;'/>  
          <col style='width: 7%;'/>  
          <col style='width: 7%;'/>  
          <col style='width: 13%;'/>
        </colgroup>
        <thead>  
          <TR class="table_title" style="height: 40px;">
            <TH class="th_bs">상품번호</TH>
            <TH class="th_bs">상품이름</TH>
            <TH class="th_bs">리뷰 내용</TH>
            <TH class="th_bs">평점</TH>
            <TH class="th_bs">조회</TH>
            <TH class="th_bs">날짜</TH>
            <TH class="th_bs">기타</TH>
          </TR>
        </thead>
        
        <tbody>
           <c:choose>
              <c:when test="${list.size() > 0 }">
                  <c:forEach var="reviewVO" items="${list}" varStatus="status">
                    <c:set var="productno" value="${list2[status.index].productno }"/>
                    <c:set var="reviewno" value="${list2[status.index].reviewno }" />
                    <c:set var="r_title" value="${list2[status.index].r_title }" />
                    <c:set var="content" value="${list2[status.index].content }" />
                    <c:set var="score" value="${list2[status.index].score }" />
                    <c:set var="writer" value="${list2[status.index].writer }" />
                    <c:set var="rdate" value="${list2[status.index].rdate }" />
                    <c:set var="rcnt" value="${list2[status.index].rcnt }" />
                    <c:set var="thumb" value="${list2[status.index].thumb }" />
                    <c:set var="file1" value="${list2[status.index].file1 }" />
                    <c:set var="rsize" value="${list2[status.index].rsize }" />
                      
                    <TR>
                      <TD class="td_bs"><A href="../product/read.do?productno=${productno }">${productno }</A></TD>
                      <TD class="td_bs"><A href="../product/read.do?productno=${productno }">${r_title }</A></TD>
                      <TD class="td_bs_left">
                        <A href="./read.do?reviewno=${reviewno }">${content }</A>
                      </TD>
                      <TD class="td_bs">${score }</TD> 
                      <TD class="td_bs">${rcnt }</TD> 
                      <TD class="td_bs">${rdate.substring(0, 16) }</TD>
                      <TD class="td_bs">
                        <A href="./read_update.do?reviewwno=${reviewwno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
                        <A href="./read_delete.do?reviewwno=${reviewwno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
                      </TD>  
           
                    </TR>   
                  </c:forEach>
               </c:when>
               <c:otherwise>
                 <tr>
                  <td colspan="6" style="text-align: center; font-size: 1.3em;">해당 상품에 대한 리뷰가 없습니다.</td>
                 </tr>
               </c:otherwise>
            </c:choose>
        </tbody>
      </TABLE>
    
    </DIV><!-- container c_bottom_10 end -->
    
  </section>
  
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

