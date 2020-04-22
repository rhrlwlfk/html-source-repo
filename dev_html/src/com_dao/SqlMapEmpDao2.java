package com_dao;

import java.io.Reader;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapEmpDao2 {
	Logger logger  = Logger.getLogger(SqlMapEmpDao2.class);///어떤로그파일을 
   SqlSessionFactory sqlMapper = null;
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
	SqlMapEmpDao2 eDao = new SqlMapEmpDao2();
	eDao.empList(null);
   		}		
	}