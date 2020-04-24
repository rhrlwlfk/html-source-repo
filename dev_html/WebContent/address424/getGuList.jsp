<%@page import="java.util.HashMap"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%
	SqlMapCommonDao zDao = new SqlMapCommonDao();
	String zdo = request.getParameter("zdo");
	Map<String,Object> rmap = new HashMap<>();
	rmap.put("zdo", zdo);
	List<Map<String,Object>> rList =zDao.getguList(rmap);
	Gson g = new Gson();
	String imsi = g.toJson(rList); 
	%>
	<%
		
	%>
