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
import org.apache.commons.io.FilenameUtils;
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
import com.siot.model.ProductBean;
import com.siot.model.ProductDao;
import com.siot.model.UserBean;
import com.siot.model.WishDao;
import com.siot.utils.ScriptWriterUtil;

@Controller

public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(QnaController.class);
	@Autowired
	ProductBean productBean;

	@Autowired
	ProductDao productDao;

	@Autowired
	WishDao wishDao;
	
	@Autowired
	UserBean userBean;


	
	@GetMapping("/ProductAddForm.do")
	public String productAddForm() {

		return "product/product_add";
	}

	@RequestMapping("/ProductList.do")
	public String productList(Model model) {
		List<ProductBean> productList = productDao.allProductList();
		model.addAttribute("productList", productList);
		return "product/product_list";
	}

	@RequestMapping("/ProductManage.do")
	public String productManage(Model model) {

		List<ProductBean> productList = productDao.allProductList();

		model.addAttribute("productList", productList);

		return "product/product_manage";

	}


	@GetMapping("/ProductInfo.do")
	public String productInfo(int no, Model model,HttpServletRequest request) {
		int wishOn = 0;
		int idNo = 0;
		productBean = productDao.productInfo(no);
		HttpSession session = request.getSession();
		if(session.getAttribute("loggedUserInfo") !=null) {
			userBean = (UserBean) session.getAttribute("loggedUserInfo");
			idNo = userBean.getNo();
		}else {
			idNo = 0;
		}
		int pdtNo = no;
		wishOn = wishDao.getWish(idNo,pdtNo);
		model.addAttribute("wishOn",wishOn);
		model.addAttribute("productBean", productBean);
		return "product/product_info";
	}

	@GetMapping("/ManageProductInfo.do")
	public String manageProductInfo(int no, Model model) {
		productBean = productDao.productInfo(no);
		model.addAttribute("productBean", productBean);
		return "manager/manage_product_info";
	}

	@RequestMapping("/ProductWeddingList.do")
	public String productWedding(Model model) {
		List<ProductBean> productList = productDao.getWeddingList();
		model.addAttribute("productList", productList);
		return "product/product_wedding";
	}

	@RequestMapping("/ProductDailyList.do")
	public String productDaily(Model model) {
		List<ProductBean> productList = productDao.getDailyList();
		model.addAttribute("productList", productList);
		return "product/product_daily";
	}

	@RequestMapping("/ProductUniqueList.do")
	public String productUnique(Model model) {
		List<ProductBean> productList = productDao.getUniqueList();
		model.addAttribute("productList", productList);
		return "product/product_unique";
	}

	@RequestMapping("/ProductGoodbyeitemList.do")
	public String productGoodbyeitem(Model model) {
		List<ProductBean> productList = productDao.getGoodbyeitemList();
		model.addAttribute("productList", productList);
		return "product/product_goodbyeitem";
	}
////////////

	@RequestMapping("/ProductWeddingManage.do")
	public String productWeddingManage(Model model) {
		List<ProductBean> productList = productDao.getWeddingList();
		model.addAttribute("productList", productList);
		return "manager/product_wedding_manage";
	}

	@RequestMapping("/ProductDailyManage.do")
	public String productDailyManage(Model model) {
		List<ProductBean> productList = productDao.getDailyList();
		model.addAttribute("productList", productList);
		return "manager/product_daily_manage";
	}

	@RequestMapping("/ProductUniqueManage.do")
	public String productUniqueManage(Model model) {
		List<ProductBean> productList = productDao.getUniqueList();
		model.addAttribute("productList", productList);
		return "manager/product_unique_manage";
	}

	@RequestMapping("/ProductGoodbyeitemManage.do")
	public String productGoodbyeitemManage(Model model) {
		List<ProductBean> productList = productDao.getGoodbyeitemList();
		model.addAttribute("productList", productList);
		return "manager/product_goodbyeitem_manage";
	}

	@PostMapping("/ProductAdd.do")
	public String productAdd(HttpServletRequest request, HttpServletResponse response, MultipartFile multipartFile,
			ProductBean productBean) throws IOException {
		String category = (String) request.getParameter("category");//
		productBean.setCategory(category);

		String context = request.getContextPath(); // 우리가 실행중인 context 이름 구하기
		String fileRoot = "C:\\pdt_image\\"; // 외부에 저장할 경로
		String originalFileName = multipartFile.getOriginalFilename(); // 진짜 파일명 tmdal.jpg
		String extention = FilenameUtils.getExtension(originalFileName);// 확장자 구하기
		String savedFileName = UUID.randomUUID() + "." + extention; // 중복파일을 올렸을때 겹치는 현상 제거 UUID
		File targetFile = new File(fileRoot + savedFileName);
		String dbFileName = context + "/productImage/" + savedFileName; // db에 들어갈 이름
		// 매핑 경로에 /galleryImage이게 들어오면....
		logger.info("savedFileName==={}", savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}

		productBean.setMainimg(dbFileName); // 중복 처리되는 파일 이름을 랜덤하게 구한 거.....

		int result = productDao.insertProduct(productBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "등록되었습니다.", "/");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "등록실패.");
			return null;
		}
	}


	@GetMapping("/ProductDelete.do")
	public String productDelete(int no, HttpServletResponse response) throws IOException {

		int result = productDao.productDelete(no);

		// String a = ScriptWriterUtil.confirmAndNext(response,"삭제?");
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "상품이 삭제되었습니다.", "ProductList.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "상품이 삭제되지 않았습니다.");
			return null;
		}
	}

	@RequestMapping("/ProductUpdateForm.do")
	public String productUpdateForm(Model model, int no, HttpServletRequest request) {

		productBean = productDao.productInfo(no);
		model.addAttribute("productBean", productBean);

		return "product/product_update";

	}

	@PostMapping("/ProductUpdate.do")
	public String productUpdate(ProductBean productBean, HttpServletResponse response,HttpServletRequest request, MultipartFile multipartpdtFile, HttpSession session) throws IOException {
		String context = request.getContextPath();// 현재 실행중인  context
		String fileRoot = "C:\\miniproject_image\\";
		String originalFileName = multipartpdtFile.getOriginalFilename();
		String extention = FilenameUtils.getExtension(originalFileName); //파일의 확장자 구하기...
		String savedFileName = UUID.randomUUID()+"."+extention; 
		logger.info("savedFileName{}",savedFileName);
		File targetFile = new File(fileRoot+savedFileName); //java.io임포트
		String dbSavedFile = context+"/miniProject/"+savedFileName;
		logger.info("dbSavedFile{}",dbSavedFile);
		
		try {
			InputStream fileStream = multipartpdtFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);  //C:\\miniproject_image\\에 저장하기
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}
		productBean.setMainimg(dbSavedFile);
		int result = productDao.productUpdate(productBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "상품수정.", "ProductList.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "상품수정x.");
			return null;
		}
	}
	@RequestMapping(value = "/SummerNoteImageUpload2.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // json 파일로 쓰겠다. 만약 쓰지 않으면 jsp를 호출한다.
	public String sendImgFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
			throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		String fileRoot = "C:\\summernote2\\"; // 이미지 업로드 했을때 담아놓을 외부 경로
		String originaleFileName = multipartFile.getOriginalFilename();
		String extension = originaleFileName.substring(originaleFileName.lastIndexOf("."));
		String savedFileName = UUID.randomUUID() + extension;
		File targetFile = new File(fileRoot + savedFileName);
		String context = request.getContextPath(); // 현재 contextRoot찾기 이미지 불러올때 사용

		logger.info("context==={}", context);
		logger.info("originaleFileName==={}", originaleFileName);
		logger.info("savedFileName==={}", savedFileName);
		logger.info("targetFile==={}", targetFile);
		HashMap<String, String> hashMap = new HashMap<String, String>();

		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // 파일 저장....
			hashMap.put("url", context + "/summernoteImg2/" + savedFileName);
			hashMap.put("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);// io오류 났을때 파일 삭제
			hashMap.put("responseCode", "error");
			e.printStackTrace();
		}
		String jsonData = objectMapper.writeValueAsString(hashMap);
		logger.info("jsonData==={}", jsonData);
		return jsonData;
	}

	@Controller("adminNoticeController")
	@RequestMapping("/admin/board/notice/")
	public class NoticeController {
		@RequestMapping("list")
		public String list() {
			return "";
		}
		@RequestMapping("reg")
		@ResponseBody // 입력값을 사용자에게 다시 보여주기만 하기 위해서 사용
		public String reg() {
			return "reg";
		}
		@RequestMapping("edit")
		public String edit() {
			return "";
		}
		@RequestMapping("del")
		public String del() {
			return "";
		}
	}
}
