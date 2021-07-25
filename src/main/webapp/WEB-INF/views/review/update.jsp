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
$(function() {
	$('.starRev span').click(function(){
	    $(this).parent().children('span').removeClass('on');
	    $(this).addClass('on').prevAll('span').addClass('on');
	    return false;
	});
});



</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

  <div class="container">
    <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
      <h3 style="font-weight: bold;">리뷰 수정</h3>
    </div>
    <div class="page-header"></div>

    <div class="col-sm-6 col-md-offset-3">
      <FORM name='frm' method='POST' action='./update.do' class="form-horizontal"
                enctype="multipart/form-data">   
        <input type="hidden" name="productno" value="${reviewVO.productno }"> 
        <input type="hidden" name="reviewno" value="${reviewVO.reviewno}">
        
        <div class="form-group" >
            <label for="inputName">리뷰 상품 이름 : </label>
            <span style='font-weight:bold; width: 100%;'>${productVO.title}</span><span style="color:gray; font-size: 0.8em;"> (상품 번호: ${reviewVO.productno})</span>
        </div>
        
        <div class="form-group" >
            <span >별점과 리뷰를 남겨주세요.</span><br>
            <div class="starRev" >
              <input style="margin: 6px; "type="number" min=1 max=5 name="score" id="score" value="${reviewVO.score }">
              <span class="starR1 on">별1_왼쪽</span>
              <span class="starR2">별1_오른쪽</span>
              <span class="starR1">별2_왼쪽</span>
              <span class="starR2">별2_오른쪽</span>
              <span class="starR1">별3_왼쪽</span>
              <span class="starR2">별3_오른쪽</span>
              <span class="starR1">별4_왼쪽</span>
              <span class="starR2">별4_오른쪽</span>
              <span class="starR1">별5_왼쪽</span>
              <span class="starR2">별5_오른쪽</span>
            </div>
        </div>
                

        <div class="form-group" >
         <div class="review_contents">
            <div class="warning_msg">5자 이상으로 작성해 주세요.</div>
            <textarea style="width:100%;" rows="12" class="input_" name='content' id='content' required="required">${reviewVO.content }</textarea>
         </div>
        </div>
        
        <div class="form-group" >
             <DIV style='text-align: center; margin-left: 2%; width: 15%; float: left;'>
                    <c:set var="file1" value="${reviewVO.file1.toLowerCase() }" />
                    <c:set var="thumb" value="${reviewVO.thumb }" />
                    <c:choose>
                      <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}">
                        <IMG src="/review/storage/${file1 }" style='width: 70%;'> 
                      </c:when>
                      <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                        <img src='/review/images/bin-file.png' style="width: 30%;">
                      </c:otherwise>
                    </c:choose>
             </DIV>
             <div>
               <input class="input_ " type='file' class="form-control" name='file1MF' id='file1MF' style='color: #aaa; margin-top: 20px; width: 82%;'
                      value='' placeholder="파일 선택">
             </div>
        </div>   
        
        <div class="content_body_bottom" style="margin-left: 15px;">
            <button type="submit" class="btn_gray">저장</button>
        </div>    
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

