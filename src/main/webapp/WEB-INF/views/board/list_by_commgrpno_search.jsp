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
  
    <DIV class='container'> 
        <DIV class='title_line_none'>자유게시판</DIV>
  
          
        <TABLE class='table table_top_margin'>
          <colgroup>
            <col style='width: 10%;'/>
            <col style='width: 60%;'/>
            <col style='width: 10%;'/> 
            <col style='width: 10%;'/> 
            <col style='width: 10%;'/>
          </colgroup>
         
          <thead>  
            <TR class="table_title">
              <TH class="th_bs">번호</TH>
              <TH class="th_bs">제목</TH>
              <TH class="th_bs">작성자</TH>
              <TH class="th_bs">작성일</TH>
              <TH class="th_bs">조회수</TH>
            </TR>
          </thead>
          
          <tbody>
            <c:forEach var="boardVO" items="${list}">
              <c:set var="commgrpno" value="${boardVO.commgrpno }" />
              <TR>
                <TD class="td_bs">${boardVO.boardno }</TD>
                <TD class="td_bs_left">
                  <A href="../comm/list_by_commgrpno.do?commgrpno=${commgrpno }">${boardVO.title }</A>
                </TD>
                <TD class="td_bs_left">작성자:${boardVO.memberno }</TD>
                <TD class="td_bs">${boardVO.brdate.substring(0, 10) }</TD>
                <TD class="td_bs">${boardVO.bcnt}</TD>
               
              </TR>   
            </c:forEach> 
          </tbody>
          
        </TABLE>
        
        <%-- 검색 --%>  
        <div class="content_body_bottom_center">
          <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search.do'>
            <input type='hidden' name='commgrpno' value='${param.commgrpno }'>
            
            <c:choose>
              <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
              </c:when>
              <c:otherwise> <%-- 검색하지 않는 경우 --%>
                <input class="input_search_word_" type='text' name='word' id='word' value='' style='width: 20%;'>
              </c:otherwise>
            </c:choose>
            
            <button type='submit' class="btn_gray margin_l_10">검색</button>
            
            <c:if test="${param.word.length() > 0 }">
              <button type='button' class="btn_gray"
                           onclick="location.href='./list_by_commgrpno_search.do?commgrpno=${commgrpVO.commgrpno}&word='">검색 취소</button>  
            </c:if>    
          </form>
        </div>
        
        
    </DIV>
</div>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

