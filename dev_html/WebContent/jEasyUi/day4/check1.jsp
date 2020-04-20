<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="checkbox.CheckboxDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	CheckboxDao chkDao = new CheckboxDao();
	List<Map<String,Object>> mList = chkDao.getList();
	Gson gson = new Gson();
	String imsi = gson.toJson(mList);
	out.print(imsi);
%>