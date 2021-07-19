<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team 2</title>

<!-- /static 기준 -->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/style.css" rel="stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<!-- Favicon -->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />


<script type="text/javascript">

</script>
</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="container">
  <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
    <h3>쪽지함 테스트</h3>
  </div>

  <div class="page-header"></div>
  

    <table>
      <colgroup>
        <col style='width: 10;'/>
        <col style='width: 20%;'/>
        <col style='width: 40%;'/>  
        <col style='width: 15%;'/>  
        <col style='width: 15%;'/>
      </colgroup>
      
      <thead>  
        <TR class="table_title">
          <TH class="th_bs">번호</TH>
          <TH class="th_bs">보낸사람</TH>
          <TH class="th_bs">제목</TH>
          <TH class="th_bs">날짜</TH>
          <TH class="th_bs">기타</TH>
        </TR>
      </thead>
      
      <tbody>

      </tbody>
    </table>
</div> <!-- container// -->

 
 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>