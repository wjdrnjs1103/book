<%@ page contentType="text/html; charset=UTF-8" %>
 
<%
Cookie cookie = new Cookie("windowOpen", "close"); // 이름, 값
cookie.setMaxAge(30); // 86400초=1일 (테스트를 위해 30초로 설정)
cookie.setPath("/");
response.addCookie(cookie);
%>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
</head> 
<body>

<script type="text/javascript">
  window.close(); 
</script>
 
</body>
 
</html>