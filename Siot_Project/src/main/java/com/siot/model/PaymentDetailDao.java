package com.siot.model;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class PaymentDetailDao {
   private static SqlSessionFactory sqlSessionFactory;
   static {
      try {
         String resource = "com/siot/mybatis/config.xml";
         InputStream inputStream = Resources.getResourceAsStream(resource);
         sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
      } catch (Exception e) {
         e.printStackTrace();
      }
   }
   
   public int insertPaymentDetail(PaymentDetailBean paymentDetailBean) {
      int result = 0;
      SqlSession sqlSession = sqlSessionFactory.openSession();
      result = sqlSession.insert("insertPaymentDetail", paymentDetailBean);
      sqlSession.commit();
      sqlSession.close();
      return result;
   }
   
   public List<PaymentDetailBean> getPaymentDetailForPaymentNo(String paymentNo) {
		List<PaymentDetailBean> paymentDetailList = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		paymentDetailList = sqlSession.selectList("getPaymentDetailForPaymentNo",paymentNo);
		sqlSession.close();
		return paymentDetailList;
	}
}