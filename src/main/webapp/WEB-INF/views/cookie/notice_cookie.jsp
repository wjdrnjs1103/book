<%@ page contentType="text/html; charset=UTF-8" %>
 
<%
Cookie cookie = new Cookie("windowOpen", "close"); // 이름, 값
cookie.setMaxAge(86400); // 86400
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