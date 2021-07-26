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
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>
<script type="text/javascript">
  // window.onload=function(){
  //  CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  // };
  
  $(function() {
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  });

  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 

<div class="py-5">

    <DIV class='container c_bottom_10'>
<DIV class='title_line'>
  <A href="../bookgrp/list.do" class='title_link'>전공도서 그룹</A> > 
  ${bookgrpVO.name } > ${bookVO.name } >
  글 등록
</DIV>

<DIV class='content_body'>
  <ASIDE class="aside_right">
    <A href="./create.do?bookno=${bookVO.bookno }">등록</A>
    <span class='menu_divide' >│</span>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span>
    <A href="./list_by_bookno_search_paging.do?bookno=${bookVO.bookno }">기본 목록형</A>    
    <span class='menu_divide' >│</span>
    <A href="./list_by_bookno_grid.do?bookno=${bookVO.bookno }">갤러리형</A>
  </ASIDE> 
  
    <DIV style="text-align: right; clear: both;">  
    <form name='frm' id='frm' method='get' action='./list_by_bookno_search.do'>
      <input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
      <input type='hidden' name='bookno' value='${bookVO.bookno }'>
      <c:choose>
        <c:when test="${param.word != '' }"> <%-- 검색하는 경우 --%>
          <input type='text' name='word' id='word' value='${param.word }' style='width: 20%;'>
        </c:when>
        <c:otherwise> <%-- 검색하지 않는 경우 --%>
          <input type='text' name='word' id='word' value='' style='width: 20%;'>
        </c:otherwise>
      </c:choose>
      <button type='submit' class="btn btn-dark" style="font-size: 0.9em;">검색</button>
      <c:if test="${param.word.length() > 0 }">
        <button type='button' 
                     onclick="location.href='./list_by_bookno_search.do?bookno=${bookVO.bookno}&word='">검색 취소</button>  
      </c:if>    
    </form>
  </DIV>
  
  <DIV class='menu_line'></DIV>
  
  <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
              enctype="multipart/form-data">
    <input type="hidden" name="bookgrpno" value="${bookVO.bookgrpno }"> 
    <input type="hidden" name="bookno" value="${param.bookno }">
    <input type="hidden" name="memberno" value='${sessionScope.memberno }'> <%-- 관리자 개발후 변경 필요 --%>
    
    <div class="form-group">
       <label class="control-label col-md-2">도서명</label>
       <div class="col-md-10">
         <input type='text' name='title' value='전공서적의 제목을 기입해주세요.' required="required" 
                   autofocus="autofocus" class="form-control" style='color: #888888; width: 100%;'>
       </div>
    </div>
    <div class="form-group">
       <label class="control-label col-md-2">도서설명</label>
       <div class="col-md-10">
         <textarea name='content' id='content' required="required" class="form-control" rows="12" style='color: #888888; width: 100%;'>전공서적에 대한 정보(책의 상태, 출판사, 발행년도 등)를 기입해주세요.</textarea>
       </div>
    </div>
 
    <div class="form-group">
       <label class="control-label col-md-2">검색어</label>
       <div class="col-md-10">
         <input type='text' name='word' value='컴퓨터,1학년,소프트웨어,전공' required="required" 
                    class="form-control" style='color: #888888; width: 100%;'>
       </div>
    </div>   
    
     <div class="form-group">
       <label class="control-label col-md-2">판매가</label>
       <div class="col-md-10">
         <input type='number' name='price' required="required"
                    min="0" max="10000000" step="500" 
                    class="form-control" style='width: 100%;'>
       </div>
    </div>   
    
    <div class="form-group">
       <label class="control-label col-md-2">이미지</label>
       <div class="col-md-10">
         <input type='file' class="form-control" name='file1MF' id='file1MF' 
                    value='' placeholder="파일 선택">
       </div>
    </div>   
    
    <div class="content_body_bottom">
      <button type="submit" class="btn btn-dark">등록</button>
      <button type="button" onclick="location.href='./list_member.do?bookno=${bookno }&now_page=1'" class="btn btn-dark">목록</button>
    </div>
  
  </FORM>
</DIV>
</DIV>
</DIV>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>

