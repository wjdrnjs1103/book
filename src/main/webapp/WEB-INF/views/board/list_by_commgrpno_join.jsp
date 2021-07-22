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
  
    <DIV class='container c_bottom_5' > 
          <DIV class='title_line_none'>
            <a href="./list.do" class='title_link'>커뮤니티</a>
          </DIV>
          
          <div class="c_com_join">        
              <div class="c_com_join_con_t" style="border-bottom: solid 1px;">
                <a style="font-weight: bold; color:red;">조회수 </a>높은 게시글
              </div>
          </div>
          
          
          <div class="c_com_join">
              <div class="c_com_join_con_t" style="border-bottom: solid 1px;">
                <a style="font-weight: bold;" href="./list_by_commgrpno_search_paging.do?commgrpno=1&word=&now_page=1">자유게시판</a>
              </div>
              <div class="c_com_join_cont">
                  <c:forEach var="Commgrp_BoardVO" items="${list}">
                     <c:set var="commgrpno" value="${Commgrp_BoardVO.commgrpno }" />
                     <c:set var="r_name" value="${Commgrp_BoardVO.r_name }" />
                     <c:set var="title" value="${Commgrp_BoardVO.title }" />
                     <TR>
                       <TD class="td_bs">
                         <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search.do'>
                           <input type='hidden' name='commgrpno' value='${commgrpno }'> 
                           <c:if test="${commgrpno == 1}"> <%-- 커뮤니티 그룹 commgrpno=1인 자유게시판 게시글 출력하기 위해 --%>
                              <li class="td_bs_left" style="margin-bottom: 3%">${title }</li>
                           </c:if>
                             
                         </form>
                       </TD>
                     </TR>
                   </c:forEach>
              </div>
          </div>
          
          <div class="c_com_join">        
              <div class="c_com_join_con_t" style="border-bottom: solid 1px;">
                <a style="font-weight: bold;" href="./list_by_commgrpno_search_paging.do?commgrpno=2&word=&now_page=1">공지사항</a>
              </div>
              <div class="c_com_join_cont">
                  <c:forEach var="Commgrp_BoardVO" items="${list}">
                     <c:set var="commgrpno" value="${Commgrp_BoardVO.commgrpno }" />
                     <c:set var="r_name" value="${Commgrp_BoardVO.r_name }" />
                     <c:set var="title" value="${Commgrp_BoardVO.title }" />
                     <TR>
                       <TD class="td_bs">
                         <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search.do'>
                           <input type='hidden' name='commgrpno' value='${commgrpno }'> 
                           <c:if test="${commgrpno == 2}"> <%-- 커뮤니티 그룹 commgrpno=2인 공지사항 게시글 출력하기 위해 --%>
                              <li class="td_bs_left" style="margin-bottom: 3%">${title }</li>
                           </c:if>
                             
                         </form>
                       </TD>
                     </TR>
                   </c:forEach>
              </div>
          </div>
          
          <div class="c_com_join">        
              <div class="c_com_join_con_t" style="border-bottom: solid 1px;">
                <a style="font-weight: bold;" href="./list_by_commgrpno_search_paging.do?commgrpno=2&word=&now_page=1">QnA</a>
              </div>
              <div class="c_com_join_cont">
                  <c:forEach var="Commgrp_BoardVO" items="${list}">
                     <c:set var="commgrpno" value="${Commgrp_BoardVO.commgrpno }" />
                     <c:set var="r_name" value="${Commgrp_BoardVO.r_name }" />
                     <c:set var="title" value="${Commgrp_BoardVO.title }" />
                     <TR>
                       <TD class="td_bs">
                         <form name='frm' id='frm' method='get' action='./list_by_commgrpno_search.do'>
                           <input type='hidden' name='commgrpno' value='${commgrpno }'> 
                           <c:if test="${commgrpno == 3}"> <%-- 커뮤니티 그룹 commgrpno=3인 QnA 게시글 출력하기 위해 --%>
                              <li class="td_bs_left" style="margin-bottom: 3%">${title }</li>
                           </c:if>
                             
                         </form>
                       </TD>
                     </TR>
                   </c:forEach>
              </div>
          </div>
       
    </DIV>
</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />

</body>
 
</html>