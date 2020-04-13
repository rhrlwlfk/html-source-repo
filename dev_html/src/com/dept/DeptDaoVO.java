package com.dept;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.utill.DBconnectionMgr;

import json.ui.JasonDeptList;

public class DeptDaoVO {
	DBconnectionMgr dbMgr = DBconnectionMgr.getInstance() ;
	Connection con=null;
	PreparedStatement pstmt;
	ResultSet rs = null;
	/*
	public List<Map<String,Object>>deptList(){ 
	StringBuilder sql = new StringBuilder();
	List<Map<String,Object>> dlist = new ArrayList<>();
		// TODO Auto-generated constructor stub
	try {
		sql.append("SELECT deptno,dname,loc FROM sept");
		con = dbMgr.getConnection();
		pstmt = con.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		//오라클이 파싱을한다 - dbms 실행계획 -옵티마이저 -open. Fetch
		//3개의 컬럼은 Map에 담고, 여러개의 로우는 List에 담는다.
		Map<String,Object> rMap = null;
		while(rs.next()) {
			rMap = new HashMap<>();
			rMap.put("deptno", rs.getInt("deptno"));
			rMap.put("dname", rs.getString("dname"));
			rMap.put("loc", rs.getString("loc"));
			dlist.add(rMap);//컬럼3개가 ,로우 한개가 
		}
		System.out.println(dlist.size());
	}catch (SQLException se) {
		System.out.println("[[query]]"+sql.toString());
	}catch (Exception e) {
		// TODO: handle exception
		System.out.println("[[query]]"+e.toString());
	
	}
	return dlist;
	
}*/
	public List<DeptVO>deptVOList(){ 
	StringBuilder sql = new StringBuilder();
	List<DeptVO> dlist = new ArrayList<>();
		// TODO Auto-generated constructor stub
	try {
		sql.append("SELECT deptno,dname,loc FROM dept");
		con = dbMgr.getConnection();
		pstmt = con.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		//오라클이 파싱을한다 - dbms 실행계획 -옵티마이저 -open. Fetch
		//3개의 컬럼은 Map에 담고, 여러개의 로우는 List에 담는다.
		DeptVO dVO =null;
		Map<String,Object> rMap = null;
		while(rs.next()) {
			dVO = new DeptVO();
			dVO.setDeptno(rs.getInt("deptno"));
			dVO.setDname(rs.getString("dname"));
			dVO.setLoc(rs.getString("loc"));
			dlist.add(dVO);//컬럼3개가 ,로우 한개가 
		}
		System.out.println(dlist.size());
	}catch (SQLException se) {
		System.out.println("[[query]]"+sql.toString());
	}catch (Exception e) {
		// TODO: handle exception
		System.out.println("[[query]]"+e.toString());
	
	}
	return dlist;
	
}
	public static void main(String[] args) {
		DeptDaoVO jdl = new DeptDaoVO();
		//List<Map<String, Object>> list= new ArrayList<>();
		List<DeptVO> deptList = jdl.deptVOList();
		Gson g =new Gson();
		String temp = g.toJson(deptList); //gson으로 바꿔서 deptlist를 temp에다가 넣는다 sysout에 출력하려면 String타입안에 넣어야하니
		System.out.println(temp);
	}
}
