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
      <div class="title_line">전공도서 그룹  > 등록</div>
    
      <FORM name='frm' method='POST' action='./create.do' class="form-horizontal">
        <div class="form-group">
           <label class="control-label col-md-4">전공도서 그룹 이름</label>
           <div class="col-md-8">
             <input type='text' name='name' value='' required="required" placeholder="이름"
                        autofocus="autofocus" class="form-control" style='width: 50%;'>
           </div>
        </div>
        
        <div class="form-group">
           <label class="control-label col-md-4">출력 순서</label>
           <div class="col-md-8">
             <input type='number' name='seqno' value='1' required="required" 
                       placeholder="출력 순서" min="1" max="1000" step="1" 
                       style='width: 30%;' class="form-control" >
           </div>
        </div>  
      
      
        <div class="content_body_bottom" style="padding-right: 15%;" >
          <button type="submit" class="btn btn_gray">등록</button>
          <button type="button" onclick="location.href='./list.do'" class="btn btn_gray">목록</button>
        </div>
      
      </FORM>
  
    </div>
</div>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 