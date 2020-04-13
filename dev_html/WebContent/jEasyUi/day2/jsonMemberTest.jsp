<%@page import="easyui_member.MemberDAO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>

<%@page import="com.google.gson.Gson" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%-- html 땅   jsp 주석으로 해야함.--%>
<% 
   //스크립틀릿 : 자바땅
      MemberDAO mdao = new MemberDAO();
      List<Map<String,Object>> mList = null;
      mList =mdao.procmemberList();
      Gson g = new Gson();
      String imsi = g.toJson(mList);
      out.print(imsi);
%>