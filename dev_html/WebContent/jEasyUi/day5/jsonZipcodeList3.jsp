<%@page import="com_dao.SqlMapCommonDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String dong = request.getParameter("dong");
    SqlMapCommonDao cdao = new SqlMapCommonDao();
	Map<String,Object> pmap = new HashMap<>();
	pmap.put("dong",dong);
	List<Map<String,Object>> zlist = cdao.zipcodeList(pmap);
	Gson g= new Gson();
	String imsi = g.toJson(zlist);
	out.print(imsi);
%>
