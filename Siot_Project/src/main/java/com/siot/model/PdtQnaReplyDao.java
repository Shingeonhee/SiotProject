package com.siot.model;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class PdtQnaReplyDao {
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
	
	public int insertPdtQnaReply(PdtQnaReplyBean pdtQnaReplyBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertPdtQnaReply", pdtQnaReplyBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	
	public List<PdtQnaReplyBean> pdtQnaReplyList(int qnaNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<PdtQnaReplyBean> pdtReplyList = sqlSession.selectList("pdtQnaReplyList",qnaNo);
		sqlSession.close();
		return pdtReplyList;
	}
	
	public int pdtQnaReplyDelete(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("pdtQnaReplyDelete", no);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	public String getPdtReplyPassword(int no) {
		String password ="";
	
		SqlSession sqlSession = sqlSessionFactory.openSession();
		password = sqlSession.selectOne("getPdtReplyPassword",no);
		sqlSession.close();
		
		return password;
	}
	//댓글달렸는지 여부
	public int pdtReplyCheck(int qnaNo) {
		int count = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		count = sqlSession.selectOne("pdtReplyCheck",qnaNo);
		sqlSession.close();
		return count;
	}
}
