package com.siot.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.siot.model.ProductBean;
import com.siot.model.ProductDao;

@Controller
public class HomeController {
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(Model model)  throws IOException {
		ProductDao productDao = new ProductDao();
		List<ProductBean> productList = productDao.getUniqueList();
		model.addAttribute("productList", productList);
		return "index";
	}
}
