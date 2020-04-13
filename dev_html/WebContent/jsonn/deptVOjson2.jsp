<%@page import="com.dept.DeptVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	com.dept.DeptDaoVO ddao = new  com.dept.DeptDaoVO();
	java.util.List<DeptVO> dlist = null;
	dlist = ddao.deptVOList();
	com.google.gson.Gson g =new com.google.gson.Gson();
	String imsi = g.toJson(dlist);
	out.print(imsi);
	
%>