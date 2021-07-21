<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<c:set var="writer" value="${boardVO.writer }" />
<c:set var="commgrpno" value="${boardVO.commgrpno }" />
<c:set var="boardno" value="${param.boardno }" />
<c:set var="memberno" value="${sessionScope.memberno}" />


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
 $(function() {
    // var contentsno = 0;
    //$('#btn_create').on('click', function() { b_c_btn(commgrpno)});
    $('#btn_login').on('click', login_ajax);
    $('#btn_loadDefault').on('click', loadDefault);
    
    // -------------------- 댓글 관련 시작 --------------------
    var frm_reply = $('#frm_reply');
    $('#replycontent', frm_reply).on('click', check_login);  // 댓글 작성시 로그인 여부 확인
    $('#btn_create', frm_reply).on('click', reply_create);  // 댓글 작성시 로그인 여부 확인

    list_by_boardno_join();  // 댓글 목록
    // list_by_boardno_join_add(); // 댓글 페이징 지원 목록, 동시 접속시 페이징 문제 있음.

    // $("#btn_add").on("click", list_by_boardno_join_add); // 더보기 버튼 이벤트 등록, 페이징 문제 있음.
    $("#btn_add").on("click", list_by_boardno_join_add_pg); // 더보기 버튼 이벤트 등록
    // -------------------- 댓글 관련 종료 --------------------
    
    // 로그인 여부에 따른 수정/삭제 버튼 visible
    if ('${sessionScope.id}' == '') {  // 로그인 안되어있으면 수정/삭제 버튼 숨김
      $('#btn_update').hide();
      $('#btn_delete').hide();
    } else{                            // 로그인되어 있으면 수정/삭제 버튼 보임
      $('#btn_update').show();
      $('#btn_delete').show();
    }

  });

  function loadDefault() {
      $('#id').val('user1');
      $('#passwd').val('1234');
  }
  
  <%-- 로그인 --%>
  function login_ajax() {
    var params = "";
    params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    console.log(memberno);
    $.ajax(
      {
        url: '/register/login_ajax.do',
        type: 'post',  // get, post
        cache: false, // 응답 결과 임시 저장 취소
        async: true,  // true: 비동기 통신
        dataType: 'json', // 응답 형식: json, html, xml...
        data: params,      // 데이터
        success: function(rdata) { // 응답이 온경우
          var str = '';
          console.log('-> login cnt: ' + rdata.cnt);  // 1: 로그인 성공
          
          if (rdata.cnt == 1) {
            $('#div_login').hide();
            location.href="read.do?boardno=3&word=&now_page=1";            
            
          } else {
            alert('로그인에 실패했습니다. 다시 시도해주세요.');
            location.href='/register/login.do';
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          console.log(error);
        }
      }
    );  //  $.ajax END
  }

  <%-- 게시글 글쓰기 버튼 클릭 --%>
  function b_c_btn(commgrpno, now_page) {
    var f = $('#frm_login');
    console.log('-> commgrpno: ' + commgrpno); 
    console.log('-> now_page: ' + now_page); 
    // console.log('-> id:' + '${sessionScope.id}');

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();        // 로그인폼 출력  
      
    } else {  // 로그인 한 경우
        location.href='/board/create.do?commgrpno=' + commgrpno+'&word=&now_page=' +now_page;
    }
  }
  
  <%-- 게시글 수정 버튼 클릭 --%>
  function b_u_btn(boardno, now_page) {
    var f = $('#frm_login');
    $('#boardno', f).val(boardno);
    // console.log('-> boardno: ' + boardno); 
    // console.log('-> id:' + '${sessionScope.id}');

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();        // 로그인폼 출력  
      
    } else {  // 로그인 한 경우
        var writer = $.trim('${boardVO.writer}');
        var session = $.trim('${sessionScope.id}');
        // console.log("게시글 작성자 ID: " + writer);
        // console.log("홈페이지 접속 ID: " + session);
        
        // 홈페이지 로그인한 계정과 게시글 작성자가 같은지 비교
        if($.trim(session) != $.trim(writer)){
          // console.log('-->' + '${boardVO.writer}')
          alert('작성자만 수정할 수 있습니다.');
          return;
        }
        else{ 
          alert('수정 페이지로 이동');
          board_update_ajax(now_page);
        }
    }
  }

  <%-- 게시글 삭제 버튼 클릭 --%>
  function b_d_btn(commgrpno, boardno, now_page) {
    var f = $('#frm_login');
    boardno = $('#boardno', f).val(boardno);

    if ('${sessionScope.id}' == '') {  // 로그인이 안되어 있다면
        $('#div_login').show();        // 로그인폼 출력    

    } else {  // 로그인 한 경우
        var writer = $.trim('${boardVO.writer}');
        var session = $.trim('${sessionScope.id}');
        var memberno = $.trim('${sessionScope.memberno}');
        var name = $.trim('${sessionScope.mname}'); // 지금 로그인한 member의 mname을 admin이라는 변수에 저장
        console.log("게시글 작성자 ID: " + writer);
        console.log("session ID: " + session);
        console.log("memberno: " + memberno);
        console.log("사용자 이름: "+ name);
        
        // 삭제 가능 : memberVO.mname=관리자, 게시글 작성자만 가능
        // 홈페이지 로그인한 계정(세션)과 게시글 작성자가 같은지 비교
        if(($.trim(name) != '관리자') && ($.trim(session) != $.trim(writer))){
          // console.log('-->' + '${boardVO.writer}')
          alert('작성자만 삭제할 수 있습니다.');
          return;
        }
        else{ 
          if(name == '관리자'){
              alert('관리자 권한으로 삭제 페이지 이동');
          }else{
          }
          board_delete_ajax(commgrpno, boardno, now_page);
        }
    }
  }
    
  <%-- 게시글 수정 --%>
  function board_update_ajax(now_page) {
    var f = $('#frm_login');
    var boardno = $('#boardno', f).val();  
    
    var params = "";
    // params = $('#frm_login').serialize(); // 직렬화, 폼의 데이터를 키와 값의 구조로 조합
    params += 'boardno=' + boardno;
    // console.log('-> board_update_ajax: ' + boardno);
    // return;
    location.href='/board/update.do?boardno=' + boardno +'&word=&now_page=' + now_page;
  }

  <%-- 게시글 삭제 --%>
  function board_delete_ajax(commgrpno, boardno, now_page) {
    var f = $('#frm_login');
    var boardno = $('#boardno', f).val();  
    
    location.href='/board/delete.do?boardno=' + boardno +'&word=&now_page='+now_page;

  }

  //-------------댓글 관련 시작 --------------

  // 댓글 작성시 로그인 여부 확인
  function check_login() {
    var frm_reply = $('#frm_reply');
    if ($('#memberno', frm_reply).val().length == 0 ) {
      alert('로그인해야 댓글 등록 가능합니다.');
      return false;
    }
  }

  // 댓글 등록 , 닫기버튼 눌렀을때 modal 창이 닫혀야됨
  function reply_create() {
    var f = $('#frm_login');
    var frm_reply = $('#frm_reply');
    
    var id = $.trim('${sessionScope.id}');  
    // console.log('지금 댓글 등록 시도하는 ID: ', id)

    if (check_login() !=false) { // 로그인 한 경우만 처리
      var params = frm_reply.serialize();
      // alert(params);
      // return;

      // 자바스크립트: 영숫자, 한글, 공백, 특수문자: 글자수 1로 인식
      // 오라클: 한글 1자가 3바이트임으로 300자로 제한
      // alert('내용 길이: ' + $('#content', frm_reply).val().length);
      // return;
      
      if ($('#replycontent', frm_reply).val().length > 300) {
        /* $('#modal_title').html('댓글 등록'); // 제목 
        $('#modal_content').html("댓글 내용은 300자이상 입력 할 수 없습니다."); // 내용
        $('#modal_panel').modal('show');           // 다이얼로그 출력 */
        aler('댓글 내용은 300자이내로 작성해주세요.');
        return;  // 실행 종료
      }

      $.ajax({
        url: "/reply/create.do", // action 대상 주소
        type: "post",          // get, post
        cache: false,          // 브러우저의 캐시영역 사용안함.
        async: true,           // true: 비동기
        dataType: "json",   // 응답 형식: json, xml, html...
        data: params,        // 서버로 전달하는 데이터
        success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
          // alert(rdata);
          var msg = ""; // 메시지 출력
          var tag = ""; // 글목록 생성 태그
          //console.log("댓글 등록 체크 중");

          var cnt = rdata.count;
          //console.log("cnt: ", cnt);
          
          if (cnt > 0) {
            alert("댓글을 등록했습니다.");
            $('#replycontent', frm_reply).val('');
            $('#replypwd', frm_reply).val('');

            // list_by_boardno_join(); // 댓글 목록을 새로 읽어옴

            $('#reply_list').html(''); // 댓글 목록 패널 초기화, val(''): 안됨
            $("#reply_list").attr("data-replypage", 1);  // 댓글이 새로 등록됨으로 1로 초기화
            
            // list_by_boardno_join_add(); // 페이징 댓글, 페이징 문제 있음.
            // alert("댓글 목록 읽기 시작");
            global_rdata = new Array(); // 댓글을 새로 등록했음으로 배열 초기화
            global_rdata_cnt = 0;       // 목록 출력 글수

            list_by_boardno_join(); // 페이징 댓글
            
          } else {
            alert("댓글 등록에 실패했습니다.");
          }       
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          var msg = 'ERROR request.status: '+request.status + '/ ' + error;
          console.log(msg); // Chrome에 출력
        }
      });
    }
  }
  //--------------------- 댓글 출력 관련 시작 --------------------- 
  var global_rdata = new Array(); // 내용 저장
  var global_rdata_cnt = 0;         // 현재 출력한 댓글의 수, 1 page = 10개 레코드, 11개인 경우 중간 종료

  // Reply class 선언
  // {"memberno":3,"rdate":"2020-12-17 15:16:16.0","passwd":"18","replyno":32,"id":"user1","content":"18","contentsno":53}
  function Reply(replyno, boardno, memberno, id, replycontent, replypwd, replydate) {
    this.replyno = replyno;
    this.boardno = boardno;
    this.memberno = memberno;
    this.id = id;
    this.replycontent = replycontent;
    this.replypwd = replypwd;
    this.replydate = replydate;
  }
  
  //boardno 별 소속된 댓글 목록
  function list_by_boardno_join() {
    var params = 'boardno=' + ${boardVO.boardno };

    $.ajax({
      url: "/reply/list_by_boardno_join.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = '';
        
        $('#reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          // console.log("댓글 목록에 있는 replyno: "  + row.replyno + ',memberno: ' + row.memberno);
          var reply = new Reply(row.replyno, row.boardno, row.memberno, row.id, row.replycontent, row.replypwd, row.replydate); // 객체 생성
          global_rdata.push(reply); // 배열에 저장
          
          // msg += "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-top: 10px; margin-bottom: 10px;'>";
          // msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
          //msg += "  　" + "<span style='color:gray; font-size:0.85em; '>" + row.replydate + "</span>";
          //if ('${sessionScope.id}' == row.id) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
          //  msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='./images/delete.png'></A>";
          //}
          //msg += "  " + "<br>";
          //msg += row.replycontent;
          //msg += "</DIV>";
        }
        // alert(msg);
        // $('#reply_list').append(msg);
        list_by_boardno_join_add_pg();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
    
  }

  // 댓글 삭제 레이어 출력
  function reply_delete(replyno) {
    // alert('replyno: ' + replyno);
    var frm_reply_delete = $('#frm_reply_delete');
    $('#replyno', frm_reply_delete).val(replyno);       // 삭제할 댓글 번호 저장
    $('#modal_panel_delete').modal('show');             // 삭제폼 다이얼로그 출력
  }

  // 댓글 삭제 처리
  function reply_delete_proc(replyno) {
    // alert('replyno: ' + replyno);
    var params = $('#frm_reply_delete').serialize();

    var id = $.trim('${sessionScope.id}');  
    // console.log('지금 댓글 삭제 시도하는 ID: ', id)
    $.ajax({
      url: "/reply/delete.do", // action 대상 주소
      type: "post",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        // alert(rdata);
        var msg = "";
        
        if (rdata.replypwd_cnt ==1) { // 패스워드 일치
          if (rdata.delete_cnt == 1) { // 삭제 성공
            $('#modal_panel_delete').modal('hide'); // 삭제폼 닫기, click 발생 ★ 
            $('#' + replyno).remove(); // 태그 삭제 ★
            // alert('댓글 삭제 완료'); 
            $('#modal_panel').modal('show');         // 다이얼로그 출력 
            $('#modal_content').attr('class', 'alert alert-danger'); // Bootstrap CSS 변경
            $('#modal_title').html("댓글 삭제"); // 제목 
            $('#modal_content').html("댓글이 삭제 되었습니다.");        // 내용
            
            btn_modal_close();
            
            return; // 함수 실행 종료
          } else {  // 삭제 실패
            console.log("패스 워드는 일치하나 댓글 삭제에 실패했습니다. 다시한번 시도해주세요.");
          }
        } else { // 패스워드 일치하지 않음.
           msg = "패스워드가 일치하지 않습니다.";
           $('#modal_panel_delete_msg').html(msg);

           $('#replypwd_cnt', '#frm_reply_delete').focus();
          
        }
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
  }

  // modal창에서 닫기 버튼 누를 시 modal_panel 숨김 처리
  function btn_modal_close(){
    $('#modal_panel').modal('hide');
  }
  
  // 댓글 삭제폼에서 닫기 버튼 누를 시 modal_panel 숨김 처리
  function delete_modal_close(){
    $('#modal_panel_delete').modal('hide');
  }

  //boardno 별 소속된 댓글 목록 + 더보기 버튼
  /**
  function list_by_boardno_join_add() {
    
    var replypage = parseInt($("#reply_list").attr("data-replypage")); // 현재 페이지 
    var params = 'boardno=' + ${boardVO.boardno } + "&replypage="+replypage ;

    $.ajax({
      url: "/reply/list_by_boardno_join_add.do", // action 대상 주소
      type: "get",           // get, post
      cache: false,          // 브러우저의 캐시영역 사용안함.
      async: true,           // true: 비동기
      dataType: "json",   // 응답 형식: json, xml, html...
      data: params,        // 서버로 전달하는 데이터
      success: function(rdata) { // 서버로부터 성공적으로 응답이 온경우
        $("#reply_list").attr("data-replypage", replypage+1);  // 개발자 정의 속성 쓰기, 페이지수 증가
        // alert(rdata);
        var msg = '';
        
        //$('#reply_list').html(''); // 패널 초기화, val(''): 안됨
        
        for (i=0; i < rdata.list.length; i++) {
          var row = rdata.list[i];
          
          msg += "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-top: 10px; margin-bottom: 10px;'>";
          msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
          msg += "  　" + "<span style='color:gray; font-size:0.85em; '>" + row.replydate + "</span>";
          if ('${sessionScope.id}' == row.id) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
            msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='./images/delete.png'></A>";
          }
          msg += "  " + "<br>";
          msg += row.replycontent;
          msg += "</DIV>";
        }
        // alert(msg);
        $('#reply_list').append(msg);  //  reply_list 태그의 body의 마지막 부분에 태그 추가 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR request.status: '+request.status + '/ ' + error;
        console.log(msg);
      }
    });
    
  }*/

  
  //boardno 별 소속된 댓글 목록 + 더보기 버튼
  function list_by_boardno_join_add_pg() {
    // console.log('list_by_boardno_join_add_pg 실행 중');
    var replypage = parseInt($("#reply_list").attr("data-replypage")); // 1, 2, 3...
    var end = replypage * 2;     // 2, 4, 6...
    var start = end - 2;             // 0, 2, 4..., 배열 index는 0부터 시작 
    var msg="";

    for (var i=start; i < end; i++) {
      global_rdata_cnt = global_rdata_cnt + 1; // DIV 태그에 글 출력 카운트
      if (global_rdata.length < global_rdata_cnt ) { // 1 page = 10개 레코드, 11개인 경우 중간 종료
        break;
      }

      var row = global_rdata[i]; // 배열에서 글 1건 산출
      
      msg += "<DIV id='"+row.replyno+"' style='border-bottom: solid 1px #EEEEEE; margin-top: 10px; margin-bottom: 10px;'>";
      msg += "<span style='font-weight: bold;'>" + row.id + "</span>";
      msg += "  　" + "<span style='color:gray; font-size:0.85em; '>" + row.replydate + "</span>";
      if ('${sessionScope.memberno}' == row.memberno) { // 글쓴이 일치여부 확인, 본인의 글만 삭제 가능함 ★
        msg += " <A href='javascript:reply_delete("+row.replyno+")'><IMG src='./images/delete.png'></A>";
      }
      msg += "  " + "<br>";
      msg += row.replycontent;
      msg += "</DIV>";
    }
    // alert(msg);
    $('#reply_list').append(msg);
    $("#reply_list").attr("data-replypage", replypage+1);  // 개발자정의 속성 쓰기
    
  }

  // -------------------- 댓글 관련 종료 --------------------
</script>
 
</head> 
 
<body>
<jsp:include page="../menu/top.jsp" />

<!-- ******************** Modal 알림창 시작 ******************** -->
<div id="modal_panel" class="modal fade"  role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id='modal_title'></h4><!-- 제목 -->
      </div>
      <div class="modal-body">
        <p id='modal_content'></p>  <!-- 내용 -->
      </div>
      <div class="modal-footer">
        <button type="button" id="btn_close" data-focus="" class="btn btn-default" 
                onclick="btn_modal_close()" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>
<!-- ******************** Modal 알림창 종료 ******************** -->

<!-- -------------------- 댓글 삭제폼 시작 -------------------- -->
<div class="modal fade" id="modal_panel_delete" role="dialog">
  <div class="modal-dialog">
    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title">댓글 삭제</h4><!-- 제목 -->
        <button type="button" class="close" data-dismiss="modal">×</button>
      </div>
      <div class="modal-body">
        <form name='frm_reply_delete' id='frm_reply_delete'>
          <input type='hidden' name='replyno' id='replyno' value=''>
          
          <label>패스워드</label>
          <input type='password' name=replypwd id='replypwd' class='form-control'>
          <DIV id='modal_panel_delete_msg' style='color: #AA0000; font-size: 1.1em;'></DIV>
        </form>
      </div>
      <div class="modal-footer">
        <button type='button' class='btn btn-danger' 
                     onclick="reply_delete_proc(frm_reply_delete.replyno.value); frm_reply_delete.replypwd.value='';">삭제</button>

        <button type="button" class="btn btn-default" data-focus="" data-dismiss="modal" 
                onclick="delete_modal_close()" id='btn_frm_reply_delete_close'>Close</button>
      </div>
    </div>
  </div>
</div>
<!-- -------------------- 댓글 삭제폼 종료 -------------------- -->
<div class="py-5">
  
    <DIV class='container'> 
        <DIV class='title_line_none'>
          <c:choose>
            <c:when test="${commgrpno == 1}">
              <a href="./list_by_commgrpno_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:when>
            <c:when test="${commgrpno == 2}">
              <a href="./list_by_commgrpno_notice_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:when>
            <c:otherwise>
              <a href="./list_by_commgrpno_search_paging.do?commgrpno=${commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>
            </c:otherwise>
          </c:choose>
          <%-- <a href="./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno }&word=&now_page=1" class='title_link'>${commgrpVO.name}</a>  --%>
        </DIV>
        
        <DIV class='menu_line_none'></DIV>
        
        <%-- ******************** Ajax 기반 로그인 폼 시작 ******************** --%>
        <DIV id='div_login' style='width: 80%; margin: 0px auto; display: none;'>
            <FORM name='frm_login' id='frm_login' method='POST' action='/register/login.do' class="form-horizontal">
              <input type="hidden" name="boardno" id="boardno" value="${param.boardno }">
              <input type="hidden" name="commgrpno" id="commgrpno" value="commgrpno">
              
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
        
        <div class="board_read">
            <DIV style="padding: 5px;"> 
                <div>
                    <div class="div_line_t_b" style="padding: 25px 0px 35px 40px; width: 100%; border-bottom: dotted 1px #B4B4B4;">
                      <div>
                        <span style="color: #454545; font-size: 1.4em; font-weight: bold;">${boardVO.title }</span><br>
                      </div>
                      <div style="padding: 5px 0px 0px 0px; color: #808080">
                        <span style="color: black; font-size: 0.94em; font-weight: bold;">${boardVO.writer }</span><br>
                        <span style="font-size: 0.87em;">${boardVO.brdate.substring(0, 16) }</span>
                        <span class='menu_sep2'>　</span>
                        <span style="font-size: 0.87em;">조회 ${boardVO.bcnt}</span>　
                        <span style="font-size: 0.87em;">추천 ${boardVO.brecom}</span>
                      </div>
                    </div>
                </div>
                
                <div style="padding: 10px 20px 30px 20px;" >
                    <div style="margin-left: 20px;">
                      <span>${boardVO.bcon }
                      </span>
                    </div>
                </div>
                
                <!-- ---------- 댓글 영역 시작 ---------- -->
                <div style="margin-top: 20%; margin-left:8px; padding-left:5px; width: 100%;"> 
                  <form name='frm_reply' id='frm_reply'>
                    <input type='hidden' name='memberno' id='memberno' value='${memberno}'>
                    <input type='hidden' name='boardno' id='boardno' value='${boardno}'>
                    
                    <span style="font-size: 1.1em; font-weight: bold;">댓글 ${boardVO.breplycnt }</span>
                    
                    <div style="margin-top:15px; margin-bottom:20px; padding: 10px 20px 30px 20px; height: 150px; width: 98%; border: solid 2px #e6e6e6; border-radius: 5px;">
                      <span style="font-weight: bold; font-size: 0.96em;">댓쓴이 : ${id}</span><br>
                      <textarea name="replycontent" id="replycontent" style="margin-top:10px; border: none; width: 100%; height: 50px;"
                                placeholder="댓글 작성, 로그인해야 등록 할 수 있습니다."></textarea>
                      <div style="text-align: right; ">
                        <input type='password' name='replypwd' id='replypwd' placeholder="비밀번호">
                        <button type="button" id='btn_create' class="btn btn-outline-light" style="margin-bottom: 5px; color:black;"> 등록</button>
                      </div>
                    </div>  
                   </form> 
                   
                   <DIV id='reply_list' data-replypage='1'>  <%-- 댓글 목록 --%>
                   
                   </DIV>
                   
                   <DIV id='reply_list_btn' style='border: solid 1px #EEEEEE; margin-bottom:20px; width: 98%; background-color: #EEFFFF; '>
                      <button id='btn_add' style='width: 100%; border: none; border-radius: 2px;'>더보기 ▽</button>
                   </DIV>  
                  
                </div>
                <!-- ---------- 댓글 영역 종료----------  -->
            </DIV> 
        </div>
        <div style="width:100%; margin-top: 10px;">
          <div style="width:50%; float:left;">         
            <button type="button" class="btn_yelㅣow" id="btn_create" style="margin-right: 4px;"  
                    onclick="b_c_btn(${commgrpno},${param.now_page })">글쓰기</button>
            <button type="button" class="btn_gray" id="btn_update" name="btn_update" style="border: solid 1px;" 
                    onclick="b_u_btn(${param.boardno},${param.now_page })">수정</button>
            <button type="button" class="btn_gray" id="btn_delete" name="btn_delete" style="border: solid 1px;" 
                    onclick="b_d_btn(${commgrpno}, ${param.boardno}, ${param.now_page})">삭제 </button>
          </div>
          <div style="width:50%; float:right; text-align: right; margin-top:1px;">
             <c:choose>
                <c:when test="${commgrpno == 1}">
                  <button type='button' onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=1&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:when>
                <c:when test="${commgrpno == 2}">
                  <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=2&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:when>
                <c:otherwise>
                  <button type='button' onclick="location.href='./list_by_commgrpno_notice_search_paging.do?commgrpno=3&word=${param.word}&now_page=${param.now_page }'" class="btn_gray">목록</button>
                </c:otherwise>
             </c:choose>
            <%-- <button type="button" onclick="location.href='./list_by_commgrpno_search_paging.do?commgrpno=${param.commgrpno}&word=${param.word }&now_page=${param.now_page }'" 
            class="btn_gray">목록</button> --%>
          </div>
        </div>
        
        <%-- 추가적으로 광고를 넣을 DIV, css 추가 --%>
        <div class="c_bottom_ad">
          광고
        </div>
        
    </div>
</div>
 
<jsp:include page="../menu/bottom.jsp" />
</body>
 
</html>

