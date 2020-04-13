<%@page import="project_resturant.RestaurantDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//mapDesign.html문서에서 사용자가 화면에 입력한 아이디 가져오기
   String mem_id = request.getParameter("mem_id");
   String mem_pw = request.getParameter("mem_pw");
   RestaurantDao rdao = new RestaurantDao();
   String msg = null;
   msg = rdao.login(mem_id, mem_pw);
   out.print(msg);
%>