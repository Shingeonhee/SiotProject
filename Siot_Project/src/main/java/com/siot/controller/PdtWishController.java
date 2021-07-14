package com.siot.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.multipart.MultipartFile;

import com.siot.model.PdtWishBean;
import com.siot.model.PdtWishDao;
import com.siot.utils.ScriptWriterUtil;


@Controller
public class PdtWishController {
	private static Logger logger = LoggerFactory.getLogger(PdtWishController.class);

	@Autowired
	PdtWishBean pdtWishBean;

	@Autowired
	PdtWishDao pdtWishDao;

	@GetMapping("/PdtWishList.do")
	public String MembeList(Model model, HttpServletRequest request) {
		List<PdtWishBean> pdtWishList = pdtWishDao.showAllPdtWish();
		model.addAttribute("pdtWishList", pdtWishList);
		return "pdtWish/PdtWish_list";
	}


	@GetMapping("/PdtWishInfo.do")
	public String pdtWishInfo(int no, Model model) {
		pdtWishBean = pdtWishDao.getSelectOnePdtWish(no);
		model.addAttribute("pdtWishBean", pdtWishBean);
		return "pdtWish/PdtWish_info";
	}

	@GetMapping("/PdtWishUpdateForm.do")
	public String pdtWishUpdateForm(int no, Model model) {
		pdtWishBean = pdtWishDao.getSelectOnePdtWish(no);
		model.addAttribute("pdtWishBean", pdtWishBean);
		return "pdtWish/PdtWish_update";
	}

	@PostMapping("/PdtWishUpdate.do")
	public String pdtWishUpdate(PdtWishBean pdtWishBean, HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		int no = Integer.parseInt(request.getParameter("no"));
		String pdtName = request.getParameter("pdtName");
		String price = request.getParameter("price");
		String mainImg = request.getParameter("mainImg");
		String selectBox = request.getParameter("selectBox");

		pdtWishBean.setNo(no);
		pdtWishBean.setPdtName(pdtName);
		pdtWishBean.setPrice(price);
		pdtWishBean.setMainImg(mainImg);
		pdtWishBean.setSelectBox(selectBox);

		int result = pdtWishDao.updatePdtWish(pdtWishBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "회원수정이 완료되었습니다.", "pdtWishList.do");
		} else {
			ScriptWriterUtil.alertAndBack(response, "회원수정에 실패했습니다.");
		}
		return null;
	}

	@GetMapping("/PdtWishJoinForm.do")
	public String pdtWishJoinForm() {
		return "pdtWish/PdtWish_join";
	}

	@RequestMapping("/PdtWishJoin.do")
	public String pdtWishJoin(PdtWishBean pdtWishBean, HttpServletResponse response, HttpServletRequest request,
			MultipartFile multipartProfileImg) throws IOException {

		String context = request.getContextPath();// 현재 실행중인 context
		String fileRoot = "C:\\miniproject_image\\";
		String originalFileName = multipartProfileImg.getOriginalFilename();
		String extention = FilenameUtils.getExtension(originalFileName); // 파일의 확장자 구하기...
		String savedFileName = UUID.randomUUID() + "." + extention;
		logger.info("savedFileName{}", savedFileName);
		File targetFile = new File(fileRoot + savedFileName); // java.io임포트
		String dbSavedFile = context + "/miniProject/" + savedFileName;
		logger.info("dbSavedFile{}", dbSavedFile);

		try {
			InputStream fileStream = multipartProfileImg.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile); // C:\\miniproject_image\\에 저장하기
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);
			e.printStackTrace();
		}
		pdtWishBean.setMainImg(dbSavedFile);

		int result = pdtWishDao.insertPdtWish(pdtWishBean);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "회원가입이 완료되었습니다.", "pdtWishList.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "회원가입에 실패하였습니다.");
			return null;
		}
	}

	@GetMapping("/PdtWishDeleteForm.do")
	public String memeberDeleteForm(int no, Model model) {
		model.addAttribute("pdtWishBean", pdtWishBean);
		return "pdtWish/PdtWish_delete";
	}

	@PostMapping("/PdtWishDelete.do")
	public String memeberDelete(int no, String password, HttpServletResponse response) throws IOException {
		int result = pdtWishDao.deletePdtWish(no);
		if (result > 0) {
			ScriptWriterUtil.alertAndNext(response, "회원삭제가 완료 되었습니다.", "pdtWishList.do");
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "회원삭제에 실패하였습니다.");
			return null;
		}
	}

}
