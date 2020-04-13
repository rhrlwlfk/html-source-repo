package project_resturant;

import java.sql.CallableStatement;

import java.sql.Connection;
import java.sql.JDBCType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.utill.DBconnectionMgr;

import oracle.jdbc.OracleCallableStatement;//오라클 회사에서 지원함.
import oracle.jdbc.OracleTypes;

public class RestaurantDao {
	DBconnectionMgr dbmgr = DBconnectionMgr.getInstance();
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	CallableStatement cstmt = null;
	//
	OracleCallableStatement ocstmt =null;
	//프뢰저를 활용하여 로그인 처리하기
	/*********************************************************
	 * @param mem_id :사용자가 입력한 아이디
	 * @param mem_pw : 사용자가 입력한 비번
	 * @return msg: proc_login2020(u_id IN varchar2 , u_pw IN varchar2, msg OUT varchar2);
	 *********************************************************/
	public String login(String mem_id, String mem_pw) {
		String msg = null;
		int result = 0;
		try{
			con = dbmgr.getConnection();
			cstmt = con.prepareCall("{ call proc_login2020(?,?,?) }");
			cstmt.setString(1, mem_id);//메소드의 파라미터로 사용자가 입력한 아이디를 받아옴.
			cstmt.setString(2, mem_pw);
			cstmt.registerOutParameter(3, OracleTypes.VARCHAR);//out 속성일 때만
			//cstmt.execute();//boolean형이다 이것도 사용가능
			result = cstmt.executeUpdate();//int 형이다
			msg  = cstmt.getString(3);
			System.out.println("result:"+result+",msg:" + msg);
		}catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return msg;
	}
	public List<Map<String,Object>> procRestList(){
        List<Map<String,Object>> rList = null;
         StringBuilder sql = new StringBuilder();
         try {
           //오라클사가 배포하는 드라이버 클래스를 스캔함. 
           con = dbmgr.getConnection(); //물리적으로 떨어져 있는 서버에 연결통로  확보
           //DML를 요청할 땐 PreparedStatement
           //프로시저를 요청할땐 CallableStatement//proc_restaurant
            cstmt = con.prepareCall("{ call proc_restaurant(?) }");
            cstmt.registerOutParameter(1, OracleTypes.CURSOR);
            cstmt.execute();//오라클에 살고 있는 옵티마이저에게 처리해주세요.
            ocstmt = (OracleCallableStatement)cstmt;
            //프로시저의 OUT속성을 지정함.
            rs = ocstmt.getCursor(1);
            rList = new ArrayList<>();
            Map<String,Object> rmap = null;
            while(rs.next()) {
               rmap = new HashMap<>();
               rmap.put("res_num", rs.getInt("res_num"));
               rmap.put("res_name", rs.getString("res_name"));
               rmap.put("res_tell", rs.getString("res_tell"));
               rmap.put("res_addr", rs.getString("res_addr"));
               rmap.put("res_hate", rs.getInt("res_hate"));
               rmap.put("res_like", rs.getInt("res_like"));
               rmap.put("res_photo", rs.getString("res_photo"));
               rmap.put("res_info", rs.getString("res_info"));
               rmap.put("res_time", rs.getString("res_time"));
               rmap.put("lat", rs.getDouble("lat"));
               rmap.put("lng", rs.getDouble("lng"));
               rList.add(rmap);
            }
         } catch (SQLException se) {
            System.out.println("[[query]]");
         } catch (Exception e) {
            e.printStackTrace();
         }
         return rList;
   }
	public List<Map<String,Object>> restList() {
		List<Map<String,Object>> rList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_num, res_name, res_tell, res_addr, res_hate,");
		sql.append("       res_like,res_photo,res_info,res_time,");
		sql.append("       lat,lng");
		sql.append(" FROM RESTAURANT");
		rList = new ArrayList<>();
		try {
			con = dbmgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rs= pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<>();
				rmap.put("res_num", rs.getInt("res_num"));
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_tell", rs.getString("res_tell"));
				rmap.put("res_addr", rs.getString("res_addr"));
				rmap.put("res_hate", rs.getInt("res_hate"));
				rmap.put("res_like", rs.getInt("res_like"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("res_info", rs.getString("res_info"));
				rmap.put("res_time", rs.getString("res_time"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				rList.add(rmap);
			}
			System.out.println(rList.size());
		} catch (SQLException se) {
			System.out.println("[[query]]"+ sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rList;
	}
	public List<Map<String,Object>> mapRestList() {
		List<Map<String,Object>> rList = null;
		StringBuilder sql = new StringBuilder();
		sql.append("SELECT res_name, res_photo, lat,lng");
		sql.append(" FROM RESTAURANT");
		try {
			con = dbmgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			rList = new ArrayList<>();
			rs= pstmt.executeQuery();
			Map<String, Object> rmap = null;
			while(rs.next()) {
				rmap = new HashMap<>();
				rmap.put("res_name", rs.getString("res_name"));
				rmap.put("res_photo", rs.getString("res_photo"));
				rmap.put("lat", rs.getDouble("lat"));
				rmap.put("lng", rs.getDouble("lng"));
				rList.add(rmap);
			}
			System.out.println(rList.size());
		} catch (SQLException se) {
			System.out.println("[[query]]"+ sql.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rList;
	}
	public int restINS(Map<String, Object> pMap) {
		int result =0;
		StringBuilder sql = new StringBuilder();
		sql.append( "Insert into restaurant(res_num,res_name,res_tell,res_addr");
		sql.append( "   ,res_hate,res_like,res_photo                     ");
		sql.append( "         ,res_info,res_time,lat,lng)                     ");
		sql.append( " VALUES(seq_restaurant_num.nextval,?,?,?,0,0,?,?,?,?,?)   "); 
		
		try {
			con = dbmgr.getConnection();
			pstmt = con.prepareStatement(sql.toString());
			int i =0;
			pstmt.setString(++i, pMap.get("res_name").toString());
			pstmt.setString(++i, pMap.get("res_tell").toString());
			pstmt.setString(++i, pMap.get("res_addr").toString());
			pstmt.setString(++i, pMap.get("res_photo").toString());
			pstmt.setString(++i, pMap.get("res_info").toString());
			pstmt.setString(++i, pMap.get("res_time").toString());
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lat").toString()));
			pstmt.setDouble(++i, Double.parseDouble(pMap.get("lng").toString()));
			result = pstmt.executeUpdate();
			System.out.println("result :" +result);
		} catch (SQLException Se) {
			System.out.println("[[query]]:"+sql.toString());
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return result;
	}
	
	public static void main(String[] args) {
//		Map<String, Object> pMap = new HashMap<>();
//		pMap.put("res_name","족발");
//		pMap.put("res_tell","전번");
//		pMap.put("res_addr","주소");
//		pMap.put("res_photo","사진");
//		pMap.put("res_time","영업시간");
//		pMap.put("res_info","맛잇음");
//		pMap.put("lat",11.1);
//		pMap.put("lng",22.44);
		RestaurantDao dao = new RestaurantDao();
		dao.procRestList();
		System.out.println(dao.procRestList().size());
		//dao.restList();
		//dao.restINS(pMap);
		String msg = dao.login("test", "123");
		System.out.println("msg:" + msg);
	}
}
