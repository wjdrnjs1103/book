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
 
<!-- /static 기준, Core theme CSS (includes Bootstrap)-->
<link href="../css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
 
<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />


<script type="text/javascript">
 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

<div class="py-5">
  
     <DIV class='container c_bottom_10' style=""> 
        <DIV class='title_line'>
          <a href="./list.do" class='title_link'>커뮤니티</a>
        </DIV>         
          
        <TABLE class='table table_top_margin'>
          <colgroup>
            <col style='width: 15%;'/>
            <col style='width: 60%;'/>
            <col style='width: 25%;'/>
          </colgroup>
         
          <thead>  
            <TR class="table_title">
              <TH class="th_bs">게시판 번호</TH>
              <TH class="th_bs">이름</TH>
              <TH class="th_bs">등록일</TH>
            </TR>
          </thead>
          
          <tbody  style="font-size: 1.1em;">
          <c:forEach var="commgrpVO" items="${list}">
            <c:set var="commgrpno" value="${commgrpVO.commgrpno }" />
            <TR style="height: 50px;">
              <TD class="td_bs" style="padding-top: 12px;">${commgrpVO.seqno }</TD>
              <TD class="td_bs_left" style="font-weight: bold; padding-top: 12px;">
                 <A href="../board/list_by_commgrpno_search_paging.do?commgrpno=${commgrpno}&word=&now_page=1">${commgrpVO.name }</A>
              </TD>
              <TD class="td_bs" style="padding-top: 12px;">${commgrpVO.rdate.substring(0, 10) }</TD>
                 
            </TR>   
          </c:forEach> 
          </tbody>
         
        </TABLE>
      </DIV>
</div>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

