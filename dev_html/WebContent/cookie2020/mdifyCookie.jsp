<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie cookie = null;
	Cookie[] cookies = request.getCookies();
	if(cookies != null && cookies.length >0){
		for(int i=0;i< cookies.length; i++) {
			if(cookies[i].getName().equals("name")) {
				cookie = new Cookie("name",
						URLEncoder.encode("jsp프로그래밍","utf-8"));
						response.addCookie(cookie);
						
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%= cookie.getName() %> 쿠키의 값 = "<%= cookie.getValue() %>"
name 쿠키의 값을 변경합니다.
</body>
</html>