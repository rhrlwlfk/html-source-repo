<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String zdo = request.getParameter("zdo");
	String sigu = request.getParameter("sigu");
	SqlMapCommonDao zDao = new SqlMapCommonDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("zdo", zdo);
	pmap.put("sigu",sigu);
	List<Map<String,Object>> rList =zDao.dongList(pmap);
%>
	 <select id="d_dong">
    <option value="선택">선택</option>
      
<%
 for(int i=0; i<rList.size();i++){
	 Map<String,Object> dongMap = rList.get(i);
%>
	<option value="<%=dongMap.get("DONG")%>"> <%= dongMap.get("DONG")%></option>
 <%
 }
 %>
	</select>   

