package com.siot.model;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class PaymentDao {
	
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
	
	public int insertPayment(PaymentBean paymentBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertPayment", paymentBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	public List<PaymentBean> showAllPayment(int start,int end) {
		List<PaymentBean> paymentList = null;
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		paymentList = sqlSession.selectList("showAllPayment",page);
		sqlSession.close();
		
		return paymentList;
	}
	
	public int getPaymentTotal() {
		int total = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getPaymentTotal");
		sqlSession.close();
		return total;
	}
	
	public List<PaymentBean> getPaymentForId(int idNo) {
		List<PaymentBean> paymentList = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		paymentList = sqlSession.selectList("getPaymentForId",idNo);
		sqlSession.close();
		return paymentList;
	}
	
	public PaymentBean getPaymentForPaymentNo(String paymentNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		PaymentBean paymentBean = sqlSession.selectOne("getPaymentForPaymentNo",paymentNo);
		sqlSession.close();
		return paymentBean;
	}
	
	public UserBean getOneUserForIdNo(int idNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		UserBean userBean = sqlSession.selectOne("getOneUserForIdNo",idNo);
		sqlSession.close();
		return userBean;
	}
}
