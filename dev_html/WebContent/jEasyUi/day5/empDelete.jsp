<%@page import="com_dao.SqlMapEmpDao"%>
<%@page import="com_dao.HashMapBilder"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String empnoArr = request.getParameter("empno");//7788,9900
	String empnos[] =null;
	if(empnoArr!=null) {
		empnos = empnoArr.split(",");
	}
		SqlMapEmpDao edao = new SqlMapEmpDao();
		int result = edao.empDEL(empnos);
		out.print("result:" +result);
		if(result >0){//등록 성공했을떄
		response.sendRedirect("EmpManagerVer8.jsp?mode=update");//페이지 열리기전 
		}//실패했을때
		else {
		response.sendRedirect("empInsertFail.jsp");//페이지 열리기전 
			
		}
	
%>