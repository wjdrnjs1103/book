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
 
<style type="text/css">
*{margin:0; padding:0;}
.star{
  display:inline-block;
  width: 55px;
  height: 60px;
  cursor: pointer;
}
.star{
  background: url(http://gahyun.wooga.kr/main/img/testImg/star.png) no-repeat 0px 0; 
  background-size: 55px; 
  margin-right: -3px;
}

.star.on{
  background-image: url(http://gahyun.wooga.kr/main/img/testImg/star_on.png);
}
</style>

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
  $(".star").on('click',function(){
	   var idx = $(this).index();
	   $(".star").removeClass("on");
	     for(var i=0; i<=idx; i++){
	        $(".star").eq(i).addClass("on");
	   }
	 });    
});

function star1(){
    $('#score').attr('value', 1);
}

function star2(){
	  $('#score').attr('value', 2);
}

function star3(){
    $('#score').attr('value', 3);
}

function star4(){
    $('#score').attr('value', 4);
}

function star5(){
    $('#score').attr('value', 5);
}



</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

  <div class="container">
    <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
      <h3 style="font-weight: bold;">새로운 리뷰 쓰기</h3>
    </div>
    <div class="page-header"></div>

    <div class="col-sm-6 col-md-offset-3">
      <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
                enctype="multipart/form-data">        
        <c:set var="writer" value="${id }" />
        <input type="hidden" name="productno" value="${param.productno }"> 
        <input type="hidden" name="memberno" value="${memberno}">
        <input type="hidden" name="writer" value="${writer}">
        
        <div class="form-group" >
            <label for="inputName">리뷰 상품 이름 : </label>
            <span style='font-weight:bold; width: 100%;'>${productVO.title}</span><span style="color:gray; font-size: 0.8em;"> (상품 번호: ${param.productno})</span>
        </div>
        
        <div class="form-group" >
            <span style="font-weight:bold;">별점과 리뷰를 남겨주세요.<span style="font-size: 0.8em; color:gray;"> (별 1개당, 1점)</span></span>　
            <input type="hidden" id="score" name="score" value=1 min=1 max=5 step=1></input><br> 
            <!-- <p id="score" class="star_rating">
                <a href="" class="input_score()" id="star1">★</a>
                <a href="" class="input_score()" id="star2">★</a>
                <a href="" class="input_score()" id="star3">★</a>
                <a href="" class="input_score()" id="star4">★</a>
                <a href="" class="input_score()" id="star5">★</a>
            </p>-->
            <div class="star-box">
              <span class="star on" onclick="star1()"></span>         
              <span class="star" onclick="star2()"></span>
              <span class="star" onclick="star3()"></span>
              <span class="star" onclick="star4()"></span>
              <span class="star" onclick="star5()"></span>
            </div>
        </div>
                

        <div class="form-group" >
         <div class="review_contents">
            <div class="warning_msg">5자 이상으로 작성해 주세요.</div>
            <textarea style="width:100%;" rows="12" class="input_" name='content' id='content' required="required"></textarea>
         </div>
        </div>
        
        <div class="form-group" >
             <label for="inputName">파일 첨부</label><br>
             <input class="input_ " type='file' class="form-control" name='file1MF' id='file1MF' style='width: 100.1%; color: #aaa;'
                    value='' placeholder="파일 선택">
        </div>   
        
        <div class="content_body_bottom" style="margin-left: 15px;">
            <button type="submit" class="btn_gray">저장</button>
        </div>    
         <!--
        <button type="button" onclick="location.href='./list_by_productno.do?productno=${productno}'" class="btn_gray">목록</button>
        
        <div class="form-group text-center">
            <button type="submit" id="btn_register" class="btn btn-primary">
                보내기<i class="fa fa-check spaceLeft"></i>
            </button>
            <button type="button" class="btn btn-warning">
                취소<i class="fa fa-times spaceLeft"></i>
            </button>
        </div> -->
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

