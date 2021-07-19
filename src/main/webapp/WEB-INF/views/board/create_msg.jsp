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

</head> 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="py-5">

  <DIV class='container'>
    <DIV class='title_line'>알림</DIV>
    
    <DIV class='title_line_none'></DIV>
    
    <DIV class='message' style="background: white;">
      <fieldset class='fieldset_basic' style="margin-bottom: 22%;">
      
        <UL>
          <c:choose>
            <c:when test="${param.cnt == 1}">
              <LI class='li_none'>
                <span class="span_success">새로운 게시글 등록했습니다.</span>
              </LI>
            </c:when>
            <c:otherwise>
              <LI class='li_none_left'>
                <span class="span_fail">새로운 자료 등록에 실패했습니다.</span>
              </LI>
              <LI class='li_none_left'>
                <span class="span_fail">다시 시도해주세요.</span>
              </LI>
            </c:otherwise>
           </c:choose>
        </UL>
        <div style="width: 100%;">
          <UL >
             <LI class='li_none2' style=" width: 24.5%; float: left; margin-left: 27%;">
                <c:choose>
                  <c:when test="${param.cnt == 1 }">
                    <button type='button' style="width: 100%;"
                                 onclick="location.href='./create.do?commgrpno=${param.commgrpno }'"
                                 class="btn_gray">새로운 게시글 등록</button>
                  </c:when>
                  <c:otherwise>
                    <button type='button' onclick="history.back();" class="btn_gray">다시 시도</button>
                  </c:otherwise>
                </c:choose>
              </LI>
                
              <LI class='li_none2' style="width: 20%; float:right; margin-right: 28%;">
                <c:choose>
                  <c:when test="${param.commgrpno == 1}">
                    <button type='button' onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=1&word=${param.word}&now_page=1'" class="btn_gray">게시판 목록</button>
                  </c:when>
                  <c:when test="${param.commgrpno == 2}">
                    <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=2&word=${param.word}&now_page=1'" class="btn_gray">공지사항 목록</button>
                  </c:when>
                  <c:otherwise>
                    <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=3&word=${param.word}&now_page=1'" class="btn_gray">QnA 목록</button>
                  </c:otherwise>
                </c:choose>
              </LI>
        </UL>
        </div>
      </fieldset>
    
    </DIV>
  </DIV>
</div>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>


