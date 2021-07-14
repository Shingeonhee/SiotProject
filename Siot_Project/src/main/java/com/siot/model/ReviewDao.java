package com.siot.model;

import java.io.IOException;
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
public class ReviewDao {
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
	
	
	public int insertReview(ReviewBean reviewBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertReview",reviewBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	public List<ReviewBean> showReviewList(int start,int end,int productNo) {
		List<ReviewBean> reviewList = null;
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		page.put("productNo", productNo);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		reviewList = sqlSession.selectList("showReviewList",page);
		sqlSession.close();
		
		return reviewList;
	}
	
	public int reviewTotal(int productNo) {
		int total = 0;

		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("reviewTotal",productNo);
		sqlSession.close();

		return total;
	}
	
	public String getReviewPassword(int no) {
		String password ="";
	
		SqlSession sqlSession = sqlSessionFactory.openSession();
		password = sqlSession.selectOne("getReviewPassword",no);
		sqlSession.close();
		
		return password;
	}
	
	public int deleteReview(int no) {
		int result =0;
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("deleteReview",no);
		sqlSession.commit();
		sqlSession.close();
		
		return result;
	}
}
