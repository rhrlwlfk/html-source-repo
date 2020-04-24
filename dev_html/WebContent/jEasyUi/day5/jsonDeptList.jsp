<%@page import="com.google.gson.Gson"%>
<%@page import="com_dao.SqlMapDeptDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.dept.DeptDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map, java.util.HashMap, java.util.List" %>
<%
	SqlMapDeptDao dDao =  new SqlMapDeptDao();
	List<Map<String,Object>> elist = dDao.deptList(null);
	Gson g= new Gson();
	String imsi = g.toJson(elist);
	out.print(imsi);
%>
