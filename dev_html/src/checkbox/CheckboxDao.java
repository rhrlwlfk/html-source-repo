package checkbox;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.utill.DBconnectionMgr;

public class CheckboxDao {

	DBconnectionMgr dbmgr = DBconnectionMgr.getInstance();
	ResultSet rs = null;
	Connection con  = null;
	PreparedStatement pstmt =null;
	public List<Map<String, Object>> getList() {
		
		List<Map<String, Object>> mList  = new ArrayList<Map<String,Object>>();
		StringBuilder sql = new StringBuilder();
		Map<String, Object> rMap = null;
		
		try {
			sql.append("select empno, ename from emp");
			con = dbmgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs= pstmt.executeQuery();
			while(rs.next()) {
				rMap = new HashMap<String, Object>();
				rMap.put("empno",rs.getInt("empno"));
				rMap.put("ename", rs.getString("ename"));
				mList.add(rMap);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	public static void main(String[] args) {
		CheckboxDao check = new CheckboxDao();
		check.getList();
		System.out.println(check.getList().size());
	}
	
}
