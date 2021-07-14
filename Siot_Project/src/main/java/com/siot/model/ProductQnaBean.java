package com.siot.model;

import java.util.Date;

import org.springframework.stereotype.Component;

import lombok.Data;
@Component
@Data
public class ProductQnaBean {
	private int no;
	private String productName;
	private int productNo;
	private String subject;
	private String name;
	private Date pdtQnaDate;
	private String contents;
	private int userNo;
	private String userPassword;

	public Date getPdtQnaDate() {
		return pdtQnaDate;
	}
	public void setPdtQnaDate(Date pdtQnaDate) {
		this.pdtQnaDate = pdtQnaDate;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductNo() {
		return productNo;
	}
	public void setProductNo(int productNo) {
		this.productNo = productNo;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	

	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getUserNo() {
		return userNo;
	}
	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}
	
	
	
}
