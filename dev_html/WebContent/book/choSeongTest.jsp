<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
</head>
<body>
<div id="d_msg"></div>
<!-- 
가 -  44032
나 -  45
 -->
<script type="text/javascript">
	function choSeongAccount(str){
		var cho = ["ㄱ","ㄲ","ㄴ","ㄷ","ㄸ"
					,"ㄹ","ㅁ","ㅂ","ㅃ","ㅅ"
					,"ㅆ","ㅇ","ㅈ","ㅉ","ㅊ"
					,"ㅋ","ㅌ","ㅍ","ㅎ"
			     	];
		var code;
		var result='';//ㅈㅂ반환하는 변수 
		//alert(str.charCodeAt());
		for(i=0;i<str.length;i++){
			code= str.charCodeAt(i)-44032;
			//$("#d_msg").append(code+" ");
			if(code > -1 && code < 11172) result += cho[Math.floor(code/588)];
		}
			alert(str.charCodeAt(0));
			alert(str.charCodeAt(1));
		return result;
	}
	var num = choSeongAccount("귤이");
	alert("a"+ num);
</script>
</body>
</html>