package com.siot.model;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;





@Component
public class ProductDao {
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
	
	 public List<ProductBean> getWeddingList() {
	      SqlSession sqlSession = sqlSessionFactory.openSession();
	      List<ProductBean> productWeddingList = sqlSession.selectList("getWeddingList");
	      sqlSession.commit();
	      sqlSession.close();
	      return productWeddingList;
	   }
	 public List<ProductBean> getDailyList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession();
		 List<ProductBean> productDailyList = sqlSession.selectList("getDailyList");
	     sqlSession.commit();
		 sqlSession.close();
		 return productDailyList;
	 }
	 
	 public List<ProductBean> getUniqueList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession();
		 List<ProductBean> productUniqueList = sqlSession.selectList("getUniqueList");
		 sqlSession.close();
		 return productUniqueList;
	 }
	 public List<ProductBean> getGoodbyeitemList() {
		 SqlSession sqlSession = sqlSessionFactory.openSession();
		 List<ProductBean> productGoodbyeitemList = sqlSession.selectList("getGoodbyeitemList");
		 sqlSession.close();
		 return productGoodbyeitemList;
	 }
	 
	 
	public int insertProduct(ProductBean productBean) {
		int result =0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertProduct",productBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	
	
	
	public List<ProductBean> allProductList() { //전달 ()
		List<ProductBean> productList = null;
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		productList = sqlSession.selectList("allProductList");
		sqlSession.close();
		
		return productList;
		
	}
	
	
	
	
	public ProductBean productInfo (int no) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		ProductBean productBean = sqlSession.selectOne("productInfo", no);
		sqlSession.close();
		return productBean;
	}
 	
	
	
	
	public int productDelete (int no) {
		int result =0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("productDelete", no);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}

	public int productUpdate (ProductBean productBean) {
		int result =0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("productUpdate", productBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	public String productName (int no) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		String productName = sqlSession.selectOne("productName", no);
		return productName;
	}
	
	public ProductBean getOneProduct (int pdtNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		ProductBean productBean = sqlSession.selectOne("getOneProduct", pdtNo);
		sqlSession.close();
		return productBean;
	}
	
}
