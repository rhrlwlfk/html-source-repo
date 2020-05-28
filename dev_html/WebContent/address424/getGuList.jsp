<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	String zdo = request.getParameter("zdo");
	SqlMapCommonDao zDao = new SqlMapCommonDao();
	Map<String,Object> rmap = new HashMap<>();
	rmap.put("zdo", zdo);
	List<Map<String,Object>> rList =zDao.getguList(rmap);
	Gson g = new Gson();
	String imsi = g.toJson(rList); 
	%>
	<select id="d_sigu">
    <option value="선택">선택</option>
      
<%
 for(int i=0; i<rList.size();i++){
	 Map<String,Object> siguMap = rList.get(i);
%>
	<option value="<%=siguMap.get("SIGU") %>"> <%=siguMap.get("SIGU")%></option>
 <%
 }
 %>
	</select>  

