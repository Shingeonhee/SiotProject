package com.siot.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class WishBean {
	private int no;
	private int idNo;
	private int pdtNo;
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
	
}
