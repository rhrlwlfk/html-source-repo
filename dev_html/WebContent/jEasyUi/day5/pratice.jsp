<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com.sun.org.apache.bcel.internal.generic.LSTORE"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com_dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String empno =request.getParameter("empno");
	
	SqlMapEmpDao edao = new SqlMapEmpDao();
	Map<String,Object> rmap = new HashMap<>();
	rmap.put("empno", empno);
	List<Map<String,Object>> elist = edao.empList(rmap);
	Gson g = new Gson();
	
%>