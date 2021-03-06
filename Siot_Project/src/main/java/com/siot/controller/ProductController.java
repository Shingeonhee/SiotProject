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

		String context = request.getContextPath(); // ????????? ???????????? context ?????? ?????????
		String fileRoot = "C:\\pdt_image\\"; // ????????? ????????? ??????
		String originalFileName = multipartFile.getOriginalFilename(); // ?????? ????????? tmdal.jpg
		String extention = FilenameUtils.getExtension(originalFileName);// ????????? ?????????
		String savedFileName = UUID.randomUUID() + "." + extention; // ??????????????? ???????????? ????????? ?????? ?????? UUID
		File targetFile = new File(fileRoot + savedFileName);
		String dbFileName = context + "/productImage/" + savedFileName; // db??? ????????? ??????
		// ?????? ????????? /galleryImage?????? ????????????....
		logger.info("savedFileName==={}", savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}

		productBean.setMainimg(dbFileName); // ?????? ???????????? ?????? ????????? ???????????? ?????? ???.....

		int result = productDao.insertProduct(productBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "?????????????????????.", "ProductManage.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "????????????.");
			return null;
		}
	}


	@GetMapping("/ProductDelete.do")
	public String productDelete(int no, HttpServletResponse response) throws IOException {

		int result = productDao.productDelete(no);

		// String a = ScriptWriterUtil.confirmAndNext(response,"???????");
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "????????? ?????????????????????.", "ProductManage.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "????????? ???????????? ???????????????.");
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
		String context = request.getContextPath();// ?????? ????????????  context
		String fileRoot = "C:\\miniproject_image\\";
		String originalFileName = multipartpdtFile.getOriginalFilename();
		String extention = FilenameUtils.getExtension(originalFileName); //????????? ????????? ?????????...
		String savedFileName = UUID.randomUUID()+"."+extention; 
		logger.info("savedFileName{}",savedFileName);
		File targetFile = new File(fileRoot+savedFileName); //java.io?????????
		String dbSavedFile = context+"/miniProject/"+savedFileName;
		logger.info("dbSavedFile{}",dbSavedFile);
		
		try {
			InputStream fileStream = multipartpdtFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);  //C:\\miniproject_image\\??? ????????????
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}
		productBean.setMainimg(dbSavedFile);
		int result = productDao.productUpdate(productBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "????????????.", "ProductManage.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "????????????x.");
			return null;
		}
	}
	@RequestMapping(value = "/SummerNoteImageUpload2.do", produces = "application/json;charset=UTF-8")
	@ResponseBody // json ????????? ?????????. ?????? ?????? ????????? jsp??? ????????????.
	public String sendImgFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request)
			throws JsonProcessingException {
		ObjectMapper objectMapper = new ObjectMapper();
		String fileRoot = "C:\\summernote2\\"; // ????????? ????????? ????????? ???????????? ?????? ??????
		String originaleFileName = multipartFile.getOriginalFilename();
		String extension = originaleFileName.substring(originaleFileName.lastIndexOf("."));
		String savedFileName = UUID.randomUUID() + extension;
		File targetFile = new File(fileRoot + savedFileName);
		String context = request.getContextPath(); // ?????? contextRoot?????? ????????? ???????????? ??????

		logger.info("context==={}", context);
		logger.info("originaleFileName==={}", originaleFileName);
		logger.info("savedFileName==={}", savedFileName);
		logger.info("targetFile==={}", targetFile);
		HashMap<String, String> hashMap = new HashMap<String, String>();

		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // ?????? ??????....
			hashMap.put("url", context + "/summernoteImg2/" + savedFileName);
			hashMap.put("responseCode", "success");
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);// io?????? ????????? ?????? ??????
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
		@ResponseBody // ???????????? ??????????????? ?????? ??????????????? ?????? ????????? ??????
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
