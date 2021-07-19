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

<!-- CkEditor -->
<script type="text/javascript" src="/ckeditor/ckeditor.js"></script>

    
<script type="text/javascript">
  
  
  $(function(){
   /* var fileCheck = document.getElementById("file1MF").value;
   if(!fileCheck){
        alert("파일을 첨부해 주세요");
        return false;
    } */
  });

  $(function() {
	    CKEDITOR.replace('bcon');         // <TEXTAREA>태그 id 값
	    CKEDITOR.config.placeholder = ''; // placeholder 지정을 위한 설정
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
    
    <FORM name='frm' method='POST' action='./create.do' class="form-horizontal"
                enctype="multipart/form-data">
      <c:set var="writer" value="${id }" />
      <input type="hidden" name="commgrpno" value="${commgrpVO.commgrpno }"> 
      <input type="hidden" name="memberno" value="${memberno }">
      <input type="hidden" name="writer" value="${writer}">
      
<%--  <input type="hidden" name="memberno" value="${registerVO.memberno }"> --%>  
    
      <div style="text-align :center; width:100%; margin-right:15%;">
          
          <%-- Book 생성 후 bookno 가져오기 
          <div class="form-group">
            <div class="">
              <select class="input_" name="select_book" id= 'select_book' style='width:80%;'>
                  <option value=''>전공 선택</option>
                  <option value=''>기타</option>
                  <%-- <option value='${bookVO.name }'>1</option>
                  <option value=''>2</option>                   
              </select>
            </div>
          </div>
          
          <div class="form-group">
              <div>
                <input class="input_" type='text' id='writer' name='writer' value='${writer }' required="required"style='width: 15%; '>
              </div>
          </div> --%>
          
          <div class="form-group">
              <div>
                <input class="input_" type='text' name='title' value='' required="required" placeholder="제목을 입력해 주세요." style='width: 80%; '>
              </div>
          </div>
          
          <div class="form-group" style="text-align: center;">
             <div style="padding-left: 10%;">
               <textarea class="input_" name='bcon' id='bcon' required="required" contenteditable="true" placeholder="내용을 입력해주세요.">
               </textarea>
             </div>
          </div>
          
          <div class="form-group">
             <div>
               <input class="input_" type='text' name='word' placeholder="검색어를 입력해 주세요" required="required" 
                          style='width: 80%;'>
             </div>
          </div>   
          
          <div class="form-group">
             <div class="" style="margin-left: 10%;">
               <input class="input_ " type='file' class="form-control" name='file1MF' id='file1MF' style='width: 89%; color: #aaa;'
                      value='' placeholder="파일 선택">
             </div>
          </div>   
    
          <div class="content_body_bottom_right">
            <button type="submit" class="btn_gray">등록</button>
            <button type="button" onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno}&word=${param.word }&now_page=${param.now_page }'" class="btn_gray">목록</button>
          </div>
        
      </div>
    </FORM>
    
  </div>
</div>
  
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
 
</html>
 
 
 