package com.siot.model;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;
@Component
public class QnaReplyDao {
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
	
	public int insertQnaReply(QnaReplyBean qnaReplyBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertQnaReply", qnaReplyBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	public List<QnaReplyBean> qnaReplyList(int qnaNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<QnaReplyBean> replyList = sqlSession.selectList("qnaReplyList",qnaNo);
		sqlSession.close();
		return replyList;
	}
	//댓글달렸는지 여부
		public int qnaReplyCheck(int qnaNo) {
			int count = 0;
			SqlSession sqlSession = sqlSessionFactory.openSession();
			count = sqlSession.selectOne("qnaReplyCheck",qnaNo);
			sqlSession.close();
			return count;
		}
		
	///댓글삭제
		
		public int qnaReplyDelete(int no) {
			int result = 0;
			SqlSession sqlSession = sqlSessionFactory.openSession();
			result = sqlSession.delete("qnaReplyDelete", no);
			sqlSession.commit();
			sqlSession.close();
					
			return result;
		}
		
}
