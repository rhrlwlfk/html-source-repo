package com_dao;

import java.io.Reader;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.Logger;

public class SqlMapBookDao {
   Logger logger = Logger.getLogger(SqlMapBookDao.class); 
   SqlSessionFactory sqlMapper = null;
   /*****************************************
    * 도서정보 조회하기 구현
    * @param pMap - 사용자가 자동완성 textbox에 입력한 도서제목 정보
    * @return blist - 사용자가 입력한 도서정보를 선분조건(Like패턴)으로 검색하여 결과 반환
    *****************************************/
   public List<Map<String,Object>> bookList(Map<String,Object> pMap){
      //25번에서 선언만 되어 있다. 따라서 검색 결과가 존재하지 않을 경우 NullPointerException의
      //원인이 될 수 있다.
      //가급적이면 에러를 피해 갈 수 있도록 코딩을 전개한다.
      List<Map<String,Object>> blist = new ArrayList<>();
      String resource = "orm/mybatis/Configuration.xml";
      try {
         Reader reader = Resources.getResourceAsReader(resource);
         sqlMapper = new SqlSessionFactoryBuilder().build(reader);
         SqlSession sqlSec = sqlMapper.openSession();
         blist = sqlSec.selectList("bookList",pMap);
         logger.info("blist.size() ===>"+blist.size());
      } catch (Exception e) {
         e.printStackTrace();
      }
      return blist;
      }
   public static void main(String[] args) {
      SqlMapBookDao eDao = new SqlMapBookDao();
      List<Map<String,Object>> bookList =eDao.bookList(null);
   }
}