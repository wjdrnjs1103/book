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

<script type="text/javascript">
  $(function(){
 
  });
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 

<div class="py-5">

    <DIV class='container2'>
      <div class="title_line">전공도서 그룹  > 알림</div>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${cnt == 1}">
          <LI class='li_none'>
            <span class="span_success">새로운 전공도서 그룹 [${bookgrpVO.name }]을 등록했습니다.</span>
          </LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none_left'>
            <span class="span_fail">새로운 전공도서 그룹 [${bookgrpVO.name }] 등록에 실패했습니다.</span>
          </LI>
          <LI class='li_none_left'>
            <span class="span_fail">다시 시도해주세요.</span>
          </LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <button type='button' onclick="location.href='./create.do'" class="btn">새로운 전공도서 그룹 등록</button>
        <button type='button' onclick="location.href='./list.do'" class="btn">목록</button>
      </LI>
    </UL>
  </fieldset>

</DIV>
</DIV>
</DIV>

<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>

</html>