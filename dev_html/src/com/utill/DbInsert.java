package com.utill;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class DbInsert {
	public static void main(String[] args) { 
	    Map<String, String> crawlingMap = new HashMap<String, String>();
	    
	    crawlingMap.put("이름", "유관순");
	    crawlingMap.put("나이", "18");
	    crawlingMap.put("생년월일", "1902년 12월 16일");
	    crawlingMap.put("출생지", "천안");
	    crawlingMap.put("업적", "일제 강점기의 독립운동가");
	     
	    try {
	      //DB연결
	      Class.forName("oracle.jdbc.OracleDriver");
	      String url = "jdbc:oracle:thin://@localhost:1521:orcl";
	      String userid="scott";
	      String userpw="tiger";
	      /*① 위 접속정보 이용하여 DB연결 및 Connection객체 생성 */
	      Connection con = null;
	      con =DriverManager.getConnection(url,userid,userpw);//변경가능
	      //DB연결 성공시...
	      if(con!=null){      
	        /*② insert 쿼리문 작성 */
	    	  StringBuilder sql = new StringBuilder();
	    	  sql.append("insrt into 테이블(name,age,birth,contury,history)");
	    	  sql.append(" values(?,?,?,?,?)");
	        /*③ PreparedStatement 객체 생성 및 인파라미터 설정 */  
	    	  PreparedStatement psmt =null;
	    	  int i =0;
	    	  psmt.setString(++i,"이름");
	    	  psmt.setString(++i,"나이");
	    	  psmt.setString(++i,"생년월일");
	    	  psmt.setString(++i,"출생지");
	    	  psmt.setString(++i,"업적");
	    	   psmt.executeUpdate();
	    	  
		//쿼리문실행 및 반환값 확인
	        int resultNum = psmt.executeUpdate();
	        System.out.println(resultNum +"행이 입력성공");
	      }
	    }
	    catch (ClassNotFoundException ce) { }
	    catch (SQLException se) { }
	    catch (Exception e) { }
	  }
	}