<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
	<style type="text/css">
		#d_search {
			position:absoulte;
		}
	</style>
</head>
<body>

	<script type="text/javascript">
	
		$('#book_title').textbox({
		.bind('keyup',function(e){
			if(e.keyCode == 13) {
				$(this).textbox('setValue', $(this).val());
					}
				});
			})
		});
		
		$(document).ready(function (){
			
		});
	</script>
	
	<input id="book_title" class ="easyui-textbox" style="width:300px"/>
	<div id="d_search"></div>
</body>
</html>
