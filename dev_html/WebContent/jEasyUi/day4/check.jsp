<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.utill.DBconnectionMgr"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	DBconnectionMgr dbmgr = DBconnectionMgr.getInstance();
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt= null; 
	StringBuilder sql = new StringBuilder();
	List<Map<String,Object>> mList = new ArrayList<>();
	Map<String,Object> rmap = null;
	try{
		sql.append("SELECT 1 as ck,empno, ename from emp");
		con = dbmgr.getConnection();
		pstmt = con.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		
		while(rs.next()){
			rmap = new HashMap<>();
			rmap.put("ck", rs.getInt("ck"));
			rmap.put("empno", rs.getInt("empno"));
			rmap.put("ename", rs.getString("ename"));
			mList.add(rmap);			
		}
	}catch(Exception e) {
		e.printStackTrace();
	}
	Gson g = new Gson();
	String imsi = g.toJson(mList);
	out.print(imsi);
%>