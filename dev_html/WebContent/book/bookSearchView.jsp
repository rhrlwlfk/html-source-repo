<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서검색[자동완성 + 초성검사]</title>
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/themes/color.css">
    <link rel="stylesheet" type="text/css" href="https://www.jeasyui.com/easyui/demo/demo.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.easyui.min.js"></script>
   <style type="text/css">
      #d_search {
         position: absolute;
         border: 1px dotted black;
         background: #AACCFF;
      }
      .listIn{
      	background: #CCFFFF;
      }
      .listOut{
      	background:#FFFFFF;
      }
   </style>
   <script type="text/javascript">
   //함수선언, 전역변수 선언 위치
     function choSeongAccount(str){
      var cho = [
               "ㄱ","ㄲ","ㄴ","ㄷ","ㄸ"
               ,"ㄹ","ㅁ","ㅂ","ㅃ","ㅅ"
               ,"ㅆ","ㅇ","ㅈ","ㅉ","ㅊ"
               ,"ㅋ","ㅌ","ㅍ","ㅎ"
               ];
      //alert(str.charCodeAt());
      var code;
      var result='';//ㅈㅂ을 반환하는 변수
      for(i=0;i<str.length;i++){
         code = str.charCodeAt(i)-44032;
        // $("#d_msg").append(code+" ");
        if(code > -1 && code < 11172) result += cho[Math.floor(code/588)];
      }
      return result;
   }
   function clearMethod(){
      $("#d_search").css("backgroundColor","#FFFFFF");
      $("#d_search").css("border","none");
      $("#d_search").html("");
   }
   </script>
</head>
<body>

   <script type="text/javascript">
   //DOM구성이 되었을 때
      $(document).ready(function (){
         var t = $('.textbox-f'); //클래스로 접근
         t.textbox('textbox').bind('keyup', function(e){
            var v_word = $("#_easyui_textbox_input1").val().toUpperCase();
            var choKeyword = choSeongAccount(v_word);
            //초성 검색 구분
                  //v_word가 ""이 아니라는건 Test가 입력됐다는 소리고
                  //choKeyword가 ""이라는 건 영문자가 입력 됐다는 소리이면서 초성이 입력됐다는 소리다.
            if(v_word != "" && choKeyword==""){
               choMode = "Y";
            }else{
               choMode = "N";
            }
            //alert("choMode:"+choMode);
            var p_word = $("#_easyui_textbox_input1").val();
            var param = "book_title="+p_word+"&choMode="+choMode;
            
            $.ajax({
               method:"post"
               ,url:"htmlBookList.jsp"
               ,data:param
               ,success:function(result){
                  //alert("result:"+result);
                  $("#d_search").css("border","1px soild #000000");
                  $("#d_search").css("background","#FFFFFF");
                   $("#d_search").css("top",$("#_easyui_textbox_input1").offset().bottom+"px");
                  $("#d_search").css("left",$("#_easyui_textbox_input1").offset().left+"px");
                  $("#d_search").html(result);//htmlBookList.jsp페이지 내용 => result
                  var tds = document.getElementsByTagName("td");
                  for(var i=0;i<tds.length;i++){
                     tds[i].onmouseover = function(){
                    	 this.className = "listIn";
                        var b_no = $(this).attr("id");
                        //alert("b_no ==>"+b_no);
                        
                        var targetURL='';
                        if("2"==$(this).attr("id")){
                           targerURL = 'bookSearchDetil2.jsp';
                        }else if("3"==$(this).attr("id")){
                           targerURL = 'bookSearchDetil3.jsp.jsp';
                        }
                        $.ajax({
                          method:"post"
                         ,url:targetURL 
                         ,success:function(result){
                            //alert(result);
                          //  alert("b_no:" +b_no);
                              if("2"==$(this).attr("id")){
                                 $("#d_test2").html(result);
                                 $("#d_test3").html("");
                              }else if("3"==b_no){
                                 $("#d_test2").html("");
                                 $("#d_test3").html(result);
                              }
                         }
                        });
                        
                     };/////end of tds
                     tds[i].onmouseout = function(){
                        //clearMethod();
                        this.className = "listOut";
                     }
                     tds[i].onclick = function() {
                        $("#_easyui_textbox_input1").val($(this).text());
                        clearMethod();
                     }
                  }
               }
            ,error:function(xhrObject){
               alert(xhrObject.responseText);
            }
            }); ////////////////end of ajax
         });/////////////////////end of keyup
         if($("#_easyui_textbox_input1").val().length == 0){
            //alert("아무것도 없음.");
            //clearMethod(); //$("#d_search").hide();
         }
      });///////////////////////end of ready
   </script>
   <input id="book_title" class="easyui-textbox" style="width:200px"/> 
   <div id="d_search">조회결과처리화면</div>
   <div id="d_test2">mouseover처리화면-2</div>
   <div id="d_test3">mouseover처리화면-3</div>
</body>
</html>




