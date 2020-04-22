<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapEmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	SqlMapEmpDao edao = new SqlMapEmpDao();
	List<Map<String,Object>> elist = edao.empList(null);
	Gson g= new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>