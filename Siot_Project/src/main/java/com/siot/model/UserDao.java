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
public class UserDao {
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
	
	
	public int insertUser(UserBean userBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.insert("insertUser",userBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
		
	}
	
	
	public UserBean getLoginUser(UserBean userBean) {
		UserBean loggedUserInfo = null;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		loggedUserInfo = sqlSession.selectOne("getLoginUser",userBean);
		sqlSession.close();
		return loggedUserInfo;
	}
	
	
//	public UserBean getLoginManager(UserBean userBean) {
//		UserBean loggedManager = null;
//		SqlSession sqlSession = sqlSessionFactory.openSession();
//		sqlSession.selectOne("getLoginManager",userBean);
//		sqlSession.close();
//		return loggedManager;
//	}
	
	
	
	public int userIdCheck(String id) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.selectOne("userIdCheck",id);
		sqlSession.close();
		return result;
	}
	
	public int userPasswordCheck(String pw) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.selectOne("userPasswordCheck",pw);
		sqlSession.close();
		return result;
	}
	
	
	public String getPasswordUser(int no) {
		String password = "";
		SqlSession sqlSession = sqlSessionFactory.openSession();
		password = sqlSession.selectOne("getPasswordUser", no);
		sqlSession.close();
		return password;
	}
	
	public UserBean getSelectOneUser(int no) {
		UserBean userBean = new UserBean();
		SqlSession sqlSession = sqlSessionFactory.openSession();
		userBean = sqlSession.selectOne("getSelectOneUser",no);
		sqlSession.close();
		return userBean;
	}
	
	
	public int deleteUser(int no) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.delete("deleteUser", no);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	
	public int updateUser(UserBean userBean) {
		int result = 0;
		SqlSession sqlSession = sqlSessionFactory.openSession();
		result = sqlSession.update("updateUser", userBean);
		sqlSession.commit();
		sqlSession.close();
		return result;
	}
	
	
	public List<UserBean> showAllUser(int start, int end) {
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("start", start);
		page.put("end", end);
		List<UserBean> userList = null;
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		userList = sqlSession.selectList("showAllUser",page);
		sqlSession.close();
		
		return userList;
	}
	public int getUserTotal() {
		int total = 0;

		SqlSession sqlSession = sqlSessionFactory.openSession();
		total = sqlSession.selectOne("getUserTotal");
		sqlSession.close();

		return total;
	}
	public UserBean userInfo(int no) {
		
		SqlSession sqlSession = sqlSessionFactory.openSession();
		UserBean userBean = sqlSession.selectOne("userInfo",no);
		sqlSession.close();
		return userBean;
	}

	public String getProfileImg(int no) {
		String profileImg ="";
	
		SqlSession sqlSession = sqlSessionFactory.openSession();
		profileImg = sqlSession.selectOne("getProfileImg",no);
		sqlSession.close();
		
		return profileImg;
	}
	
	
}
