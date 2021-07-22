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
        리뷰목록(거래목록)
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

