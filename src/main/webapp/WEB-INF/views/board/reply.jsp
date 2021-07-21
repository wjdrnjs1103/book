<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="writer" value="${boardVO.writer }" />
<c:set var="commgrpno" value="${boardVO.commgrpno }" />


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

<!-- CkEditor -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

<script type="text/javascript">
  $(function() {
    CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
  });
</script> 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="py-5">

  <DIV class='container'>
    <div class="title_line">
      <h3> ${commgrpVO.name }<a style="font-size: 0.6em;">　게시글 쓰기</a></h3> 
    </div>

    <ASIDE class='aside_left'>
      ${commgrpVO.name } > ${boardVO.title } > 답변 등록
    </ASIDE>
    <ASIDE class='aside_right'>
      <A href='./list.do?boardno=${param.boardno }'>목록</A>
      <!-- <span class='menu_divide' >│</span> --> 
    </ASIDE> 
   
    
    <DIV style='width: 100%;'>
      <FORM name='frm' method='POST' action='./reply.do' class="form-horizontal"
                  enctype="multipart/form-data">
                 
        <!-- FK memberno 지정 -->
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno }'>
        <!-- FK commgrpno 지정 -->
        <input type='hidden' name='commgrpno' id='commgrpno' value='${param.commgrpno }'>
        <%-- 댓글을 붙일 부모글 번호 --%>
        <input type='hidden' name='boardno' id='boardno' value='${param.boardno }'>
        
        <div class="form-group">   
          <div class="col-md-12">
            <input type='text' class="form-control" name='title' value='' placeholder="제목" required="required" style='width: 80%;'>
          </div>
        </div>   
        
        <div class="form-group">   
          <div class="col-md-12">
            <textarea class="form-control" name='title' id='title' rows='6' placeholder="내용"></textarea>
          </div>
        </div>
        
        <div class="form-group">
           <div class="" style="margin-left: 10%;">
             <input class="input_ " type='file' class="form-control" name='file1MF' id='file1MF' style='width: 89%; color: #aaa;'
                    value='' placeholder="파일 선택">
           </div>
        </div>
  
        <div class="form-group">   
          <div class="col-md-12">
            <input type='text' class="form-control" name='web' value='' placeholder="인터넷 주소" style='width: 80%;'>
          </div>
        </div>   
        
        <div class="form-group">   
          <div class="col-md-12">
            <input type='text' class="form-control" name='word'  value='' placeholder="검색어" style='width: 90%;'>
          </div>
        </div>
  
        <div class="form-group">
           <div>
             <input class="input_" type='text' name='word' placeholder="검색어를 입력해 주세요" required="required" 
                        style='width: 80%;'>
           </div>
        </div> 
        
        <DIV class='content_bottom_menu'>
          <button type="submit" class="btn btn-info">답변 등록</button>
          <button type="button" 
                      onclick="history.back()" 
                      class="btn btn-info">취소</button>
        </DIV> 
      </FORM>
    </DIV>
    
  </DIV>
</div>

  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
 