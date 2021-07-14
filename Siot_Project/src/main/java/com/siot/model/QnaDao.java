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
public class QnaDao {
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
	
	public int insertQna(QnaBean qnaBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertQna", qnaBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	
	public List<QnaBean> showAllQna(int start,int end) {
		List<QnaBean> qnaList = null;
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		qnaList = sqlSession.selectList("showAllQna",page);
		sqlSession.close();
		
		return qnaList;
	}
	public QnaBean qnaInfo(int no) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		QnaBean qnaBean = sqlSession.selectOne("qnaInfo",no);
		sqlSession.close();
		return qnaBean;
	}
	public List<Integer> qnaNo() {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<Integer> qnaNo = sqlSession.selectList("qnaNo");
		sqlSession.close();
		return qnaNo;
	}
	public List<QnaBean> userQnaList(int no){
		List<QnaBean> userQnaList = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		userQnaList = sqlSession.selectList("userQnaList",no);
		sqlSession.close();
		
		return userQnaList;
	}
	public int getQnaTotal() {
		int total = 0;

		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getQnaTotal");
		sqlSession.close();

		return total;
	}
	public int updateQna(QnaBean qnaBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("updateQna", qnaBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	public int deleteQna(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("deleteQna", no);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	public QnaBean getSelectOneQna(int no) {
	      QnaBean qnaBean = new QnaBean();
	      SqlSession sqlSession = sqlSessionFactory.openSession();
	      qnaBean = sqlSession.selectOne("getSelectOneQna",no);
	      sqlSession.close();
	      return qnaBean;
	   }
}
