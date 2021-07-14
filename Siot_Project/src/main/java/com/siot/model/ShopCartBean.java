package com.siot.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ShopCartBean {
	private int no;
	private int idNo;
	private int pdtNo;
	private String pdtName;
	private int price;
	private String pdtSize;
	private String pdtColor;
	private String mainImg;
	private int selectBox;
	private int wishOn;
	private int amount;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getIdNo() {
		return idNo;
	}
	public void setIdNo(int idNo) {
		this.idNo = idNo;
	}
	public int getPdtNo() {
		return pdtNo;
	}
	public void setPdtNo(int pdtNo) {
		this.pdtNo = pdtNo;
	}
	public String getPdtName() {
		return pdtName;
	}
	public void setPdtName(String pdtName) {
		this.pdtName = pdtName;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPdtSize() {
		return pdtSize;
	}
	public void setPdtSize(String pdtSize) {
		this.pdtSize = pdtSize;
	}
	public String getPdtColor() {
		return pdtColor;
	}
	public void setPdtColor(String pdtColor) {
		this.pdtColor = pdtColor;
	}
	public String getMainImg() {
		return mainImg;
	}
	public void setMainImg(String mainImg) {
		this.mainImg = mainImg;
	}
	public int getSelectBox() {
		return selectBox;
	}
	public void setSelectBox(int selectBox) {
		this.selectBox = selectBox;
	}
	public int getWishOn() {
		return wishOn;
	}
	public void setWishOn(int wishOn) {
		this.wishOn = wishOn;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	
}
