package com.siot.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class UserBean {
	private int no;
	private String id;
	private String password;
	private String name;
	private String gender;
	private String phone;
	private String postCode;
	private String address;
	private String subAddress;
	private String ageYear;
	private String ageMonth;
	private String ageDay;
	private String profileImg;
	private String verify;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getSubAddress() {
		return subAddress;
	}
	public void setSubAddress(String subAddress) {
		this.subAddress = subAddress;
	}
	public String getAgeYear() {
		return ageYear;
	}
	public void setAgeYear(String ageYear) {
		this.ageYear = ageYear;
	}
	public String getAgeMonth() {
		return ageMonth;
	}
	public void setAgeMonth(String ageMonth) {
		this.ageMonth = ageMonth;
	}
	public String getAgeDay() {
		return ageDay;
	}
	public void setAgeDay(String ageDay) {
		this.ageDay = ageDay;
	}
	public String getProfileImg() {
		return profileImg;
	}
	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}
	public String getVerify() {
		return verify;
	}
	public void setVerify(String verify) {
		this.verify = verify;
	}
	
	
}
