package com.siot.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.siot.model.PdtQnaReplyBean;
import com.siot.model.PdtQnaReplyDao;
import com.siot.model.ProductBean;
import com.siot.model.ProductDao;
import com.siot.model.ProductQnaBean;
import com.siot.model.ProductQnaDao;
import com.siot.model.QnaBean;
import com.siot.model.QnaDao;
import com.siot.model.QnaReplyBean;
import com.siot.model.QnaReplyDao;
import com.siot.model.ReviewBean;
import com.siot.model.ReviewDao;
import com.siot.model.UserBean;
import com.siot.model.UserDao;
import com.siot.utils.ScriptWriterUtil;

@Controller
public class QnaController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	@Autowired
	QnaBean qnaBean;
	@Autowired
	QnaDao qnaDao;

	@Autowired
	ProductBean productBean;
	@Autowired
	ProductDao productDao;

	@Autowired
	ProductQnaBean productQnaBean;
	@Autowired
	ProductQnaDao productQnaDao;

	@Autowired
	QnaReplyBean qnaReplyBean;
	@Autowired
	QnaReplyDao qnaReplyDao;

	@Autowired
	PdtQnaReplyBean pdtQnaReplyBean;
	@Autowired
	PdtQnaReplyDao pdtQnaReplyDao;

	@Autowired
	UserBean userBean;
	@Autowired
	UserDao userDao;

	@Autowired
	ReviewBean reviewBean;
	@Autowired
	ReviewDao reviewDao;

	@Autowired
	UserBean loggedUserInfo;

	@GetMapping("/Qna.do")
	public String qna() {

		return "qna/qna_write";
	}

	@PostMapping("/QnaWrite.do")
	public String qnaWrite(HttpServletRequest request, HttpServletResponse response, QnaBean qnaBean)
			throws IOException {

		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");
		qnaBean.setName(userBean.getName());
		qnaBean.setProfileImg(userBean.getProfileImg());
		qnaBean.setUserNo(userBean.getNo());

		int result = qnaDao.insertQna(qnaBean);

		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "글이 등록되었습니다", "Inquire.do?no=" + userBean.getNo());
			return null;

		} else {
			ScriptWriterUtil.alertAndBack(response, "글이 등록되지 않았습니다");
			return null;
		}
	}

	@GetMapping("/ProductQna.do")
	public String productQna(int no, Model model, HttpServletResponse response, HttpServletRequest request)
			throws IOException {

		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");

		if (loggedUserInfo == null) {
			ScriptWriterUtil.alertAndBack(response, "로그인후 이용하세요");
			return "user/user_login";
		} else {
			String productName = productDao.productName(no);

			int productNo = no;
			model.addAttribute("productName", productName);
			model.addAttribute("productNo", productNo);
			return "qna/product_qna_write";
		}

	}

	@PostMapping("/ProductQnaWrite.do")
	public String productQnaWrite(HttpServletRequest request, HttpServletResponse response,
			ProductQnaBean productQnaBean, int productNo) throws IOException {
		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");
		productQnaBean.setProductNo(productNo);
		productQnaBean.setName(userBean.getName());
		productQnaBean.setUserNo(userBean.getNo());
		productQnaBean.setUserPassword(userBean.getPassword());
		int result = productQnaDao.insertProductQna(productQnaBean);

		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "글이 등록되었습니다", "ProductInfo.do?no=" + productNo);
			return null;

		} else {
			ScriptWriterUtil.alertAndBack(response, "글이 등록되지 않았습니다");
			return null;
		}

	}

	@RequestMapping(value = "/QnaSummerNoteImageUpload.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // json파일로 사용 , 사용하지않으면 jsp를 호출
	public String sendImgFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
			throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		String fileRoot = "C:\\qna_image\\"; // 이미지 업로드할때 담아놓을 외부경로
		String originalFileName = multipartFile.getOriginalFilename(); // 파일이름
		String extension = originalFileName.substring(originalFileName.lastIndexOf(".")); // 확장자명
		String savedFileName = UUID.randomUUID() + extension; // 저장된파일명
		File targetFile = new File(fileRoot + savedFileName);
		String context = request.getContextPath(); // 현재 context root찾기 (Spring-ReplyBoard02/)

		logger.info("context===={}", context);
		logger.info("originalFileName===={}", originalFileName);
		logger.info("savedFileName===={}", savedFileName);
		logger.info("targetFile===={}", targetFile);

		HashMap<String, String> hashMap = new HashMap<String, String>();
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일저장
			hashMap.put("url", context + "/qnaImg/" + savedFileName);
			hashMap.put("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile); // io오류났을때 파일 삭제
			hashMap.put("responseCode", "error");
			e.printStackTrace();
		}
		String jsonData = objectMapper.writeValueAsString(hashMap);
		logger.info("jsonData===={}", jsonData);
		return jsonData;
	}

	// 관리자가보는 전체 1:1qna
	@GetMapping("/QnaList.do")
	public String qnaList(Model model, HttpServletRequest request) {
		String clickedPage = request.getParameter("clickedPage");
		if (clickedPage == null) {
			clickedPage = "1";
		}
		int pagePerCount = 5;
		int total = 0;
		int numbering = 0;
		int currentPage = Integer.parseInt(clickedPage);
		int start = (currentPage - 1) * pagePerCount + 1;
		int end = currentPage * pagePerCount;
		total = qnaDao.getQnaTotal();

		int paginationTotal = (int) Math.floor(total / pagePerCount) + 1;
		int pageGroup = 3;
		int startPage = 1;
		numbering = total - (currentPage - 1) * pagePerCount;

		if (currentPage % pageGroup != 0) {
			startPage = (int) (currentPage / pageGroup) * pageGroup + 1;
		} else {
			startPage = ((int) (currentPage / pageGroup) - 1) * pageGroup + 1;
		}
		int endPage = startPage + pageGroup - 1;
		if (endPage > paginationTotal) {
			endPage = paginationTotal;
		}
		List<QnaBean> qnaList = qnaDao.showAllQna(start, end);

		model.addAttribute("qnaList", qnaList);

		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);
		return "qna/qna_list";
	}

	@RequestMapping(value = "/QnaList02.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, List<Integer>> qnaList02(Model model, HttpServletRequest request) {
		List<Integer> qnaNoList = qnaDao.qnaNo();
		HashMap<String, List<Integer>> hashMap = new HashMap<String, List<Integer>>();
		hashMap.put("qnaNoList", qnaNoList);
		return hashMap;
	}

	@RequestMapping(value = "/QnaReplyCheck.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Integer> qnaReplyCheck(Model model, HttpServletRequest request, int qnaNo) {
		int result = 0;
		HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
		result = qnaReplyDao.qnaReplyCheck(qnaNo);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;
	}

	@GetMapping("/QnaInfo.do")
	public String qnaInfo(int no, Model model) {

		qnaBean = qnaDao.qnaInfo(no);
		model.addAttribute("qnaBean", qnaBean);

		return "qna/qna_info";
	}

	@GetMapping("/QnaUpdateForm.do")
	public String qnaUpdateForm(int no, Model model, HttpServletResponse response) throws IOException {

		qnaBean = qnaDao.qnaInfo(no);
		model.addAttribute("qnaBean", qnaBean);
		return "qna/qna_update";
	}

	@RequestMapping("/QnaUpdate.do")
	public String qnaUpdate(int no, QnaBean qnaBean, Model model, HttpServletResponse response) throws IOException {
		int result = qnaDao.updateQna(qnaBean);
		if (result > 0) {
			ScriptWriterUtil.AndNext(response, "QnaInfo.do?no=" + no);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "수정에 실패하였습니다.");
			return null;
		}
	}

	@RequestMapping("/QnaDelete.do")
	public String qnaUpdate(int no, HttpServletResponse response) throws IOException {
		int result = qnaDao.deleteQna(no);
		if (result > 0) {
			ScriptWriterUtil.AndNext(response, "Inquire.do?no=" + loggedUserInfo.getNo());
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "삭제 실패하였습니다.");
			return null;
		}
	}


	@RequestMapping(value = "/ExQna.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String oneproductQnaList(Model model, HttpServletRequest request, int no) throws JsonProcessingException {

		// System.out.println(no);
		int productNo = no;
		productQnaBean.setProductNo(no);
		String clickedPage = request.getParameter("clickedPage");
		if (clickedPage == null) {
			clickedPage = "1";
		}
		int pagePerCount = 5;
		int total = 0;
		int numbering = 0;
		int currentPage = Integer.parseInt(clickedPage);
		int start = (currentPage - 1) * pagePerCount + 1;
		int end = currentPage * pagePerCount;
		total = productQnaDao.oneProductQnaTotal(productNo);

		int paginationTotal = (int) Math.floor(total / pagePerCount) + 1;
		int pageGroup = 3;
		int startPage = 1;
		numbering = total - (currentPage - 1) * pagePerCount;

		if (currentPage % pageGroup != 0) {
			startPage = (int) (currentPage / pageGroup) * pageGroup + 1;
		} else {
			startPage = ((int) (currentPage / pageGroup) - 1) * pageGroup + 1;
		}
		int endPage = startPage + pageGroup - 1;
		if (endPage > paginationTotal) {
			endPage = paginationTotal;
		}

		ObjectMapper objectMapper = new ObjectMapper();
		HashMap<String, List<ProductQnaBean>> hashMap = new HashMap<String, List<ProductQnaBean>>();
		List<ProductQnaBean> productQnaList = productQnaDao.oneProductQnaList(productNo, start, end);
		hashMap.put("productQnaList", productQnaList);
		model.addAttribute("productQnaList", productQnaList);
		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);
		logger.info("productQnaList{}", productQnaList);
		String jsonData = objectMapper.writeValueAsString(hashMap);
		return jsonData;
	}

	// 관리자가보는 전체 상품qna
	@GetMapping("/ProductQnaList.do")
	public String productQnaList(Model model, HttpServletRequest request) {
		String clickedPage = request.getParameter("clickedPage");
		if (clickedPage == null) {
			clickedPage = "1";
		}
		int pagePerCount = 5;
		int total = 0;
		int numbering = 0;
		int currentPage = Integer.parseInt(clickedPage);
		int start = (currentPage - 1) * pagePerCount + 1;
		int end = currentPage * pagePerCount;
		total = productQnaDao.getProductQnaTotal();

		int paginationTotal = (int) Math.floor(total / pagePerCount) + 1;
		int pageGroup = 3;
		int startPage = 1;
		numbering = total - (currentPage - 1) * pagePerCount;

		if (currentPage % pageGroup != 0) {
			startPage = (int) (currentPage / pageGroup) * pageGroup + 1;
		} else {
			startPage = ((int) (currentPage / pageGroup) - 1) * pageGroup + 1;
		}
		int endPage = startPage + pageGroup - 1;
		if (endPage > paginationTotal) {
			endPage = paginationTotal;
		}

		List<ProductQnaBean> productQnaList = productQnaDao.showProductQnaList(start, end);

		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("productQnaList", productQnaList);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);

		return "manager/product_qna_list";
	}

	@RequestMapping(value = "/PdtQnaList02.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, List<Integer>> pdtQnaList02(Model model, HttpServletRequest request) {
		List<Integer> pdtQnaNoList = productQnaDao.pdtQnaNo();
		HashMap<String, List<Integer>> hashMap = new HashMap<String, List<Integer>>();
		hashMap.put("pdtQnaNoList", pdtQnaNoList);
		return hashMap;
	}

	@RequestMapping(value = "/PdtQnaReplyCheck.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Integer> pdtQnaReplyCheck(Model model, HttpServletRequest request, int qnaNo) {
		int result = 0;
		HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
		result = pdtQnaReplyDao.pdtReplyCheck(qnaNo);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;
	}

	@GetMapping("/ProductQnaInfo.do")
	public String pdtQnaInfo(int no, Model model) {

		productQnaBean = productQnaDao.productQnaInfo(no);
		int userNo = productQnaBean.getUserNo();
		String profileImg = userDao.getProfileImg(userNo);
		model.addAttribute("productQnaBean", productQnaBean);
		model.addAttribute("profileImg", profileImg);
		return "qna/product_qna_info";
	}

	@RequestMapping(value = "/OneProductQnaInfo.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> oneproductQnaInfo(int no, Model model, HttpServletRequest request) {
		// HttpSession session = request.getSession();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		productQnaBean = productQnaDao.productQnaInfo(no);
		int userNo = productQnaBean.getUserNo();
		String profileImg = userDao.getProfileImg(userNo);
		// System.out.println(profileImg);
		model.addAttribute("productQnaBean", productQnaBean);
		hashMap.put("productQnaBean", productQnaBean);
		hashMap.put("profileImg", profileImg);
		return hashMap;
	}

	@GetMapping("/ProductQnaUpdateForm.do")
	public String pdtQnaUpdateForm(int no, Model model, HttpServletResponse response) throws IOException {

		productQnaBean = productQnaDao.productQnaInfo(no);
		model.addAttribute("productQnaBean", productQnaBean);
		return "qna/product_qna_update";
	}

	@RequestMapping("/ProductQnaUpdate.do")
	public String pdtQnaUpdate(int no, ProductQnaBean productQnaBean, Model model, HttpServletResponse response)
			throws IOException {
		int result = productQnaDao.updatePdtQna(productQnaBean);
		if (result > 0) {
			ScriptWriterUtil.AndNext(response, "OneProductQnaInfo.do?no=" + no);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "수정에 실패하였습니다.");
			return null;
		}
	}

	@GetMapping("/ProductQnaDelete.do")
	public int pdtQnaDelete(int no, HttpServletResponse response) throws IOException {
//		System.out.println("no==="+no);
		int result = productQnaDao.deletePdtQna(no);

		return result;
	}

	@GetMapping("/VPdtQnaDelete.do")
	public String pdtVQnaDelete(int no, HttpServletResponse response, int pdtNo) throws IOException {
		int result = productQnaDao.deletePdtQna(no);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "글이 삭제되었습니다", "ProductInfo.do?no=" + pdtNo);
		} else {
			ScriptWriterUtil.alertAndBack(response, "글이 삭제되지 않았습니다");
		}
		return null;
	}

	// 리뷰 상품정보
	@RequestMapping(value = "/ReviewWriteForm.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, ProductBean> reviewWriteForm(int no, Model model, HttpSession session,
			HttpServletResponse response) throws IOException {
		HashMap<String, ProductBean> hashMap = new HashMap<String, ProductBean>();

		productBean = productDao.productInfo(no);
		model.addAttribute("productBean", productBean);
		hashMap.put("productBean", productBean);
		return hashMap;
	}

	// 리뷰작성
	@RequestMapping(value = "/ReviewWrite.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Integer> reviewWrite(Model model, HttpServletRequest request, ReviewBean reviewBean) {
		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");
		String name = userBean.getName();
		int userNo = userBean.getNo();
		String userPassword = userBean.getPassword();
		int result = 0;
		HashMap<String, Integer> hashMap = new HashMap<String, Integer>();
		reviewBean.setName(name);
		reviewBean.setUserNo(userNo);
		reviewBean.setUserPassword(userPassword);

		result = reviewDao.insertReview(reviewBean);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;
	}

	// 리뷰삭제폼
	@GetMapping("/ReviewDeleteForm.do")
	public String reviewDeleteForm() {

		return "qna/review_delete_form";
	}

	// 리뷰삭제
	@PostMapping("/ReviewDelete.do")
	public String reviewDelete(int no, String password, HttpServletResponse response, int productNo)
			throws IOException {

		reviewBean.setNo(no);
		reviewBean.setUserPassword(password);
		// System.out.println(productNo);
		String dbPassword = reviewDao.getReviewPassword(no);
		if (dbPassword.equals(reviewBean.getUserPassword())) {
			int result = reviewDao.deleteReview(no);
			if (result > 0) {
				ScriptWriterUtil.alertAndNext(response, "글이 삭제되었습니다", "ProductInfo.do?no=" + productNo);
				return null;
			} else {
				ScriptWriterUtil.alertAndBack(response, "글이 삭제되지 않았습니다");
				return null;
			}
		} else {
			ScriptWriterUtil.alertAndBack(response, "비밀번호를 확인해주세요");
			return null;
		}
	}

	// 리뷰 전체보기
	@RequestMapping(value = "/ReviewAll.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String reviewAll(HttpServletRequest request, ReviewBean reviewBean, int productNo, Model model)
			throws JsonProcessingException {
		String clickedPage = request.getParameter("clickedPage");
		if (clickedPage == null) {
			clickedPage = "1";
		}
		int pagePerCount = 5;
		int total = 0;
		int numbering = 0;
		int currentPage = Integer.parseInt(clickedPage);
		int start = (currentPage - 1) * pagePerCount + 1;
		int end = currentPage * pagePerCount;
		total = reviewDao.reviewTotal(productNo);

		int paginationTotal = (int) Math.floor(total / pagePerCount) + 1;
		int pageGroup = 3;
		int startPage = 1;
		numbering = total - (currentPage - 1) * pagePerCount;

		if (currentPage % pageGroup != 0) {
			startPage = (int) (currentPage / pageGroup) * pageGroup + 1;
		} else {
			startPage = ((int) (currentPage / pageGroup) - 1) * pageGroup + 1;
		}
		int endPage = startPage + pageGroup - 1;
		if (endPage > paginationTotal) {
			endPage = paginationTotal;
		}

		ObjectMapper objectMapper = new ObjectMapper();
		HashMap<String, List<ReviewBean>> hashMap = new HashMap<String, List<ReviewBean>>();
		List<ReviewBean> reviewList = reviewDao.showReviewList(start, end, productNo);
		hashMap.put("reviewList", reviewList);
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);
		String jsonData = objectMapper.writeValueAsString(hashMap);
		return jsonData;
	}

	// 리뷰답변체크
	@RequestMapping(value = "/PdtReplyCheck.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Integer> reviewReplyCheck(Model model, HttpServletRequest request, int qnaNo) {
		int count = 0;
		HashMap<String, Integer> hashMap = new HashMap<String, Integer>();

		count = pdtQnaReplyDao.pdtReplyCheck(qnaNo);
		hashMap.put("count", count);
		return hashMap;
	}

	// qna댓글
	@RequestMapping(value = "/QnaReplyWrite.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> reply(QnaReplyBean qnaReplyBean, HttpServletRequest request, int qnaNo) {
		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");
		int result = 0;

		List<QnaReplyBean> qnaReplyList = qnaReplyDao.qnaReplyList(qnaNo);

		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		result = qnaReplyDao.insertQnaReply(qnaReplyBean);
		hashMap.put("qnaReplyList", qnaReplyList);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;
	}

	@RequestMapping(value = "/QnaReplyAll.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, List<QnaReplyBean>> replyAll(QnaReplyBean qnaReplyBean, int qnaNo) {

		// 여기에다가 넘겨받은 boardId를 받아서 boardId에 있는 모든 글들을 뽑아서 list로 보내주면 그걸 front에서 받아서
		// 처리...
		// replyDao에게 일 시키기...
		HashMap<String, List<QnaReplyBean>> hashMap = new HashMap<String, List<QnaReplyBean>>();
		List<QnaReplyBean> qnaReplyList = qnaReplyDao.qnaReplyList(qnaNo);
		hashMap.put("qnaReplyList", qnaReplyList);
		return hashMap;
	}

	@RequestMapping(value = "/QnaReplyDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> deleteQnaReply(Model model, HttpServletRequest request, QnaReplyBean qnaReplyBean,
			int no, int qnaNo) {

		int result = 0;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		result = qnaReplyDao.qnaReplyDelete(no);

		List<QnaReplyBean> qnaReplyList = qnaReplyDao.qnaReplyList(qnaNo);
		hashMap.put("qnaReplyList", qnaReplyList);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;

	}

	@RequestMapping(value = "/PdtQnaReplyWrite.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> pdtReply(PdtQnaReplyBean pdtQnaReplyBean, int qnaNo, HttpServletRequest request) {
		HttpSession session = request.getSession();
		userBean = (UserBean) session.getAttribute("loggedUserInfo");
		pdtQnaReplyBean.setUserNo(userBean.getNo());
		pdtQnaReplyBean.setUserPassword(userBean.getPassword());
		int result = 0;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		result = pdtQnaReplyDao.insertPdtQnaReply(pdtQnaReplyBean);
		List<PdtQnaReplyBean> pdtQnaReplyList = pdtQnaReplyDao.pdtQnaReplyList(qnaNo);
		hashMap.put("pdtQnaReplyList", pdtQnaReplyList);
		hashMap.put("result", result);
		return hashMap;
	}

	@RequestMapping(value = "/PdtQnaReplyAll.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, List<PdtQnaReplyBean>> pdtReplyAll(PdtQnaReplyBean pdtQnaReplyBean, int qnaNo) {

		// 여기에다가 넘겨받은 boardId를 받아서 boardId에 있는 모든 글들을 뽑아서 list로 보내주면 그걸 front에서 받아서
		// 처리...
		// replyDao에게 일 시키기...
		HashMap<String, List<PdtQnaReplyBean>> hashMap = new HashMap<String, List<PdtQnaReplyBean>>();
		List<PdtQnaReplyBean> pdtQnaReplyList = pdtQnaReplyDao.pdtQnaReplyList(qnaNo);
		hashMap.put("pdtQnaReplyList", pdtQnaReplyList);
		return hashMap;
	}

	@RequestMapping(value = "/PdtReplyDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> deletePdtReply(Model model, HttpServletRequest request,
			PdtQnaReplyBean pdtQnaReplyBean, int no, int qnaNo, String password) {

		pdtQnaReplyBean.setUserPassword(password);

		int result = 0;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		String dbPassword = pdtQnaReplyDao.getPdtReplyPassword(no);
		if (dbPassword.equals(pdtQnaReplyBean.getUserPassword())) {
			result = pdtQnaReplyDao.pdtQnaReplyDelete(no);
		}

		List<PdtQnaReplyBean> pdtQnaReplyList = pdtQnaReplyDao.pdtQnaReplyList(qnaNo);
		hashMap.put("pdtQnaReplyList", pdtQnaReplyList);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;

	}

	@RequestMapping(value = "/VPdtQnaReplyDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> deleteVPdtReply(Model model, HttpServletRequest request,
			PdtQnaReplyBean pdtQnaReplyBean, int no, int qnaNo) {

		int result = 0;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		result = pdtQnaReplyDao.pdtQnaReplyDelete(no);

		List<PdtQnaReplyBean> pdtQnaReplyList = pdtQnaReplyDao.pdtQnaReplyList(qnaNo);
		hashMap.put("pdtQnaReplyList", pdtQnaReplyList);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;

	}

	@RequestMapping(value = "/VReviewDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> deleteVReview(Model model, HttpServletRequest request,
			PdtQnaReplyBean pdtQnaReplyBean, int no, int productNo) {
		String clickedPage = request.getParameter("clickedPage");
		if (clickedPage == null) {
			clickedPage = "1";
		}
		int pagePerCount = 5;
		int total = 0;
		int numbering = 0;
		int currentPage = Integer.parseInt(clickedPage);
		int start = (currentPage - 1) * pagePerCount + 1;
		int end = currentPage * pagePerCount;
		total = reviewDao.reviewTotal(productNo);

		int paginationTotal = (int) Math.floor(total / pagePerCount) + 1;
		int pageGroup = 3;
		int startPage = 1;
		numbering = total - (currentPage - 1) * pagePerCount;

		if (currentPage % pageGroup != 0) {
			startPage = (int) (currentPage / pageGroup) * pageGroup + 1;
		} else {
			startPage = ((int) (currentPage / pageGroup) - 1) * pageGroup + 1;
		}
		int endPage = startPage + pageGroup - 1;
		if (endPage > paginationTotal) {
			endPage = paginationTotal;
		}
		int result = 0;
		HashMap<String, Object> hashMap = new HashMap<String, Object>();

		result = reviewDao.deleteReview(no);

		List<ReviewBean> reviewList = reviewDao.showReviewList(start, end, productNo);
		hashMap.put("reviewList", reviewList);
		hashMap.put("result", result);
		logger.info("result{}", "====" + result);
		return hashMap;

	}

}
