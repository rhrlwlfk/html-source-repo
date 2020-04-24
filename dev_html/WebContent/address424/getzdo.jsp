<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com_dao.SqlMapCommonDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
SqlMapCommonDao zDao =  new SqlMapCommonDao();
List<Map<String,Object>> elist = zDao.getSiList(null);
Gson g= new Gson();
String imsi = g.toJson(elist);
out.print(imsi);
%>
<option value="map">선택</option>
<%
 for(int i=0; i<elist.size();i++){
	 Map<String,Object> rmap = elist.get(i);
%>
<option value="<%=out.print(rmap.get("ZDO"))%>"> <%=out.print(rmap.get("ZDO"))%></option>
 <%
 }
 %>
 <%
