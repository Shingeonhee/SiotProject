package com.siot.model;

import java.io.InputStream;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.springframework.stereotype.Component;

@Component
public class ShopCartDao {
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

//	public List<ShopCartBean> showShopCartnonLogin() {
//		SqlSession sqlSession = sqlSessionFactory.openSession();
//		List<ShopCartBean> nonLoginShopCartList = sqlSession.selectList("showShopCartnonLogin");
//		sqlSession.close();
//		return nonLoginShopCartList;
//	}
//	
//	
//	public List<ShopCartBean> showWish() {
//		SqlSession sqlSession = sqlSessionFactory.openSession();
//		List<ShopCartBean> wishList = sqlSession.selectList("showWish");
//		sqlSession.close();
//		return wishList;
//	}
	public UserBean getLoginUser(UserBean userBean) {
		UserBean loggedUserInfo = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		loggedUserInfo = sqlSession.selectOne("getLoginUser",userBean);
		sqlSession.close();
		return loggedUserInfo;
	}
	
	
	
	
	
	public List<ShopCartBean> showAllShopCart(int idNo) {
		SqlSession sqlSession = sqlSessionFactory.openSession();
		List<ShopCartBean> ShopCartList = sqlSession.selectList("showAllShopCart",idNo);
		sqlSession.close();
		return ShopCartList;
	}

	public ShopCartBean getSelectOneShopCart(int no) {
		ShopCartBean ShopCartBean = new ShopCartBean();
		SqlSession sqlSession = sqlSessionFactory.openSession();
		ShopCartBean = sqlSession.selectOne("getSelectOneShopCart", no);
		sqlSession.close();
		return ShopCartBean;
	}

	public ProductBean getSelectOneProduct(int pdtNo) {
		ProductBean productBean;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		productBean = sqlSession.selectOne("getSelectOneProduct", pdtNo);
		sqlSession.close();
		return productBean;
	}
	
//	public int updateShopCart(ShopCartBean ShopCartBean) {
//		int result = 0;
//		SqlSession sqlSession = sqlSessionFactory.openSession();
//		result = sqlSession.update("updateShopCart", ShopCartBean);
//		sqlSession.commit();
//		sqlSession.close();
//		return result;
//	}

	public int deleteShopCart(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("deleteShopCart", no);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	public int paymentShopCartDelete(int idNo,int pdtNo) {
		int result = 0;
		HashMap<String,Integer> hashMap = new HashMap<String,Integer>();
		hashMap.put("idNo", idNo);
		hashMap.put("pdtNo", pdtNo);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("paymentShopCartDelete",hashMap);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	// 전체 게시글 수
	public int getTotalShopCart(int idNo) {
		int total = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getTotalShopCart",idNo);
		sqlSession.close();
		return total;
	}

	public int allPriceShopCart(int idNo) {
		int total = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			total = sqlSession.selectOne("allPriceShopCart",idNo);
		} catch (Exception e) {
			total = 0;
		}
		sqlSession.close();
		return total;
	}
	
	public int delivery(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			result = sqlSession.selectOne("delivery",no);
		} catch (Exception e) {
			result = 0;
		}
		sqlSession.close();
		return result;
	}
	public int changeAmount(int no,int amount) {
		int result = 0;
		HashMap<String,Integer> hashMap = new HashMap<String,Integer>();
		hashMap.put("no", no);
		hashMap.put("amount", amount);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("changeAmount", hashMap);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	
	
	
	public int geTotalPriceShopCart(ShopCartBean shopCartBean) {
		int total = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		try {
			total = sqlSession.selectOne("geTotalPriceShopCart",shopCartBean);
		} catch (Exception e) {
			total = 0;
		}
		System.out.println("total==="+total);
		sqlSession.close();
		return total;
	}
	
	
	public int SelectBoxChange(int no,int selectBox){
		int result = 0;
		HashMap<String,Integer> page = new HashMap<String,Integer>();
		page.put("selectBox", selectBox);
		page.put("no", no);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("SelectBoxChange", page);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	public int insertShopCart(int idNo,ShopCartBean shopCartBean){
		int result = 0;
//		Map<String,Object> page = new HashMap<String,Object>();
//		page.put("idNo", idNo);
//		page.put("pdtNo", productBean.getNo());
//		page.put("pdtName", productBean.getName());
//		page.put("price", productBean.getPrice());
//		page.put("mainImg", productBean.getMainimg());
//		page.put("selectBox", 0);
//		page.put("wishOn", 0);
		System.out.println("idNo1===="+idNo);
		System.out.println("idNo2===="+shopCartBean.getIdNo());
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertShopCart", shopCartBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	public int getSelectOneWish(int no){
		int wishOn = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		wishOn = sqlSession.selectOne("getSelectOneWish", no);
		sqlSession.close();
		return wishOn;
	}
	
	public int changeWish(int no, int wishOn){
		int result = 0;
		HashMap<String,Integer> page = new HashMap<String,Integer>();
		page.put("no", no);
		page.put("wishOn", wishOn);
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("changeWish", page);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
}
