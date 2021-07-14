package com.siot.model;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class PdtWishDao {
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

	public List<PdtWishBean> showAllPdtWish() {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<PdtWishBean> PdtWishList = sqlSession.selectList("showAllPdtWish");
		sqlSession.close();
		return PdtWishList;
	}

	public PdtWishBean getSelectOnePdtWish(int no) {
		PdtWishBean pdtWishBean = new PdtWishBean();
		SqlSession sqlSession = sqlSessionFactory.openSession();
		pdtWishBean = sqlSession.selectOne("getSelectOnePdtWish", no);
		sqlSession.close();
		return pdtWishBean;
	}

	public int insertPdtWish(PdtWishBean PdtWishBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertPdtWish", PdtWishBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public int updatePdtWish(PdtWishBean PdtWishBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("updatePdtWish", PdtWishBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public int deletePdtWish(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("deletePdtWish", no);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public String getPasswordPdtWish(int no) {
		String password = "";
		SqlSession sqlSession = sqlSessionFactory.openSession();
		password = sqlSession.selectOne("getPasswordPdtWish", no);
		sqlSession.close();
		return password;
	}

	public PdtWishBean getLoginPdtWish(PdtWishBean PdtWishBean) {
		PdtWishBean loggedPdtWishInfo = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		loggedPdtWishInfo = sqlSession.selectOne("getLoginPdtWish", PdtWishBean);
		sqlSession.close();
		return loggedPdtWishInfo;
	}

	public int PdtWishIdCheck(String id) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.selectOne("PdtWishIdCheck", id);
		sqlSession.close();
		return result;
	}

//전체 게시글 수
	public int getTotalPdtWish() {
		int total = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getTotalPdtWish");
		sqlSession.close();
		return total;
	}
}
