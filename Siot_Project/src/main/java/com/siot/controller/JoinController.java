package com.siot.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.siot.model.PaymentBean;
import com.siot.model.PaymentDao;
import com.siot.model.PaymentDetailBean;
import com.siot.model.PaymentDetailDao;
import com.siot.model.ProductBean;
import com.siot.model.ProductDao;
import com.siot.model.QnaBean;
import com.siot.model.QnaDao;
import com.siot.model.UserBean;
import com.siot.model.UserDao;
import com.siot.utils.ScriptWriterUtil;

@Controller
public class JoinController {

	private static final Logger logger = LoggerFactory.getLogger(JoinController.class);

	@Autowired
	UserDao userDao;

	@Autowired
	UserBean userBean;

	@Autowired
	UserBean loggedUserInfo;

	@Autowired
	QnaBean qnaBean;

	@Autowired
	QnaDao qnaDao;

	@Autowired
	PaymentBean paymentBean;
	@Autowired
	PaymentDao paymentDao;

	@Autowired
	PaymentDetailBean paymentDetailBean;
	@Autowired
	PaymentDetailDao paymentDetailDao;
	
	@Autowired
	ProductBean productBean;
	@Autowired
	ProductDao productDao;

	@RequestMapping("/UserSubJoin.do")
	public String userSubJoin() {
		return "user/user_joinsub";
	}

	@GetMapping("/UserJoinForm.do")
	public String userJoinForm() {
		return "user/user_join";
	}

	@RequestMapping("/UserJoin.do")
	public String UserJoin(UserBean userBean, HttpServletResponse response, HttpServletRequest request,
			MultipartFile multipartProfileImg, HttpSession session) throws IOException {

		String context = request.getContextPath();
		String fileRoot = "C:\\user_image\\";
		String originalFileName = multipartProfileImg.getOriginalFilename();
		String extention = FilenameUtils.getExtension(originalFileName);
		String savedFileName = UUID.randomUUID() + "." + extention;
		File targetFile = new File(fileRoot + savedFileName);
		String dbSavedFile = null;
		try {
			InputStream fileStream = multipartProfileImg.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}

		if (extention.length() < 3) {
			dbSavedFile = context + "/userProject/" + "default.png";
		} else {
			dbSavedFile = context + "/userProject/" + savedFileName;
		}

		userBean.setProfileImg(dbSavedFile);
		int result = userDao.insertUser(userBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "회원가입되었습니다.", "/");

			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "회원가입에 실패하였습니다.");
			return null;
		}

	}

	@GetMapping("/UserLoginForm.do")
	public String userLoginForm() {
		return "user/user_login";
	}

	@PostMapping("/UserLogin.do")
	public String userLogin(String id, String password, Model model, HttpSession session, HttpServletResponse response)
			throws IOException {

		userBean.setId(id);
		userBean.setPassword(password);
		String verify = "0";
		loggedUserInfo = userDao.getLoginUser(userBean);
		if (loggedUserInfo != null) {
			verify = loggedUserInfo.getVerify();
			System.out.println("verify===" + verify);
		} else {
			verify = "2";
		}
		if (loggedUserInfo != null) {
			session.setAttribute("loggedUserInfo", loggedUserInfo);
			model.addAttribute("verify", verify);
			model.addAttribute("id", id);
			ScriptWriterUtil.AndNext(response, "/");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "잘못된 아이디 또는 비밀번호입니다.");
			return null;
		}

	}

	// 로그아웃
	@GetMapping("/UserLogout.do")
	public String userLogout(HttpSession session, HttpServletResponse response) throws IOException {
		loggedUserInfo = (UserBean) session.getAttribute("loggedUserInfo");
		if (loggedUserInfo == null) {

			return null;
		} else {
			ScriptWriterUtil.AndNext(response, "/");
			session.invalidate();

			return null;
		}
	}

	// 아이디체크
	@RequestMapping(value = "/UserIdCheck.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String userIdCheck(String id, Model model) throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		int result = userDao.userIdCheck(id);
		HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
		hashMap.put("result", result);
		String jsonData = objectMapper.writeValueAsString(hashMap);
		logger.info(jsonData);
		return jsonData;
	}

	// 삭제
	@GetMapping("/UserDeleteForm.do")
	public String userDeleteForm(int no, Model model) {
		userBean = userDao.getSelectOneUser(no);
		model.addAttribute("userBean", userBean);
		return "user/user_delete";
	}

	@RequestMapping("/UserDelete.do")
	public String userDelete(int no, HttpServletResponse response, HttpSession session) throws IOException {
		int result = userDao.deleteUser(no);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "회원이 삭제되었습니다.", "/");
			session.invalidate();
		} else {
			ScriptWriterUtil.alertAndBack(response, "회원 삭제에 실패했습니다.");
		}
		return null;
	}

	// 수정
	@RequestMapping("/UserUpdateForm.do")
	public String userUpdateForm(int no, Model model) {
		userBean = userDao.getSelectOneUser(no);
		model.addAttribute("userBean", userBean);
		model.addAttribute("no", no);
		return "user/user_update";
	}

	@RequestMapping("/UserUpdate.do")
	public String userUpdate(int no, UserBean userBean, HttpServletResponse response, HttpServletRequest request,
			MultipartFile multipartProfileImg) throws IOException {

		String dbPassword = userDao.getPasswordUser(no);

		if (dbPassword.equals(userBean.getPassword())) {
			int result = userDao.updateUser(userBean);
			if (result > 0) {
				ScriptWriterUtil.AndNext(response, "/");
				return null;
			} else {
				ScriptWriterUtil.alertAndBack(response, "회원정보 변경되지 않았습니다.");
				return null;
			}
		} else {
			ScriptWriterUtil.alertAndBack(response, " 비밀번호를 확인해 주세요.");
			return null;
		}
	}

	@RequestMapping("/Inquire.do")
	public String inquire(Model model) {
		int no = loggedUserInfo.getNo();
		List<QnaBean> userQnaList = qnaDao.userQnaList(no);
		int qnaCount = userQnaList.size();
		model.addAttribute("userQnaList", userQnaList);
		model.addAttribute("qnaCount", qnaCount);
		return "user/user_inquire";
	}

	@RequestMapping("/MyPage.do")
	public String myPage() {

		return "user/user_mypage";
	}

	@RequestMapping("/OrderCheck.do")
	public String orderCheck(int idNo, Model model) {
		 String paymentNo = "";
	      List<PaymentBean> paymentList = null;
	      List<PaymentDetailBean> list = null;
	      List<List<PaymentDetailBean>> paymentDetailList = new ArrayList<List<PaymentDetailBean>>();
	      List<ProductBean> payPdtList = new ArrayList<ProductBean>();
	      paymentList = paymentDao.getPaymentForId(idNo);
	      
	      for(int i=0; i<paymentList.size();i++) {
	         paymentBean = paymentList.get(i);
	         paymentNo = paymentBean.getPaymentNo();
	         list = paymentDetailDao.getPaymentDetailForPaymentNo(paymentNo);
	         for(int j=0 ; j<list.size(); j++) {
	            int pdtNo = list.get(j).getPdtNo();
	            productBean = productDao.getOneProduct(pdtNo);
	            payPdtList.add(productBean);
	         }
	         paymentDetailList.add(list);
	      }
	      
	      model.addAttribute("paymentList", paymentList);
	      model.addAttribute("paymentDetailList", paymentDetailList);
	      model.addAttribute("payPdtList", payPdtList);
	      return "user/user_orderCheck";
	}

	@RequestMapping("/CancleChange.do")
	public String cancleChage() {

		return "user/user_cancleChange";
	}

	@RequestMapping("/Saving.do")
	public String savingMoney() {

		return "user/user_savingMoney";
	}

	// 관리자 페이지
	@RequestMapping("/Manager.do")
	public String managerLogin() {
		return "user/user_manager";
	}

	@RequestMapping("/About.do")
	public String about() {
		return "category/about";
	}
}
