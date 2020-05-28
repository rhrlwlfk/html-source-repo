<%@page import="com_dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.util.Map" %>
<%
   List<Map<String,Object>> zdoList = null;
   SqlMapCommonDao cDao = new SqlMapCommonDao();
   zdoList = cDao.getSiList(null);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ajax실전연습-[1:ajax,2:html,html+js,js,3:myBatis]</title>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.js"></script>
<style type="text/css">
   table{
      border: 3px solid #CCCCCC;
   }
   td{
      border: .25px solid #CCCCCC;
      text-align: center;
      height: 45px;
   }
</style>
   <script type="text/javascript">
   function dongIN(){
       $("#d_dong").change(function(){
          $("#d_dong option:selected").each(function(){
           $("#dong").val($(this).text());
          });
       });
    }
      function siguIN(){
         $("#d_sigu").change(function(){
            $("#d_sigu option:selected").each(function(){
             $("#sigu").val($(this).text());
               var s_gu = $(this).text();
               var z_do = $("#zdo").val();
               var param="zido="+z_do+"&sigu="+s_gu;
               $.ajax({
                   method:"post"
                  ,data:param
                  ,url:"getDongList.jsp"
                  ,success:function(result){
                     $("#d_dong").html(result);
                     dongIN();
                     //sigu정보를 해당하는 곳에 넣어야 한다.함수를 만든다.
                  }
               });
            });
         });
      }
   </script>
</head>
<body>
   <script type="text/javascript">
      //레디함수 이용해서 초기화 하자
      $(document).ready(function(){
               $.ajax({
                   method:"post"
                  ,url:"getzdo.jsp"
                  ,success:function(result){
                     $("#i_zdo").html(result);
                     //sigu정보를 해당하는 곳에 넣어야 한다.함수를 만든다.
                  }
               });
         $("#i_zdo").change(function(){
            //each문은 for문과 비슷하게 생각하면 된다.
            //선택된 텍스트 값을 p_zdo에 저장해 보자.
            $("#i_zdo option:selected").each(function(){
               var p_zdo = $(this).text();
               $("#zdo").val(p_zdo);
               var param="zdo="+p_zdo;
               $.ajax({
                   method:"post"
                  ,data: param
                  ,url:"getGuList.jsp"
                  ,success:function(result){
                     $("#d_sigu").html(result);
                     //sigu정보를 해당하는 곳에 넣어야 한다.함수를 만든다.
                     siguIN();
                  }
            });
         });
      });
      });
   </script>
   <table width="600px" height="60px" cellpadding="0" cellspacing="0">
      <tr>
         <td width="60px">시도</td>
         <td width="140px">
            <select id="i_zdo" style="width:120px">
               <option value="선택">선택</option> <!-- value 속성이 필요한 이유는? -->
             	<%
             	for(int i=0;i<zdoList.size();i++){
             		Map<String,Object> rmap= zdoList.get(i);
             	%>
             	
               <option value="<%=rmap.get("ZDO")%>"><%=rmap.get("ZDO")%></option>
           	  <% 
			}
				%>
            </select>   
         </td>
         <td width="60px">구</td>
         <td width="140px">
            <!-- 아작스로 처리될 부분. id값 기억하기 -->
		 <div id="d_sigu"></div>

         </td>
         <td width="60px">동</td>
         <td width="140px">
            <!-- 아작스로 처리될 부분. id값 기억하기 -->
            <div id="d_dong"></div>
         </td>
      </tr>
      <tr>
         <td width="60px">시도</td>
         <td width="140px">
            <input type="text" id="zdo" name="zdo" size="12"/>
         </td>
         <td width="60px">구</td>
         <td width="140px">
            <input type="text" id="sigu" name="sigu" size="12"/>
         </td>
         <td width="60px">동</td>
         <td width="140px">
            <input type="text" id="dong" name="dong" size="12"/>
         </td>
      </tr>
   </table>
</body>
</html>