package com.siot.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.model.PaymentBean;
import com.siot.model.PaymentDao;
import com.siot.model.PaymentDetailBean;
import com.siot.model.PaymentDetailDao;
import com.siot.model.ProductBean;
import com.siot.model.ProductDao;
import com.siot.model.ShopCartBean;
import com.siot.model.UserBean;
import com.siot.utils.ScriptWriterUtil;

@Controller
public class PaymentController {

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

	@GetMapping("/PaymentList.do")
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
		total = paymentDao.getPaymentTotal();

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
		List<PaymentBean> paymentList = paymentDao.showAllPayment(start, end);

		model.addAttribute("paymentList", paymentList);

		model.addAttribute("numbering", numbering);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("paginationTotal", paginationTotal);
		model.addAttribute("pageGroup", pageGroup);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("clickedPage", clickedPage);
		model.addAttribute("total", total);
		return "manager/order_list";
	}

	@RequestMapping(value = "/PaymentDetail.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public void paymentDetail(HttpSession session, HttpServletRequest request, String paymentNo) {

		ArrayList<ShopCartBean> shopCartBeanList = (ArrayList) session.getAttribute("shopCartList");

		paymentDetailBean.setPaymentNo(paymentNo);
		for (int i = 0; i < shopCartBeanList.size(); i++) {
			paymentDetailBean.setPdtNo(shopCartBeanList.get(i).getPdtNo());
			paymentDetailBean.setColor(shopCartBeanList.get(i).getPdtColor());
			paymentDetailBean.setPdtSize(shopCartBeanList.get(i).getPdtSize());
			paymentDetailBean.setAmount(shopCartBeanList.get(i).getAmount());

			paymentDetailDao.insertPaymentDetail(paymentDetailBean);
		}
	}

	@GetMapping("/PaymentInfo.do")
	public String paymentInfo(String paymentNo, Model model, HttpServletRequest request) {
		List<PaymentDetailBean> paymentDetailList = new ArrayList<PaymentDetailBean>();
		paymentBean = paymentDao.getPaymentForPaymentNo(paymentNo);
		int idNo = paymentBean.getIdNo();
		UserBean userBean = paymentDao.getOneUserForIdNo(idNo);
		List<ProductBean> payPdtList = new ArrayList<ProductBean>();
		paymentDetailList = paymentDetailDao.getPaymentDetailForPaymentNo(paymentNo);
		for (int i = 0; i < paymentDetailList.size(); i++) {
			int pdtNo = paymentDetailList.get(i).getPdtNo();
			productBean = productDao.getOneProduct(pdtNo);
			payPdtList.add(productBean);
		}

		model.addAttribute("userBean", userBean);
		model.addAttribute("payPdtList", payPdtList);
		model.addAttribute("paymentBean", paymentBean);
		model.addAttribute("paymentDetailList", paymentDetailList);
		return "shopCart/payment_info";
	}

	
	@GetMapping("/UnuserPaymentInfo.do")
   public String unuserPaymentInfo(Model model, HttpServletRequest request,HttpServletResponse response) throws IOException {
      String paymentNo = request.getParameter("unOrderNum");
      List<PaymentDetailBean> paymentDetailList = new ArrayList<PaymentDetailBean>();
      List<ProductBean> payPdtList = new ArrayList<ProductBean>();
      paymentBean = paymentDao.getPaymentForPaymentNo(paymentNo);
      
      if(paymentBean == null) {
         ScriptWriterUtil.alertAndBack(response, " 주문번호를 확인해 주세요.");
         return null;
      }else {
         paymentDetailList = paymentDetailDao.getPaymentDetailForPaymentNo(paymentNo);
         for(int i=0 ; i<paymentDetailList.size(); i++) {
               int pdtNo = paymentDetailList.get(i).getPdtNo();
               productBean = productDao.getOneProduct(pdtNo);
               payPdtList.add(productBean);
            }
         model.addAttribute("payPdtList", payPdtList);
         model.addAttribute("paymentBean", paymentBean);
         model.addAttribute("paymentDetailList", paymentDetailList);
         return "shopCart/unuser_payment_info";
      }
   }
	
	
}
