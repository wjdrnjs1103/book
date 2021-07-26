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
  var classno_arr = [];
  var classname_arr = [];
  var starttime_arr = [];
  var endtime_arr = [];
  var cday_arr = [];
  var params = "";
  console.log(classno_arr );
  params = 'memberno=' + <%=(int)session.getAttribute("memberno")%>
  // console.log("params", params);
  $(function() {
    $('#btn_update_cancel').on('click', cancel);
    $('#btn_delete_cancel').on('click', cancel);
  });

  function cancel() {
    $('#panel_create').css("display","");  
    $('#panel_update').css("display","none"); 
    $('#panel_delete').css("display","none");
  }
  
  window.addEventListener('load', load(params));  // 페이지 이동되자마자 load함수실행
  function load(params){
    $.ajax(
        {
          url: '/schedule/load.do',
          type: 'get',  // get, post
          cache: false, // 응답 결과 임시 저장 취소
          async: true,  // true: 비동기 통신
          dataType: 'json', // 응답 형식: json, html, xml...
          data: params,      // 데이터
          success: function(rdata) {
            for (key in rdata){
              classno_arr[key] = rdata[key].classno;
              classname_arr[key] = rdata[key].classname;
              starttime_arr[key] = rdata[key].starttime;
              endtime_arr[key] = rdata[key].endtime;
              cday_arr[key] = rdata[key].cday;
            }
            
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            console.log(error);
          }
        }
      );  //  $.ajax END
  }
  
  function create(memberno) {
    var frm_create = $('#frm_create');
    
    var memberno = $('#memberno', frm_create).val();
    var cday = $('#cday', frm_create).val();
    var starttime = $('#starttime', frm_create).val();
    var endtime = $('#endtime', frm_create).val();
    var professor = $('#professor', frm_create).val();
    var textbook = $('#textbook', frm_create).val();
    var classname = $('#classname', frm_create).val();   
 
    if(classname == 0) {
      alert("강의명을 입력해주세요");
      return;
    } else if (professor == 0) {
      alert("교수를 입력해주세요");
      return;
    } else if(isCross(starttime, endtime)==false) {
      alert("시간설정을 다시해주세요");
      return;
    } else {
      if(isOverlap(starttime, endtime, cday)==false) {
        console.log("isOverlap 요일교차체크");
        alert("해당 요일에 겹치는 강의가 있습니다.");
        return;
      } else {
        alert("강의가 등록되었습니다. 시간표 불러오기를 통해 확인해주세요.");
        frm_create.submit();
      }
    }
   
  }
  
  function isOverlap(starttime, endtime, cday) {
    console.log("isOverlap 함수진입");
    for(var i =0;  i<classno_arr.length; i++){
      classno_arr[i]; 
      cday_arr[i];
      starttime_arr[i];
      endtime_arr[i];
      
      for (cday_arr[i]; cday_arr[i]<5; cday_arr[i]++){
        if(cday == cday_arr[i]){
          if(starttime < endtime_arr[i]){
            console.log("입력된 요일", cday);
            console.log("비교군 요일", cday_arr[i]);
            console.log("입력된 starttime", starttime);
            console.log("입력된 endtime", endtime);
            console.log("비교군 starttime", starttime_arr[i]);
            console.log("비교군 endtime", endtime_arr[i]);
            return false;
          } else if(starttime_arr[i] > endtime) {
            return false;
          } else {
            break;
          }
          break;
        }
        break;
      }
    }
    return true;
  }

  function isCross(starttime, endtime) {
    console.log("isCross 함수진입");
    if (Number(starttime) >= Number(endtime)) {
      return false;
    } else {
      return true;
    }
  }
  
  // 수정폼
  function read_update_ajax(classno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김 
    $('#panel_delete').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display",""); // show, 숨겨진 태그 출력 
    
    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'classno=' + classno; // 공백이 값으로 있으면 안됨.

    $.ajax(
      {
        url: '/schedule/read_ajax.do',
        type: 'get',   // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,  // 데이터
        success: function(rdata) { 
          var classno = rdata.classno;
          var classname = rdata.classname;
          var starttime = rdata.starttime;
          var endtime = rdata.endtime;
          var professor = rdata.professor;
          var textbook = rdata.textbook;
          var cday = rdata.cday;

          var frm_update = $('#frm_update');
          $('#classno', frm_update).val(classno);
          $('#classname', frm_update).val(classname);
          $('#starttime', frm_update).val(starttime);
          $('#endtime', frm_update).val(endtime);
          $('#professor', frm_update).val(professor);
          $('#textbook', frm_update).val(textbook);
          $('#cday', frm_update).val(cday);
          
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  } 

  // 삭제 폼(자식 레코드가 없는 경우의 삭제)
  function read_delete_ajax(classno) {
    $('#panel_create').css("display","none"); // hide, 태그를 숨김
    $('#panel_update').css("display","none"); // hide, 태그를 숨김  
    $('#panel_delete').css("display",""); // show, 숨겨진 태그 출력 

    var params = "";
    // params = $('#frm').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params = 'classno=' + classno; // 공백이 값으로 있으면 안됨.
    
    $.ajax(
      {
        url: '/schedule/read_ajax.do',
        type: 'get',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) {
          var frm_delete = $('#frm_delete');
          $('#classno', frm_delete).val(classno);
          
          var frm_delete = $('#frm_delete');
          $('#classno', frm_delete).val(classno);
          
          

        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END

  } 
  
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />
 
 
 <section class="py-5">

  <DIV class='container c_bottom_10'> 
    <DIV class='title_line'>
      <a href="/schedule/schedule.do?memberno=${memberno }" class='link-primary'>시간표</a>
    </DIV>
          
    <!-- 등록 -->
    <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
      <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
        <label>강의명</label>
        <input type='text' name='classname' id='classname' value='' required="required" style='width: 10%;'
                   autofocus="autofocus">
        <label>요일</label>
        <select name="cday" id='cday' value='' required="required" style='width: 10%;'>
          <option value="0">월요일</option>
          <option value="1">화요일</option>
          <option value="2">수요일</option>
          <option value="3">목요일</option>
          <option value="4">금요일</option>
        </select>
        <label>교수</label>
        <input type='text' name='professor' id='professor' value='' required="required" style='width: 10%;'>
        <label>교재</label>
        <input type='text' name='textbook' id='textbook' value='' style='width: 10%;'>
        <label>시작시간</label>
        <input type='number' name='starttime' id='starttime' value='9' required="required" 
                  min='9' max='18' step='1' style='width: 5%;'>
        <label>종료시간</label>
        <input type='number' name='endtime' id='endtime' value='18' required="required" 
                  min='9' max='19' step='1' style='width: 5%;'>
          
        <button type="button" onclick="create(${sessionScope.memberno})" class="btn btn-dark">저장</button>
      </FORM>
    </DIV>
    
    <!-- 강의 수정 -->
    <DIV id='panel_update' 
                  style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; 
                            text-align: center; display: none;'>
      <FORM name='frm_update' id='frm_update' method='POST' action='./update.do'>
        <input type='hidden' name='memberno' id='memberno' value='${sessionScope.memberno}'>
        <input type='hidden' name='classno' id='classno' value='${scheduleVO.classno}'>
        <label>강의명</label>
        <input type='text' name='classname' id='classname' value='' required="required" style='width: 10%;'>
        <label>요일</label>
        <input type='text' name='cday' id='cday' value='' required="required" style='width: 10%;'>
        <label>교수</label>
        <input type='text' name='professor' id='professor' value='' required="required" style='width: 10%;'>
        <label>교재</label>
        <input type='text' name='textbook' id='textbook' value='' style='width: 10%;'>
        <label>시작시간</label>
        <input type='number' name='starttime' id='starttime' value='9' required="required" 
                  min='9' max='18' step='1' style='width: 5%;'>
        <label>종료시간</label>
        <input type='number' name='endtime' id='endtime' value='18' required="required" 
                  min='9' max='18' step='1' style='width: 5%;'>
          
        <button type="submit" class="btn btn-dark">저장</button>
        <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
      </FORM>
    </DIV>
  
    <%-- 삭제 --%>
    <DIV id='panel_delete' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; 
                  width: 100%; text-align: center; display: none;'>
      <div class="msg_warning">강의를 삭제하시겠습니까?</div>
      <FORM name='frm_delete' id='frm_delete' method='POST' action='./delete.do'>
        <input type='hidden' name='classno' id='classno' value=''>
          
        <label>강의 이름</label><span id='frm_delete_classname'></span>  
        <label>번호</label>: <span id='frm_delete_classno'></span>
         
        <button type="submit" id='submit' class="btn btn-dark">삭제</button>
        <button type="button" onclick="cancel();"  class="btn btn-dark">취소</button>
      </FORM>
    </DIV>
      
     <TABLE class='table mt-5'>
        <colgroup>
          <col style='width: 10%;'/>
          <col style='width: 20%;'/>
          <col style='width: 10%;'/> 
          <col style='width: 10%;'/> 
          <col style='width: 10%;'/>
          <col style='width: 10%;'/>
          <col style='width: 20%;'/>
          <col style='width: 10%;'/>
        </colgroup>
       
        <thead>  
         <TR class="table_title">
          <TH class="th_bs">강의번호</TH>
          <TH class="th_bs">강의명</TH>
          <TH class="th_bs">시작시간</TH>
          <TH class="th_bs">종료시간</TH>
          <TH class="th_bs">요일</TH>
          <TH class="th_bs">교수</TH>
          <TH class="th_bs">교제</TH>
          <TH class="th_bs">기타</TH>
        </TR>
        </thead>
      
        <tbody>
        <c:forEach var="scheduleVO" items="${list }">
          <TR>
            <TD class="td_bs">${scheduleVO.classno }</TD>
            <TD class="td_bs">${scheduleVO.classname }</TD>
            <TD class="td_bs">${scheduleVO.starttime }</TD>
            <TD class="td_bs">${scheduleVO.endtime }</TD>
            <TD class="td_bs">
            <c:choose>
              <c:when test="${scheduleVO.cday eq 0}"> 월요일</c:when>
              <c:when test="${scheduleVO.cday eq 1}"> 화요일</c:when>
              <c:when test="${scheduleVO.cday eq 2}"> 수요일</c:when>
              <c:when test="${scheduleVO.cday eq 3}"> 목요일</c:when>
              <c:when test="${scheduleVO.cday eq 4}"> 금요일</c:when>
            </c:choose>
            </TD>
            <TD class="td_bs">${scheduleVO.professor }</TD>
            <TD class="td_bs">
              <c:choose>
                <c:when test="${scheduleVO.textbook ==''}" >
                  <A href="/bookgrp/list.do" style="color: #FF0000">미등록</A>
                </c:when>
                <c:otherwise>
                  ${scheduleVO.textbook }
                </c:otherwise>
              </c:choose>
            </TD> 
            <TD class="td_bs">
              <A href="javascript: read_update_ajax(${scheduleVO.classno })" title="수정"><span class="glyphicon glyphicon-pencil"></span></A>
              <A href="javascript: read_delete_ajax(${scheduleVO.classno })" title="삭제"><span class="glyphicon glyphicon-trash"></span></A>  
            </TD>   
          </TR>   
        </c:forEach> 
        </tbody>
    </TABLE>
    <button class="btn btn-primary" style="float: right;" onclick="location.href='/schedule/schedule.do?memberno=${memberno }'" >시간표</button>
  </DIV>
</section>


 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

