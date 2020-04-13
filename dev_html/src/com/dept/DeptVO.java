package com.dept;

public class DeptVO {
	private int deptno=0;
	private String dname = null;
	private String loc=null;
	public int getDpetno() {
		return deptno;
	}
	public void setDeptno(int dpetno) {
		this.deptno = dpetno;
	}
	public String getDname() {
		return dname;
	}
	public void setDname(String dname) {
		this.dname = dname;
	}
	public String getLoc() {
		return loc;
	}
	public void setLoc(String loc) {
		this.loc = loc;
	}
}
