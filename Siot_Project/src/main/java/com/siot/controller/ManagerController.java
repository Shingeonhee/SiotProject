package com.siot.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.siot.model.UserBean;
import com.siot.model.UserDao;

@Controller
public class ManagerController {
	//private static final Logger logger = LoggerFactory.getLogger(ManagerController.class);
	@Autowired
	UserBean userBean;
	@Autowired
	UserDao userDao;
	
	
	@GetMapping("/Ex.do")
	public String ex() {
		return "reviewbox/exinfo";
	}
	
	@GetMapping("/Manage.do")
	public String manage() {
		return "manager/manager_main";
	}
	
	//1:1 product 두가지 qna 보기
	@GetMapping("/AllQnaList.do")
	public String allQnaList() {
		return "qna/all_qna_list";
	}
	

	
	@GetMapping("/UserList.do")
	public String userList(Model model,HttpServletRequest request) {
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
		total = userDao.getUserTotal();

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

		List<UserBean> userList = userDao.showAllUser(start,end);

		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("userList", userList);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);
		
		return"manager/user_list";
	}
	
	@GetMapping("/UserInfo.do")
	public String userInfo(int no,Model model) {
		userBean = userDao.userInfo(no);
		model.addAttribute("userBean", userBean);
		return "manager/user_info";
	}
	

	
	
	
	
}
