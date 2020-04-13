package easyui_member;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.utill.DBconnectionMgr;

import oracle.jdbc.OracleCallableStatement;
import oracle.jdbc.OracleTypes;
/*
 * DML(기본) - 프로시저 MyBatis(DRM솔루션-30%이상 줄어듬)- 반복되는 코드 줄어듬 - 일괄수정처리
 */
public class MemberDAO {
	DBconnectionMgr 		 dbmgr = DBconnectionMgr.getInstance();
	Connection 				 con   = null;
	//select하는 문 
	PreparedStatement		 pstmt = null;
	CallableStatement		 cstmt = null;//프로시저 전담요원
	//REFCUSROR조작
	OracleCallableStatement ocstmt = null;
	ResultSet				 rs    = null;//공통사항이다 rs.next(),rs.previous(), rs.absolute(3)3번쨰로 옮겨주세요
	///procedure은 절댓값이라서 absolute를 써야한다??
	///////////////////////
	//회원 목록 조회 실습1 - SELECT문
	public List<Map<String, Object>> memberList() {
		List<Map<String, Object>> mList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("select mem_no,mem_id,mem_pw from member_t");
		mList = new ArrayList<>();
		try {
			con = dbmgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs = pstmt.executeQuery();
			Map<String, Object> rmap = null;
			rmap = new HashMap<>();
			while(rs.next()) {
				rmap.put("mem_no", rs.getInt("mem_no"));
				rmap.put("mem_id", rs.getString("mem_id"));
				rmap.put("mem_pw", rs.getString("mem_pw"));
				mList.add(rmap);
			}
			//System.out.println(mList.size());
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return mList;
	}
	//회원목록 조회 실습2 - 프로시저
	public List<Map<String, Object>> procmemberList() {
		List<Map<String, Object>> mList = new ArrayList<>();
		try {
			//DBConnectionMgr 공통고드를 작성했으므로 드라이버명,계정정보,orcl11(SID)생략
			con = dbmgr.getConnection();
			cstmt = con.prepareCall("{ call proc_memberList(?)}");
			
			//커서지정
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.execute();//프로시저처리 요청 메소드 호출
			//rs커서정보 받으려면
			//오라클에서만 제공되는 REFCUSRO이므로 오라클에서 제공하는 인터페이스로 형전환하기
			ocstmt = (OracleCallableStatement)cstmt; //형변환해줘야함
			rs= ocstmt.getCursor(1);
			Map<String, Object> rmap = null;
			while(rs.next()) {//커서의 위치에 데이터가 있는거야? 응
				rmap = new HashMap<>();
				rmap.put("mem_no",rs.getInt("mem_no"));
				rmap.put("mem_id",rs.getString("mem_id"));
				rmap.put("mem_pw",rs.getString("mem_pw"));
				rmap.put("mem_name",rs.getString("mem_name"));
				rmap.put("zipcode",rs.getString("zipcode"));
				rmap.put("mem_addr",rs.getString("mem_addr"));
				rmap.put("mem_email",rs.getString("mem_email"));
				mList.add(rmap);
				//System.out.println(mList);
			}
		}catch (Exception e) {
			System.out.println(e.toString());
			e.printStackTrace();
		}
		return mList;
	}
	public static void main(String[] args) {
		MemberDAO mdao = new MemberDAO();
		List<Map<String, Object>> mList = null;
		//mList = mdao.memberList();
		mList  = mdao.procmemberList();
		if(mList !=null) {
			System.out.println("mList.size()===> "+mList.size());//3
		}
	}
}
