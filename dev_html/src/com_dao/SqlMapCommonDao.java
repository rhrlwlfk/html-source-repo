package com_dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapCommonDao {
	Logger logger  = Logger.getLogger(SqlMapEmpDao.class);///어떤로그파일을 
	   SqlSessionFactory sqlMapper = null;
	   /*****************************
	    *주소 검색 - 도 정보 조회하기 
	    * @param pMap
	    * @return List<Map<String,Object>>
	    * 업무설명 : 
	    * 작성자: 강감찬
	    * 2020년 04월 24일 
	    */
	   public List<Map<String,Object>> getSiList(Map<String,Object> pMap){
	      List<Map<String,Object>> sigulist = null;
	      String resource = "orm/mybatis/Configuration.xml";//오라클 통로를 열어주는거 비슷한거아닐까?? 
	      try {
	         Reader reader = Resources.getResourceAsReader(resource);
	         sqlMapper = new SqlSessionFactoryBuilder().build(reader);
	         //sql문을 요청하기 위한 SqlSession객체 생성하기
	         SqlSession sqlSec = sqlMapper.openSession();
	         sigulist = sqlSec.selectList("getZDOList",pMap);
	         System.out.println("조회한 로우 수 : "+sigulist.size());
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	    return sigulist;
}
	   public List<Map<String,Object>> getguList(Map<String,Object> pMap){
		   List<Map<String,Object>> donglist = null;
		   String resource = "orm/mybatis/Configuration.xml";//오라클 통로를 열어주는거 비슷한거아닐까?? 
		   try {
			   Reader reader = Resources.getResourceAsReader(resource);
			   sqlMapper = new SqlSessionFactoryBuilder().build(reader);
			   //sql문을 요청하기 위한 SqlSession객체 생성하기
			   SqlSession sqlSec = sqlMapper.openSession();
			   donglist = sqlSec.selectList("getSiGuList",pMap);
			   System.out.println("조회한 로우 수 : "+donglist.size());
		   } catch (Exception e) {
			   e.printStackTrace();
		   }
		   return donglist;
	   }
	   public static void main(String[] args) {
		SqlMapCommonDao zdo = new SqlMapCommonDao();
		//zdo.getSiGuList(null);
		//zdo.getguList(null);
	}
}
