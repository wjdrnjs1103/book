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
function update_stateno(productno){
  
}

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
      <h3>${param.sender } 님의 쪽지  </h3>
    </div>
    <%-- 책에 대한 정보 표기 --%>
    <div class="page-header"></div>

    <div class="col-sm-6 col-md-offset-3" >
      <form name='frm' id='frm' style='margin-top: 50px;' action="/productno/update_stateno.do" method='post'>
        <input type='hidden' name='messageno' id='messageno' value=''>  
        <div class="form-group">
            <label for="inputName">제목</label>
            <input type="text" class="form-control" name="title" id="title" value='${messageVO.title }' disabled>
        </div>

        <div class="form-group">
            <label for="inputMobile">내용</label>
            <textarea name='contents' id='contents' required="required" class="form-control" rows="12" style='width: 100%;'disabled>${messageVO.contents }</textarea>
        </div>
  
        <div class="form-group text-center">

            <button type="button" onclick="location.href='./reply.do?send_member=${messageVO.send_member}&productno=${messageVO.productno }'" class="btn btn-primary">
               답장<i class="fa fa-times spaceLeft"></i>
            </button>
            <button type="submit" class="btn btn-warning">
               거래확인<i class="fa fa-times spaceLeft"></i>
            </button>
            <button type="button" onclick="update_stateno(${messageVO.productno})" class="btn btn-primary">
               뒤로가기<i class="fa fa-times spaceLeft"></i>
            </button>
        </div>
      </form>
    </div>
  </div> <!-- container// -->
<jsp:include page="../menu/bottom.jsp"  flush='false' />
</body>
 
</html>

