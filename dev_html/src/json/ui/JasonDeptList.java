package json.ui;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

public class JasonDeptList {
	DBconnectionMgr dbMgr = DBconnectionMgr.getInstance();
	Connection con = null;
	PreparedStatement pstnt = null;
	ResultSet rs = null;
	
	public List<Map<String,Object>> getDeptList() {
		List<Map<String,Object>> deptList = new ArrayList<Map<String,Object>>();
		Map<String, Object> rMap = null;
		StringBuilder sql = new StringBuilder();
		try {
			sql.append("select empno,ename,job,mgr,hiredate,sal,comm,deptno ");
			sql.append(" FROM emp                           ");
			con= dbMgr.getConnection();
			pstnt= con.prepareStatement(sql.toString());
			rs = pstnt.executeQuery();
			while(rs.next()) {
				rMap = new HashMap<>();
				rMap.put("empno",rs.getString("empno"));
				rMap.put("ename",rs.getInt("empno"));
				rMap.put("job",rs.getString("job"));
				rMap.put("mgr",rs.getString("mgr"));
				rMap.put("hiredate",rs.getString("hiredate"));
				rMap.put("sal",rs.getString("sal"));
				rMap.put("comm",rs.getString("comm"));
				rMap.put("deptno",rs.getString("deptno"));
				deptList.add(rMap);
				
			}
		}catch (Exception e) {
			System.out.println(e.toString());
		}
		return deptList;
	}
	public static void main(String[] args) {
		JasonDeptList jdl = new JasonDeptList();
		List<Map<String,Object>> deptList = jdl.getDeptList();
		Gson g =new Gson();
		String temp = g.toJson(deptList); //gson으로 바꿔서 deptlist를 temp에다가 넣는다 sysout에 출력하려면 String타입안에 넣어야하니
		System.out.println(temp);
	}

}
