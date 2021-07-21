<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.*" %>
<%@ page import="dev.mvc.schedule.*" %>

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

<style>
  table{
    border: 2px solid #d2d2d2;
    border-collapse: collapse;
    font-size: 0.9em;
  }
  th, td{
    border: 1px solid #d2d2d2;
    border-collapse: collapse;
  }
  th{
    height: 5px;
    text-align: center;
  }
  td {
    width: 100px;
    height: 60px;
  }
</style>

<script type="text/javascript">
for (int i =0 ; i < rowCnt; i++) {
  
}
</script>
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
  <div class="container">
    <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
      <h3>시간표</h3>
    </div>
    <div class="col-sm-6 col-md-offset-3" style="text-align: center;">
      <table width=100% height=600 style="color: #121212; text-align: center; margin-bottom: 30px">
        <thead width=10% height=30>
          <tr id="tr_day">
            <th></th>
            <th>월</th>
            <th>화</th>
            <th>수</th>
            <th>목</th>
            <th>금</th>
          </tr>
        <thead>
        <tbody>
          <%-- -----1교시----- --%>
          <tr id="tr_9">
            <th>9시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----2교시----- --%>
          <tr id="tr_10">
            <th>10시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----3교시----- --%>
          <tr id="tr_11">
            <th>11시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----4교시----- --%>
          <tr id="tr_12">
            <th>12시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----5교시----- --%>
          <tr id="tr_13">
            <th>1시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----6교시----- --%>
          <tr id="tr_14">
            <th>2시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----7교시----- --%>
          <tr id="tr_15">
            <th>3시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----8교시----- --%>
          <tr id="tr_16">
            <th>4시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----9교시----- --%>
          <tr id="tr_17">
            <th>5시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
          
          <%-- -----10교시----- --%>
          <tr id="tr_18">
            <th>6시</th>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
          </tr>
        </tbody>
      </table>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

