<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="com_dao.SqlMapEmpDao"%>
<%@page import="com_dao.SqlMapDeptDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<% 
	int empno =0;
	String ename ="";
	String job ="";
	int mgr =0;
	String hiredate ="";
	double sal = 0.0;
	double comm = 0.0;
	int deptno = 0;
	if(request.getParameter("empno")!=null) {
		empno = Integer.parseInt(request.getParameter("empno"));
	}
	ename = request.getParameter("ename");
	job   = request.getParameter("job");
	if(request.getParameter("mgr")!=null) {
		mgr = Integer.parseInt(request.getParameter("mgr"));
	}
		hiredate = request.getParameter("hiredate");
	if(request.getParameter("sal")!=null) {
		sal = Integer.parseInt(request.getParameter("sal"));
	}
	
	if(request.getParameter("comm")!=null) {
		comm = Integer.parseInt(request.getParameter("comm"));
	}
	if(request.getParameter("deptno")!=null) {
		deptno = Integer.parseInt(request.getParameter("deptno"));
		SqlMapEmpDao edao = new SqlMapEmpDao();
		int result = 0;
		Map<String,Object> pMap = new HashMap<>();
		pMap.put("empno", empno);
		pMap.put("ename", ename);
		pMap.put("job", job);
		pMap.put("mgr", mgr);
		pMap.put("hiredate", hiredate);
		pMap.put("sal", sal);
		pMap.put("comm", comm);
		pMap.put("deptno", deptno);
		result = edao.empINS(pMap);
		out.print("result"+result);
		if(result==1){//등록 성공했을떄
		response.sendRedirect("EmpManagerVer8.jsp?mode=insert");//페이지 열리기전 
		}//실패했을때
		else {
		response.sendRedirect("empInsertFail.jsp");//페이지 열리기전 
			
		}
	}
%>