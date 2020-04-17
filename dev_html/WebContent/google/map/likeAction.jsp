<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.utill.DBconnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int res_num = 0;
	if(request.getParameter("res_num")!=null) {
		res_num =  Integer.parseInt(request.getParameter("res_num"));
	}
	Connection con = null;
	PreparedStatement pstmt =null;
	DBconnectionMgr dbMgr = DBconnectionMgr.getInstance();
	StringBuilder sql = new StringBuilder();
	int result =0;//0이면 수정 실패 1이면 수정성공
	try{
		con  = dbMgr.getConnection();
		sql.append("UPDATE restaurant SET res_like=res_like+1 WHERE res_num=?");
		pstmt = con.prepareStatement(sql.toString());
		pstmt.setInt(1,res_num);
		result = pstmt.executeUpdate();
	}catch(Exception e){
		e.printStackTrace();
	}finally{
		dbMgr.freeConnection(con, pstmt);
	}
	out.print(result);
%>