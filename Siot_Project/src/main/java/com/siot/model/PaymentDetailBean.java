package com.siot.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class PaymentDetailBean {
   private String paymentNo;
   private int pdtNo;
   private String color;
   private String pdtSize;
   private int amount;
public String getPaymentNo() {
	return paymentNo;
}
public void setPaymentNo(String paymentNo) {
	this.paymentNo = paymentNo;
}
public int getPdtNo() {
	return pdtNo;
}
public void setPdtNo(int pdtNo) {
	this.pdtNo = pdtNo;
}
public String getColor() {
	return color;
}
public void setColor(String color) {
	this.color = color;
}
public String getPdtSize() {
	return pdtSize;
}
public void setPdtSize(String pdtSize) {
	this.pdtSize = pdtSize;
}
public int getAmount() {
	return amount;
}
public void setAmount(int amount) {
	this.amount = amount;
}
   
}