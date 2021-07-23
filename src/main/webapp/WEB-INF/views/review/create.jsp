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
      <h3>리뷰 쓰기</h3>
    </div>
    <div class="page-header"></div>

    <div class="col-sm-6 col-md-offset-3">
      <form name='frm' id='frm' style='margin-top: 50px;' action="/review/create.do" method='post'>
        <input type='hidden' name='productno' value='${param.productno }'>
        <input type='hidden' name='memberno' value='${sessionScope.memberno }'>
        
        <div class="form-group">
            <label for="inputName"></label>
            <input type="text" class="form-control" name="title" id="title" value='' placeholder="제목">
        </div>

        <div class="form-group">
            <label for="inputMobile">내용</label>
            <textarea name='content' id='content' required="required" class="form-control" rows="12" style='width: 100%;'>내용</textarea>
        </div>
  
        <div class="form-group text-center">
            <button type="submit" id="btn_register" class="btn btn-primary">
                보내기<i class="fa fa-check spaceLeft"></i>
            </button>
            <button type="button" class="btn btn-warning">
                취소<i class="fa fa-times spaceLeft"></i>
            </button>
        </div>
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

