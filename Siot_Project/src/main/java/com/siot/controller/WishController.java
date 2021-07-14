package com.siot.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.siot.model.ProductBean;
import com.siot.model.UserBean;
import com.siot.model.UserDao;
import com.siot.model.WishBean;
import com.siot.model.WishDao;
import com.siot.utils.ScriptWriterUtil;

@Controller
public class WishController {

   @Autowired
   WishBean wishBean;
   @Autowired
   WishDao wishDao;
   @Autowired
   UserBean userBean;
   @Autowired
   UserDao userDao;
   
   @Autowired
   ProductBean productBean;

   @Autowired
   UserBean loggedUserInfo;


   @RequestMapping("/WishList.do")
   public String wishList(int idNo, Model model, HttpSession session) {
      List<WishBean> pdtNoList = (List<WishBean>)wishDao.getPdtNoList(idNo);
      int wishCount = pdtNoList.size();
      List<ProductBean> wishList = new ArrayList<ProductBean>();
      for(int i=0;i<pdtNoList.size();i++) {
         int pdtNo = pdtNoList.get(i).getPdtNo();
         productBean = (ProductBean)wishDao.getOneProduct(pdtNo);
         int no = pdtNoList.get(i).getPdtNo();
         productBean.setNo(no);
         wishList.add(productBean);
      }
      model.addAttribute("wishList", wishList);
      model.addAttribute("wishCount", wishCount);
      return "user/user_wishList";
   }

   @RequestMapping("/cartWishList.do")
   public String cartWishList(int idNo, Model model, HttpSession session) {
      List<WishBean> pdtNoList = (List<WishBean>)wishDao.getPdtNoList(idNo);
      int wishCount = pdtNoList.size();
      List<ProductBean> wishList = new ArrayList<ProductBean>();
      for(int i=0;i<pdtNoList.size();i++) {
         int pdtNo = pdtNoList.get(i).getPdtNo();
         productBean = (ProductBean)wishDao.getOneProduct(pdtNo);
         int no = pdtNoList.get(i).getNo();
         productBean.setNo(no);
         wishList.add(productBean);
      }
      model.addAttribute("wishList", wishList);
      model.addAttribute("wishCount", wishCount);
      return "shopCart/wish_list";
   }
   
   @RequestMapping("/InsertWish.do")
   public String insertShopCart(int idNo, int pdtNo,Model model, HttpServletResponse response) throws IOException {
      int result = wishDao.insertWish(idNo, pdtNo);
      
      if (result > 0) {
         ScriptWriterUtil.AndBack(response);
         return null;
      } else {
         ScriptWriterUtil.alertAndBack(response, "실패");
         return null;
      }
   }
   
   @RequestMapping("/DeleteWish.do")
   public String deleteWish(int idNo,int pdtNo,HttpServletResponse response) throws IOException {
	   int result = wishDao.deleteWish(idNo,pdtNo);
	   if(result>0) {
		   ScriptWriterUtil.AndBack(response);
		   return null;
	   }else {
		   ScriptWriterUtil.alertAndBack(response, "에러");
		   return null;
	   }
   }

}








