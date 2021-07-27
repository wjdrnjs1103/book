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
function read_delete_ajax(messageno) {
  var params = "";
  // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
  params = 'messageno=' + messageno; // 공백이 값으로 있으면 안됨.


  if(window.confirm("삭제 하시겠습니까?")) { // 확인 
    $.ajax(
        {
          url: '/message/read_ajax.do',
          type: 'get',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) { // 응답이 온경우, Spring에서 하나의 객체를 전달한 경우 통문자열
            // {"bookgrpno":1,"visible":"Y","seqno":1,"rdate":"2021-04-08 17:01:28","name":"문화"}
            var messageno = rdata.messageno;
            var title = rdata.title;
            var send_member = rdata.send_member;
            var s_date = rdata.s_date;
            
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END
        
  } else {
    
  }
   
  
  // $('#span_animation').css('text-align', 'center');
  // $('#span_animation').html("<img src='/contents/images/ani04.gif' style='width: 8%;'>");
  // $('#span_animation').show(); // 숨겨진 태그의 출력
} 
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
  <div class="container">
    <div class="col-md-6 col-md-offset-3" style="text-align: center;">                        
      <h3>${scheduleVO.classname }  </h3>
    </div>
    <%-- 책에 대한 정보 표기 --%>
    <div class="page-header"></div>

    <div class="col-sm-6 col-md-offset-3" >
      <form name='frm' id='frm' style='margin-top: 50px;' action="/product/update_stateno.do" method='post'>
        <input type='hidden' name='classno' id='classno' value=${scheduleVO.classno }> 
        <div class="form-group">
            <label for="inputName">시작 시간</label>
            <input type="text" class="form-control" name="starttime" id="starttime" value='${scheduleVO.starttime }' disabled>
        </div>
        <div class="form-group">
            <label for="inputName">종료 시간</label>
            <input type="text" class="form-control" name="endtime" id="endtime" value='${scheduleVO.endtime }' disabled>
        </div>
        
        <div class="form-group">
            <label for="inputMobile">강의일</label>
            <c:choose>
              <c:when test="${scheduleVO.cday == 0 }">
                <input type="text" class="form-control" name="cday" id="cday" value='월요일' disabled>
              </c:when>
              <c:when test="${scheduleVO.cday == 1 }">
                <input type="text" class="form-control" name="cday" id="cday" value='화요일' disabled>
              </c:when>
              <c:when test="${scheduleVO.cday == 2 }">
                <input type="text" class="form-control" name="cday" id="cday" value='수요일' disabled>
              </c:when>
              <c:when test="${scheduleVO.cday == 3 }">
                <input type="text" class="form-control" name="cday" id="cday" value='목요일' disabled>
              </c:when>
              <c:when test="${scheduleVO.cday == 4 }">
                <input type="text" class="form-control" name="cday" id="cday" value='금요일' disabled>
              </c:when>
            </c:choose>
        </div>

        <div class="form-group">
            <label for="inputMobile">교재</label>
            <c:choose> 
              <c:when test='${scheduleVO.textbook == "" }'>
                <input type="text" class="form-control" name="textbook" id="textbook" value='미등록' disabled>
                <button type="button" class="btn btn-primary" onclick="location.href='./list.do?memberno=${sessionScope.memberno }'">등록하기</button>
              </c:when>
              <c:otherwise>
                <input type="text" class="form-control" name="textbook" id="textbook" value='${scheduleVO.textbook }' disabled>
              </c:otherwise>
            </c:choose>
        </div>
        
        <div class="form-group">
            <label for="inputMobile">교수</label>
            <input type="text" class="form-control" name="title" id="title" value='${scheduleVO.professor }' disabled>
        </div>
 
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

