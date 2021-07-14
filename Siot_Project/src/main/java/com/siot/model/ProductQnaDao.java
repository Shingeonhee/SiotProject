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
public class ProductQnaDao {
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
	
	
	//상품no전달받아서 상품no값 입력
	public int insertProductQna(ProductQnaBean productQnaBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertProductQna", productQnaBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	
	
	public ProductQnaBean productQnaInfo(int no) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		ProductQnaBean productQnaBean = sqlSession.selectOne("productQnaInfo",no);
		sqlSession.close();
		return productQnaBean;
	}
	//상품페이지
	public List<ProductQnaBean> oneProductQnaList(int productNo,int start,int end) {
		List<ProductQnaBean> oneProductQnaList = null;
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		page.put("productNo", productNo);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		oneProductQnaList = sqlSession.selectList("oneProductQnaList",page);
		sqlSession.close();
		return oneProductQnaList;
	}
	
	
	public int oneProductQnaTotal(int productNo) {
		int total = 0;

		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("oneProductQnaTotal",productNo);
		sqlSession.close();

		return total;
	}
	//관리자페이지
	public int getProductQnaTotal() {
		int total = 0;

		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getProductQnaTotal");
		sqlSession.close();

		return total;
	}
	public List<ProductQnaBean> showProductQnaList(int start,int end) {
		List<ProductQnaBean> productQnaList = null;
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		productQnaList = sqlSession.selectList("showProductQnaList",page);
		sqlSession.close();
		
		return productQnaList;
	}

	public int updatePdtQna(ProductQnaBean productQnaBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("updatePdtQna", productQnaBean);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	
	
	
	////비밀번호찾기
	
	public String getPdtQnaPassword(int no) {
		String password ="";
	
		SqlSession sqlSession = sqlSessionFactory.openSession();
		password = sqlSession.selectOne("getPdtQnaPassword",no);
		sqlSession.close();
		
		return password;
	}
	
	/////qna삭제
	
	public int deletePdtQna(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("deletePdtQna", no);
		sqlSession.commit();
		sqlSession.close();
				
		return result;
	}
	public List<Integer> pdtQnaNo() {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<Integer> pdtQnaNo = sqlSession.selectList("pdtQnaNo");
		sqlSession.close();
		return pdtQnaNo;
	}
	
}
