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
  
      <DIV class='container2'> 
        <DIV class='title_line'>전공도서 그룹</DIV>
      </DIV>

      <DIV class='container2'>
        <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
          <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
            <label>그룹 이름</label>
            <input type='text' name='name' value='' required="required" style='width: 25%;'
                       autofocus="autofocus">
        
            <label>순서</label>
            <input type='number' name='seqno' value='1' required="required" 
                      min='1' max='1000' step='1' style='width: 5%;'>
        
             
            <button type="submit" id='submit'>등록</button>
            <button type="button" onclick="cancel();">취소</button>
          </FORM>
        </DIV>
         
          
        <TABLE class='table table-striped'>
          <colgroup>
            <col style='width: 15%;'/>
            <col style='width: 40%;'/>
            <col style='width: 20%;'/> 
            <col style='width: 25%;'/>
          </colgroup>
         
          <thead>  
          <TR>
            <TH class="th_bs">출력 순서</TH>
            <TH class="th_bs">이름</TH>
            <TH class="th_bs">그룹 생성일</TH>
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
                <A href="./read_update.do?bookgrpno=${bookgrpno }" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
                <A href="./read_delete.do?bookgrpno=${bookgrpno }" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>
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

