package com_dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapEmpDao {
	Logger logger  = Logger.getLogger(SqlMapEmpDao.class);///어떤로그파일을 
   SqlSessionFactory sqlMapper = null;
   String resource = "orm/mybatis/Configuration.xml";//오라클 통로를 열어주는거 비슷한거아닐까?? 
   /****************************
    * 사원등록 구현하기 
    * sql INSERT INTO values(?,?,?,?,?,?,?)
    * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
    * @return int
    */
   public int empINS(Map<String,Object> pMap) {
	   logger.info("empINS 호출");
	   int result = 0;
	   try {
		   Reader reader = Resources.getResourceAsReader(resource);
		   sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		   //sql문을 요청하기 위한 SqlSession객체 생성하기
		   SqlSession sqlSes = sqlMapper.openSession();
		   //result = sqlSes.update("empINS2",pMap);
		   result = sqlSes.insert("empINS",pMap);
		   //오토커밋모드가 꺼진 상태이므로 반드시 커밋 해주어야 한다. 
		   sqlSes.commit();
		   logger.info("result" + result);
	   }catch (Exception e) {
		// TODO: handle exception
		   e.printStackTrace();//힌트가 많아
	}
	  return result;
   }
   /****************************
    * 사원수정 구현하기 
    * sql UPDATE emp SET.... WHERE 컬럼명
    * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
    * @return int
    */
   public int empUPD(Map<String,Object> pMap) {
	   logger.info("empUPD 호출");
	   int result = 0;
	   try {
		   Reader reader = Resources.getResourceAsReader(resource);
		   sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		   //sql문을 요청하기 위한 SqlSession객체 생성하기
		   SqlSession sqlSes = sqlMapper.openSession();
		   //result = sqlSes.update("empINS2",pMap);
		   result = sqlSes.update("empUPD",pMap);
		   //오토커밋모드가 꺼진 상태이므로 반드시 커밋 해주어야 한다. 
		   sqlSes.commit();
		   logger.info("result" + result);
	   }catch (Exception e) {
		   // TODO: handle exception
		   e.printStackTrace();//힌트가 많아
	   }
	   return result;
   }
   /****************************
    * 사원삭제 구현하기 
    * sql DELETE FROM WHERE 컬럼명 IN (값)
    * @param pMap(사원번호,사원명,job,그룹코드,입사일자,급여,인센티브,부서번호)
    * @return int
    */
   public int empDEL(String empnos[]) {
	   logger.info("empDEL 호출");
	   int result = 0;
	   try {
		   Reader reader = Resources.getResourceAsReader(resource);
		   sqlMapper = new SqlSessionFactoryBuilder().build(reader);
		   List<Integer> list = new ArrayList<Integer>();
		   for(int i=0;i<empnos.length;i++) {
			   list.add(Integer.parseInt(empnos[i]));
		   }
		   //sql문을 요청하기 위한 SqlSession객체 생성하기
		   SqlSession sqlSes = sqlMapper.openSession();
		   //result = sqlSes.update("empINS2",pMap);
		   result = sqlSes.delete("empDelete",list);
		   //오토커밋모드가 꺼진 상태이므로 반드시 커밋 해주어야 한다. 
		   sqlSes.commit();
		   logger.info("result" + result);
	   }catch (Exception e) {
		   // TODO: handle exception
		   e.printStackTrace();//힌트가 많아
	   }
	   return result;
   }
   public List<Map<String,Object>> empList(Map<String,Object> pMap){
      List<Map<String,Object>> elist = null;
//      logger.info("emlpList 호출성공");
//      logger.debug("debug");
//      logger.warn("warn");
//      logger.error("error");
//      logger.fatal("fatal"); 
      String resource = "orm/mybatis/Configuration.xml";//오라클 통로를 열어주는거 비슷한거아닐까?? 
      try {
         Reader reader = Resources.getResourceAsReader(resource);
         sqlMapper = new SqlSessionFactoryBuilder().build(reader);
         //sql문을 요청하기 위한 SqlSession객체 생성하기
         SqlSession sqlSec = sqlMapper.openSession();
         elist = sqlSec.selectList("empList",pMap);
         System.out.println("조회한 로우 수 : "+elist.size());
      } catch (Exception e) {
         e.printStackTrace();
      }
      return elist;
   }
   public static void main(String[] args) {
	SqlMapEmpDao eDao = new SqlMapEmpDao();
	eDao.empList(null);
	Map<String, Object> rmap = new HashMap<String, Object>();
		rmap.put("empno",7934);
//	rmap.put("ename","이상현");
//	rmap.put("hiredate",2020-12-01);
	//int result = eDao.empDEL(rmap1);
	eDao.empList(rmap);
   		}		
	}