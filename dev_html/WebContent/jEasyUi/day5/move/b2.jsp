<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
b2.jsp
<script type="text/javascript">
	function move() {
		location.href="./a2.jsp?mode=update";//만약 어떤값을 넘겨야한다.하면 ?mode=update를 넘기면 사용할수있다. a2페이지에서 mode라는거를 받아야한다.
	}
	
</script>
<button onClick="move()">a2페이지</button>
</body>
</html>