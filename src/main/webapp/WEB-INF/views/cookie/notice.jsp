<%@ page contentType="text/html; charset=UTF-8" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 <style>
  .center{
    text-align: center;
    }
 </style>
<link href="/css/style.css" rel="Stylesheet" type="text/css">
</head> 
<body>

<DIV class = "center">
 <H2>웹 페이지 제작 기념 이벤트!</H2>
</DIV><br>

<DIV class='title' style='margin: 10px auto; width: 50%; text-align: center; font-weight: bold; text-decoration: underline;'>당첨자 안내</DIV><br>
  <DIV style='margin: 0px auto; width: 80%;'> 

    <UL>
      <LI>백*환 0315</LI>       
      <LI>김*권 1739</LI> <br><br><br>
       
      <h6>진심으로 축하드립니다! <b>07/30</b>까지 휴대폰 번호로 당첨 문자를 안내드립니다.</h6> <br><br><br>   
      
      <DIV class="center">  
      <b><A href="http://localhost:9091/board/list_by_commgrpno_notice_search_paging.do?commgrpno=2&word=&now_page=1"  style="color: red; font-size: 0.8em; " >[공지사항 확인하러가기!]</A></b><br><br>
      </DIV>
    </UL>
  </DIV>
  <br>
  
  <DIV style='text-align: right; padding-right: 10px;'>
    <form name='frm' method='post' action='./notice_cookie.do'>
      <label>
        <input type='checkbox' name='windowOpenCheck' onclick="this.form.submit()"> 하루동안 창 열지 않기
        <!--<a href='javascript:window.close();'>닫기</a>-->
      </label>
    </form>
  </DIV>
</body>
 
</html>