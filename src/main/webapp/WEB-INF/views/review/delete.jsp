<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

 
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
  $(function(){
 
  });

  function delete_end(){
    alert("리뷰 삭제 완료");
  }
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />
 
<div class="py-5">

  <DIV class='container'>
    <DIV class='title_line' style="font-weight: bold;">
        <a href="../product/read.do?productno=${param.productno }&now_page=&word=&stateno=${productVO.stateno}">
        ${productVO.title}</a> > 리뷰 삭제
    </DIV>
    
    <DIV class='title_line_none'></DIV>
  
    
    <fieldset class="fieldset_basic" style="margin-bottom: 10%;">
      <ul>
        <li class="li_none">
          <DIV style='text-align: center; width: 50%; float: left;' >
            <c:set var="file1" value="${reviewVO.file1.toLowerCase() }" />
            <c:set var="thumb" value="${reviewVO.thumb }" />
            
            <c:choose> 
                <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}"> <!-- 이미지 인경우 -->
                  <IMG src="/review/storage/${thumb }" style='width: 60%; height: 300px;'>
                  <!-- 게시글 글쓴이 id 입력 -->
                </c:when>
                <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                </c:otherwise>
            </c:choose>
          </DIV>
  
          <DIV style='text-align: left; width: 47%; float: left;'>
              <FORM name='frm' method='POST' action='./delete.do'>
                <input type='hidden' name="productno" value="${reviewVO.productno }">
                <input type="hidden" name="reviewno" value="${param.reviewno }">   
                        
              
              <DIV id='panel1' style="width: 40%; text-align: center; margin: 10px auto;"></DIV>
                      
                <div class="form-group">   
                  <div class="col-md-12" style='text-align: left; '>
                  <h4 style="font-weight: bold;">삭제 되는 리뷰</h4>
                    <div style="padding-top:10px; margin:10px;">
                      <h5>작성자 : ${reviewVO.writer }</h5>
                      <h5>평점 : ${reviewVO.score }</h5>
                      <h5>내용 : ${reviewVO.content }</h5>
                      <h6 style="color: #BEBEBE;">첨부파일 : ${file1 }</h6>
                    </div>
                    <div style="margin:10px; margin-top:30px; text-align: left; font-size: 1.1em;">
                      <h4 style="margin-bottom: 15px;">삭제하시면 복구 할 수 없습니다.</h4>
                     
                      <button id="delete_complete" type="submit" class="btn btn-info" onclick="delete_end()">삭제 진행</button>
                      <button type = "button" onclick = "history.back()" class="btn btn-info">취소</button>
                    </div>
                  </div>
                </div>    
            </FORM>
          </DIV>
        </li>
        <li class="li_none">
  s
        </li>   
      </ul>
    </fieldset>

  </DIV>
</div>
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 