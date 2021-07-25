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

<!-- Favicon-->
<link rel="icon" type="/image/x-icon" href="assets/favicon.ico" />

<script type="text/javascript">
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
      <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
        <FORM name='frm_login' id='frm_login' method='POST' action='/register/login.do' class="form-horizontal">
          <input type="hidden" name="productno" id="productno" value="productno">
          <input type="hidden" name="reviewno" id="reviewno" value="${param.reviewno}">
          <input type="hidden" name="memberno" id="memberno" value="${param.memberno}">
          
          
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>아이디</label>    
            <div class="col-md-8">
              <input type='text' class="form-control" name='id' id='id' 
                         value='${ck_id }' required="required" 
                         style='width: 30%;' placeholder="아이디" autofocus="autofocus">
              <Label>   
                <input type='checkbox' name='id_save' value='Y' 
                          ${ck_id_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>                   
            </div>
       
          </div>   
       
          <div class="form-group">
            <label class="col-md-4 control-label" style='font-size: 0.8em;'>패스워드</label>    
            <div class="col-md-8">
              <input type='password' class="form-control" name='passwd' id='passwd' 
                        value='${ck_passwd }' required="required" style='width: 30%;' placeholder="패스워드">
              <Label>
                <input type='checkbox' name='passwd_save' value='Y' 
                          ${ck_passwd_save == 'Y' ? "checked='checked'" : "" }> 저장
              </Label>
            </div>
          </div>   
       
          <div class="form-group">
            <div class="col-md-offset-4 col-md-8">
              <button type="button" id='btn_login' class="btn btn-primary btn-md">로그인</button>
              <button type='button' onclick="location.href='./create.do'" class="btn btn-primary btn-md">회원가입</button>
              <button type='button' id='btn_loadDefault' class="btn btn-primary btn-md">테스트 계정</button>
              <button type='button' id='btn_cancel' class="btn btn-primary btn-md"
                          onclick="$('#div_login').hide();">취소</button>
            </div>
          </div>   
          
        </FORM>
      </DIV>
      <%-- ******************** Ajax 기반 로그인 폼 종료 ******************** --%>
      
  <section class="py-5">
    <DIV class='container c_bottom_10'>
      <DIV class='title_line' style="font-weight: bold;">
        <a href="../product/read.do?productno=${param.productno }&now_page=&word=&stateno=${productVO.stateno}">
        ${productVO.title}</a> > 리뷰목록
      </DIV>
      
      <table class="table" style='width: 100%;'>
        <colgroup>
          <col style="width: 60%;"></col>
          <col style="width: 35%;"></col>
          <col style="width: 5%;"></col>
        </colgroup>
        
        <tbody>
             <c:choose>
                <c:when test="${list.size() > 0 }">
                    <c:forEach var="reviewVO" items="${list}" varStatus="status">
                      <c:set var="productno" value="${param.productno }" />
                      <c:set var="reviewno" value="${reviewVO.reviewno }" />
                      <c:set var="content" value="${reviewVO.content }" />
                      <c:set var="score" value="${reviewVO.score }" />
                      <c:set var="writer" value="${reviewVO.writer }" />
                      <c:set var="rdate" value="${reviewVO.rdate }" />
                      <c:set var="rcnt" value="${reviewVO.rcnt }" />
                      <c:set var="thumb" value="${reviewVO.thumb }" />
                      <c:set var="file1" value="${reviewVO.file1 }" />
                      <c:set var="rsize" value="${reviewVO.rsize }" />
                      
                    
                      <TR>
                        <TD class="td_bs_left" style="padding-left: 50px; padding-top:20px; " >
                          <span style="width: 25%; font-size: 1.0em; color:gray;">${writer}</span>
                          <span style="float:right; padding-right:70%; font-size: 0.9em; color:gray;">${rdate.substring(0, 16) }</span>
                          <div style="padding-top: 7px;" onclick="location.href='./read.do?reviewno=${reviewno}'">
                            <span style="color:black; font-size: 1.16em;">${content}</span>
                          </div>
                        </TD>
                        <td style='padding-left: 100px; vertical-align: middle; text-align: center;'>
                          <c:choose>
                            <c:when test="${thumb.endsWith('jpg') || thumb.endsWith('png') || thumb.endsWith('gif')}">
                              <%-- /static/contents/storage/ --%>
                              <a href="./read.do?reviewno=${reviewno}"><IMG src="/review/storage/${thumb }" style="width: 100px; height: 90px; margin-bottom: 7px;"></a><br>
                              <span style="color:gray;">평점 : <span style="color:black;">${score }</span></span>
                            </c:when>
                            <c:otherwise> <!-- 이미지가 아닌 일반 파일 -->
                              <a style="width: 80px; height: 90px;">${file1}</a>
                              <span style="margin-top: 10px; color:gray;">평점 : <span style="color:black;">${score }</span></span>
                              <span style="margin-top: 10px; color:gray;">조회 : <span style="color:black;">${rcnt }</span></span>
                            </c:otherwise>
                          </c:choose>
                        </td>
                      </TR>   
                    </c:forEach>
                 </c:when>
                 <c:otherwise>
                   <tr>
                    <td colspan="8" style="text-align: center; font-size: 1.3em;">해당 상품에 대한 리뷰가 없습니다.</td>
                   </tr>
                 </c:otherwise>
              </c:choose>
          </tbody>
      </table>
        
    </DIV><!-- container c_bottom_10 end -->
    
  </section>
  
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

