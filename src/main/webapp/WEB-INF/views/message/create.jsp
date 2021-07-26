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
  <div class="container">
    <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
      <h3>쪽지 보내기</h3>
    </div>
    <%-- 책에 대한 정보 표기 --%>
    <div class="page-header"></div>
    <h4>상품정보(추후에 스타일 정리)</h4>
    
    <c:set var="file1saved" value="${productVO.file1saved.toLowerCase() }" />
    <c:if test="${file1saved.endsWith('jpg') || file1saved.endsWith('png') || file1saved.endsWith('gif')}">
      <DIV style="width: 15%; float: left; margin-right: 20px;">
        <IMG src="/product/storage/${productVO.file1saved }" style="width: 100%;">
      </DIV>
      <DIV style="width: 47%; float: left; margin-right: 10px;">
        <span style="font-size: 1.5em; font-weight: bold;">상품명: ${productVO.title }</span><br>
      </DIV>
      <DIV style="width: 47%; float: left; margin-right: 10px;">
        <span style="font-size: 1.5em; font-weight: bold;">판매자: ${productVO.memberno }</span><br>
      </DIV>
      <DIV style="width: 47%; float: left; margin-right: 10px;">
        <span style="font-size: 1.5em; font-weight: bold;">가격: ${productVO.price }</span><br>
      </DIV>
    </c:if>

    <div class="col-sm-6 col-md-offset-3" style="float: right">
      <form name='frm' id='frm' style='margin-top: 50px;' action="./create.do" method='post'>
        <input type='hidden' name='send_member' value='${sessionScope.memberno}'>
        <input type='hidden' name='productno' value='${param.productno }'>
        <div class="form-group">
            <label for="inputName">제목</label>
            <input type="text" class="form-control" name="title" id="title" value='' placeholder="제목">
        </div>

        <div class="form-group">
            <label for="inputMobile">내용</label>
            <textarea name='contents' id='contents' required="required" class="form-control" rows="12" style='width: 100%;'>안녕하세요</textarea>
        </div>
  
        <div class="form-group text-center">
            <button type="submit" id="btn_register" class="btn btn-success">
                보내기<i class="fa fa-check spaceLeft"></i>
            </button>
            <button type="button" class="btn btn-basic">
                취소<i class="fa fa-times spaceLeft"></i>
            </button>
        </div>
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

