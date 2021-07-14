package com.siot.model;

import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class WishDao {
   private static SqlSessionFactory sqlSessionFactory;
   static {
      try {
         String resource = "com/siot/mybatis/config.xml";
         InputStream inputStream = Resources.getResourceAsStream(resource);
         sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
      } catch (IOException e) {
         e.printStackTrace();
      }
   }

   public UserBean getLoginUser(UserBean userBean) {
      UserBean loggedUserInfo = null;
      SqlSession sqlSession = sqlSessionFactory.openSession();
      loggedUserInfo = sqlSession.selectOne("getLoginUser", userBean);
      sqlSession.close();
      return loggedUserInfo;
   }


   public int insertWish(int idNo, int pdtNo) {
//	   System.out.println("idNo"+idNo);
//	   System.out.println("pdtNo"+pdtNo);
      int result = 0;
      HashMap<String,Integer> hashMap = new HashMap<String,Integer>();
      hashMap.put("idNo",idNo);
      hashMap.put("pdtNo",pdtNo);
      SqlSession sqlSession = sqlSessionFactory.openSession();
      result = sqlSession.insert("insertWish", hashMap);
      sqlSession.commit();
      sqlSession.close();
      return result;
   }

   
   public List<WishBean> getPdtNoList(int idNo) {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      List<WishBean> pdtNoList = sqlSession.selectList("getPdtNoList", idNo);
      sqlSession.close();
      return pdtNoList;
   }
   
   
   public ProductBean getOneProduct(int pdtNo) {
      ProductBean productBean = null;
      SqlSession sqlSession = sqlSessionFactory.openSession();
      productBean = sqlSession.selectOne("getOneProduct", pdtNo);
      sqlSession.close();
      return productBean;
   }
   
   
   public int deleteWish(int idNo, int pdtNo) {
	   int result = 0;
	   HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
	   hashMap.put("idNo",idNo);
	   hashMap.put("pdtNo",pdtNo);
	   SqlSession sqlSession = sqlSessionFactory.openSession();
	   result = sqlSession.delete("deleteWish",hashMap);
	   sqlSession.commit();
	   sqlSession.close();
	   return result;
   }
   
   
   public int getWish(int idNo, int pdtNo) {
	   int result = 0;
	   HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
	   hashMap.put("idNo",idNo);
	   hashMap.put("pdtNo",pdtNo);
	   SqlSession sqlSession = sqlSessionFactory.openSession();
	   result = sqlSession.selectOne("getWish",hashMap);
	   sqlSession.close();
	   return result;
   }
   
   
   
   
   
   
}















