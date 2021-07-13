<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 
<!DOCTYPE html>
<html lang="ko">
<head>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" /> 

<title>Team 2</title>

<!-- /static 기준 -->
<!-- Core theme CSS (includes Bootstrap)-->
<link href="/css/style.css" rel="stylesheet" type="text/css">
 
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<!-- Bootstrap icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />

<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />

</head>
<body>
<jsp:include page="../menu/top.jsp" flush='false' />

<div class="container">
  <div class="col-md-6 col-md-offset-3" style="text-align: center;">
    <h3>회원가입</h3>
  </div>

  <div class="page-header"></div>
  
  <div class="col-sm-6 col-md-offset-3">
    <form role="form">
        <div class="form-group">
            <label for="inputName">성명</label>
            <input type="text" class="form-control" id="inputName" placeholder="이름을 입력해 주세요">
        </div>
        <div class="form-group">
            <label for="InputEmail">이메일 주소</label>
            <input type="email" class="form-control" id="InputEmail" placeholder="이메일 주소를 입력해주세요">
        </div>
        <div class="form-group">
            <label for="inputPassword">비밀번호</label>
            <input type="password" class="form-control" id="inputPassword" placeholder="비밀번호를 입력해주세요">
        </div>
        <div class="form-group">
            <label for="inputPasswordCheck">비밀번호 확인</label>
            <input type="password" class="form-control" id="inputPasswordCheck" placeholder="비밀번호 확인을 위해 다시한번 입력 해 주세요">
        </div>
        <div class="form-group">
            <label for="inputMobile">휴대폰 번호</label>
            <input type="tel" class="form-control" id="inputMobile" placeholder="휴대폰번호를 입력해 주세요">
        </div>
        <div class="form-group">
            <label for="inputtelNO">사무실 번호</label>
            <input type="tel" class="form-control" id="inputtelNO" placeholder="사무실번호를 입력해 주세요">
        </div>
        
        <!-- ------------------------------ DAUM 우편번호 API 시작 ------------------------------ -->
        <div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 110px;position:relative">
          <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
        </div>
        
        <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
        <script>
            // 우편번호 찾기 화면을 넣을 element
            var element_wrap = document.getElementById('wrap');
        
            function foldDaumPostcode() {
                // iframe을 넣은 element를 안보이게 한다.
                element_wrap.style.display = 'none';
            }
        
            function DaumPostcode() {
                // 현재 scroll 위치를 저장해놓는다.
                var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
                new daum.Postcode({
                    oncomplete: function(data) {
                        // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
        
                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var fullAddr = data.address; // 최종 주소 변수
                        var extraAddr = ''; // 조합형 주소 변수
        
                        // 기본 주소가 도로명 타입일때 조합한다.
                        if(data.addressType === 'R'){
                            //법정동명이 있을 경우 추가한다.
                            if(data.bname !== ''){
                                extraAddr += data.bname;
                            }
                            // 건물명이 있을 경우 추가한다.
                            if(data.buildingName !== ''){
                                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                            }
                            // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                            fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                        }
        
                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        $('#rzipcode').val(data.zonecode); //5자리 새우편번호 사용 ★
                        $('#raddress1').val(fullAddr);  // 주소 ★
        
                        // iframe을 넣은 element를 안보이게 한다.
                        // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                        element_wrap.style.display = 'none';
        
                        // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                        document.body.scrollTop = currentScroll;
                        
                        $('#raddress2').focus(); //  ★
                    },
                    // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
                    onresize : function(size) {
                        element_wrap.style.height = size.height+'px';
                    },
                    width : '100%',
                    height : '100%'
                }).embed(element_wrap);
        
                // iframe을 넣은 element를 보이게 한다.
                element_wrap.style.display = 'block';
            }
        </script>
        <!-- ------------------------------ DAUM 우편번호 API 종료 ------------------------------ -->

        <div class="form-group">
        <label>약관 동의</label>
        <div data-toggle="buttons">
        <label class="btn btn-primary active">
        <span class="fa fa-check"></span>
        <input id="agree" type="checkbox" autocomplete="off" checked>
        </label>
        <a href="#">이용약관</a>에 동의합니다.
        </div>
        </div>

        <div class="form-group text-center">
            <button type="submit" id="join-submit" class="btn btn-primary">
                회원가입<i class="fa fa-check spaceLeft"></i>
            </button>
            <button type="submit" class="btn btn-warning">
                가입취소<i class="fa fa-times spaceLeft"></i>
            </button>
        </div>
    </form>
  </div>
</div> <!-- container// -->

 
 
 
<jsp:include page="../menu/bottom.jsp" flush='false' />
</body>
</html>