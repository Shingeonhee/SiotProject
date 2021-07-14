package com.siot.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.siot.model.PaymentBean;
import com.siot.model.PaymentDao;
import com.siot.model.ProductBean;
import com.siot.model.ProductDao;
import com.siot.model.ShopCartBean;
import com.siot.model.ShopCartDao;
import com.siot.model.UserBean;
import com.siot.model.WishBean;
import com.siot.model.WishDao;
import com.siot.utils.ScriptWriterUtil;

@Controller
public class ShopCartController {
	// private static Logger logger =
	// LoggerFactory.getLogger(ShopCartController.class);

	@Autowired
	ShopCartBean shopCartBean;
	@Autowired
	ShopCartDao shopCartDao;
	
	@Autowired
	WishBean wishBean;
	@Autowired
	WishDao wishDao;
	
	@Autowired
	ProductBean productBean;
	@Autowired
	ProductDao productDao;

	@Autowired
	UserBean loggedUserInfo;

	@RequestMapping("/ShopCartList.do")
	public String shopCartList(int idNo, Model model, HttpSession session) {
		int shopCartCount = shopCartDao.getTotalShopCart(idNo);
		int allPrice = shopCartDao.allPriceShopCart(idNo);
		int deliveryPrice = 0;
		List<ShopCartBean> shopCartList = shopCartDao.showAllShopCart(idNo);
		for (int i = 0; i < shopCartList.size(); i++) {
			allPrice = shopCartList.get(i).getPrice()*shopCartList.get(i).getAmount();
			deliveryPrice += shopCartList.get(i).getSelectBox();
		}
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		
		List<WishBean> pdtNoList = (List<WishBean>) wishDao.getPdtNoList(idNo);
		int wishCount = pdtNoList.size();
		List<ProductBean> wishList = new ArrayList<ProductBean>();
		for (int i = 0; i < pdtNoList.size(); i++) {
			int pdtNo = pdtNoList.get(i).getPdtNo();
			productBean = (ProductBean) wishDao.getOneProduct(pdtNo);
			int no = pdtNo;
			productBean.setNo(no);
			wishList.add(productBean);
		}
		model.addAttribute("wishList", wishList);
		model.addAttribute("wishCount", wishCount);

		model.addAttribute("shopCartList", shopCartList);
		model.addAttribute("shopCartCount", shopCartCount);
		model.addAttribute("allPrice", allPrice);
		model.addAttribute("deliveryPrice", deliveryPrice);
		return "shopCart/shop_cart";
	}


	@RequestMapping("/PlaceAnOrder.do")
	public String placeAnOrder( HttpSession session, HttpServletRequest request, Model model) {
		session.getAttribute("shopCartList");
		session.getAttribute("allPrice");
		session.getAttribute("count");
		session.getAttribute("deliveryPrice");
		
		model.addAttribute("allPrice");
		model.addAttribute("count");
		model.addAttribute("deliveryPrice");
		return "shopCart/placeAnOrder";
	}

	@RequestMapping("/ShopCartDelete.do")
	public String shopCartDelete(int no, HttpServletResponse response) throws IOException {
		int result = shopCartDao.deleteShopCart(no);
		if (result > 0) {
			ScriptWriterUtil.AndNext(response, "/");
			return null;
		} else {
			ScriptWriterUtil.AndBack(response);
			return null;
		}
	}
	
	@RequestMapping(value = "/SeleteDelete.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String seleteDelete(@RequestParam(value = "noList[]") List<String> noList,
			HttpServletResponse response) throws IOException {
		int result = 0;
		int no = 0;
		for (int i = 0; i < noList.size(); i++) {
			no = Integer.parseInt(noList.get(i));
			result = shopCartDao.deleteShopCart(no);
		}
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.AndBack(response);
			return null;
		}
	}
	
	@RequestMapping("/PaymentShopCartDelete.do")
	public String paymentShopCartDelete(int idNo,@RequestParam(value = "noList[]") List<String> noList) throws IOException {
		System.out.println("idNo=="+idNo);
		for (int i = 0; i < noList.size(); i++) {
			int pdtNo = Integer.parseInt(noList.get(i));
			shopCartDao.paymentShopCartDelete(idNo,pdtNo);
		}
		return null;
	}
	
	
	

	@RequestMapping("/OrderByOnePdt.do")
	public String orderByOnePdt(String loggedUserInfo, int pdtNo, Model model, HttpSession session,HttpServletRequest request) throws IOException {
		int no = pdtNo ;
		ProductBean productBean = shopCartDao.getSelectOneProduct(no);
		no = productBean.getNo();
		String pdtName = productBean.getName();
		int price =Integer.parseInt(productBean.getPrice());
		String pdtSize = request.getParameter("pdtSize");
		String pdtColor = request.getParameter("pdtColor");
		String mainImg = productBean.getMainimg();
		int selectBox = Integer.parseInt(request.getParameter("selectBox"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		shopCartBean.setPdtNo(pdtNo);
		shopCartBean.setPdtName(pdtName);
		shopCartBean.setPdtSize(pdtSize);
		shopCartBean.setPdtColor(pdtColor);
		shopCartBean.setPrice(price);
		shopCartBean.setMainImg(mainImg);
		shopCartBean.setSelectBox(selectBox);
		shopCartBean.setAmount(amount);
		
		List<ShopCartBean> shopCartList = new ArrayList<ShopCartBean>();
		shopCartList.add(shopCartBean);
		int shopCartCount = 1;
		int deliveryPrice = 0;
		int allPrice = Integer.parseInt(productBean.getPrice())*shopCartBean.getAmount();
		deliveryPrice = shopCartDao.delivery(no);
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		model.addAttribute("shopCartList", shopCartList);
		model.addAttribute("shopCartCount", shopCartCount);
		model.addAttribute("allPrice", allPrice);
		model.addAttribute("deliveryPrice", deliveryPrice);
		model.addAttribute("no", no);
		session.setAttribute("shopCartList",shopCartList);
		return "shopCart/placeAnOrder";
	}
	
	@RequestMapping("/OrderByOne.do")
	public String orderByOne(int no, Model model,HttpServletRequest request,HttpSession session) throws IOException {
		shopCartBean = shopCartDao.getSelectOneShopCart(no);
		List<ShopCartBean> shopCartList = new ArrayList<ShopCartBean>();
		shopCartList.add(shopCartBean);
		int count = 1;
		int allPrice = 0;
		int deliveryPrice = 0;
		allPrice += (shopCartBean.getPrice() * shopCartBean.getAmount());
		deliveryPrice += shopCartBean.getSelectBox();
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		model.addAttribute("shopCartList", shopCartList);
		model.addAttribute("allPrice", allPrice);
		model.addAttribute("deliveryPrice", deliveryPrice);
		model.addAttribute("count", count);
		session.setAttribute("shopCartList", shopCartList);
		session.setAttribute("allPrice", allPrice);
		session.setAttribute("deliveryPrice", deliveryPrice);
		session.setAttribute("count", count);
		
		return "shopCart/placeAnOrder";
	}

	@RequestMapping(value = "/OrderByAll.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public HashMap<String, Object> orderByAll(@RequestParam(value = "noList[]") List<String> noList, Model model,
			HttpServletResponse response,HttpSession session) throws IOException {
		int count = noList.size();
		int allPrice = 0;
		int deliveryPrice = 0;
		List<ShopCartBean> shopCartList = new ArrayList<ShopCartBean>();
		HashMap<String, Object> hashMap = new HashMap<String, Object>();
		int no = 0;
		for (int i = 0; i < noList.size(); i++) {
			no = Integer.parseInt(noList.get(i));
			shopCartBean = shopCartDao.getSelectOneShopCart(no);
			shopCartList.add(shopCartBean);
			allPrice += (shopCartBean.getPrice() * shopCartBean.getAmount());
			deliveryPrice += shopCartBean.getSelectBox();
		}
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		
		session.setAttribute("shopCartList", shopCartList);
		session.setAttribute("allPrice", allPrice);
		session.setAttribute("deliveryPrice", deliveryPrice);
		session.setAttribute("count", count);
		hashMap.put("shopCartList", shopCartList);
		hashMap.put("allPrice", allPrice);
		hashMap.put("deliveryPrice", deliveryPrice);
		hashMap.put("count", count);
		return hashMap;
	}

	@RequestMapping("/PlusAmount.do")
	public String plusAmount(int no, int amount, Model model, HttpServletResponse response) throws IOException {
		int result = 0;
		amount = amount + 1;
		result = shopCartDao.changeAmount(no, amount);
		model.addAttribute(amount);
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "실패");
			return null;
		}
	}

	@RequestMapping("/MinusAmount.do")
	public String minusAmount(int no, int amount, Model model, HttpServletResponse response) throws IOException {
		int result = 0;
		if (amount <= 1) {
			amount = 1;
		} else {
			amount = amount - 1;
		}
		result = shopCartDao.changeAmount(no, amount);
		model.addAttribute(amount);
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "실패");
			return null;
		}
	}


	@RequestMapping("/Payment.do")
	public String ShopCartUpdateForm(String paymentNo,int idNo,String name, String phone,String postCode, String address, String subAddress,
			String selectBox, String deliveryMemo, String custom, String customMemo,String totalPrice, Model model) {
		String shippingMemo = "";
		if (selectBox.equals("4000")) {
			selectBox = "택배";
		}else {
			selectBox = "방문수령";
		}
		if(deliveryMemo.equals("custom")) {
			shippingMemo=customMemo;
		}else {
			shippingMemo=deliveryMemo;
		}
		PaymentBean paymentBean= new PaymentBean();
		paymentBean.setPaymentNo(paymentNo);
		paymentBean.setIdNo(idNo);
		paymentBean.setName(name);
		paymentBean.setPhone(phone);
		paymentBean.setPostCode(postCode);
		paymentBean.setAddress(address);
		paymentBean.setSubAddress(subAddress);
		paymentBean.setShippingMemo(shippingMemo);
		paymentBean.setPaymentPrice(totalPrice);
		paymentBean.setPaymentMethod(selectBox);
		
		PaymentDao paymentDao = new PaymentDao();
		paymentDao.insertPayment(paymentBean);
		
		model.addAttribute("paymentNo", paymentNo);
		model.addAttribute("name", name);
		model.addAttribute("phone", phone);
		model.addAttribute("postCode", postCode);
		model.addAttribute("address", address);
		model.addAttribute("subAddress", subAddress);
		model.addAttribute("selectBox", selectBox);
		model.addAttribute("deliveryMemo", deliveryMemo);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("custom", custom);
		model.addAttribute("customMemo", customMemo);
		return "shopCart/payment";
	}

	@RequestMapping("/SelectBoxChange.do")
	public String selectBoxChange(int no, int selectBox, ProductBean productBean, HttpServletResponse response)
			throws IOException {
		if (selectBox == 0) {
			selectBox = 1;
		} else {
			selectBox = 0;
		}
		int result = shopCartDao.SelectBoxChange(no, selectBox);
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "실패");
			return null;
		}
	}

	@RequestMapping("/InsertShopCart.do")
	public String insertShopCart(int idNo, int pdtNo, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		ProductBean productBean = shopCartDao.getSelectOneProduct(pdtNo);
		String pdtName = productBean.getName();
		int price = Integer.parseInt(productBean.getPrice());
		String pdtSize = request.getParameter("pdtSize");
		String pdtColor = request.getParameter("pdtColor");
		String mainImg = productBean.getMainimg();
		int selectBox = Integer.parseInt(request.getParameter("selectBox"));
		int wishOn = Integer.parseInt(request.getParameter("wishOn"));
		int amount = Integer.parseInt(request.getParameter("amount"));
		shopCartBean.setIdNo(idNo);
		shopCartBean.setPdtNo(pdtNo);
		shopCartBean.setPdtName(pdtName);
		shopCartBean.setPrice(price);
		shopCartBean.setPdtSize(pdtSize);
		shopCartBean.setPdtColor(pdtColor);
		shopCartBean.setMainImg(mainImg);
		shopCartBean.setSelectBox(selectBox);
		shopCartBean.setWishOn(wishOn);
		shopCartBean.setAmount(amount);
		int result = shopCartDao.insertShopCart(idNo, shopCartBean);
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "에러!#!");
			return null;
		}
	}

	@RequestMapping(value = "/GetAllPrice.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Integer getAllPrice(@RequestParam(value = "noList[]") List<String> noList, Model model,
			HttpSession session) {
		int allPrice = 0;
		int no = 0;
		for (int i = 0; i < noList.size(); i++) {
			no = Integer.parseInt(noList.get(i));
			shopCartBean = shopCartDao.getSelectOneShopCart(no);
			allPrice += shopCartBean.getPrice();
		}
		return allPrice;
	}

	@RequestMapping(value = "/GetDeliveryPrice.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Integer getDeliveryPrice(@RequestParam(value = "noList[]") List<String> noList, Model model,
			HttpSession session) {
		int allPrice = 0;
		int deliveryPrice = 0;
		int no = 0;
		for (int i = 0; i < noList.size(); i++) {
			no = Integer.parseInt(noList.get(i));
			shopCartBean = shopCartDao.getSelectOneShopCart(no);
			allPrice += shopCartBean.getPrice();
			deliveryPrice += shopCartBean.getSelectBox();
		}
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		return deliveryPrice;
	}

	@RequestMapping(value = "/GetTotalPrice.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Integer getTotalPrice(@RequestParam(value = "noList[]") List<String> noList, Model model,
			HttpSession session) {
		int allPrice = 0;
		int deliveryPrice = 0;
		int totalPrice = 0;
		int no = 0;
		for (int i = 0; i < noList.size(); i++) {
			no = Integer.parseInt(noList.get(i));
			shopCartBean = shopCartDao.getSelectOneShopCart(no);
			allPrice += shopCartBean.getPrice();
			deliveryPrice += shopCartBean.getSelectBox();
		}
		if (allPrice <= 250000) {
			if (deliveryPrice == 0) {
				deliveryPrice = 0;
			} else {
				deliveryPrice = 4000;
			}
		} else {
			deliveryPrice = 0;
		}
		totalPrice = allPrice + deliveryPrice;
		return totalPrice;
	}

	@RequestMapping("/ShopCartChangeWish.do")
	public String shopCartChangeWish(int no, HttpServletResponse response)
			throws IOException {
		int wishOn = shopCartDao.getSelectOneWish(no);
		if(wishOn ==0) {
			wishOn = 1;
		} else {
			wishOn =0;
		}
		int result = shopCartDao.changeWish(no,wishOn);
		if (result > 0) {
			ScriptWriterUtil.AndBack(response);
			return null;
		} else {
			ScriptWriterUtil.alertAndBack(response, "실패");
			return null;
		}
	}
}
