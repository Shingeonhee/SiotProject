package com.siot.model;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class ProductBean {
	private int no;
	private String mainimg;
	private String name;
	private String price;
	private String contents;
	private String d_contents;
	private String category;
	private String productcolor;
	private String productsize;
	
	
	public String getProductcolor() {
		return productcolor;
	}
	public void setProductcolor(String productcolor) {
		this.productcolor = productcolor;
	}
	public String getProductsize() {
		return productsize;
	}
	public void setProductsize(String productsize) {
		this.productsize = productsize;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public void setMainimg(String mainimg) {
		this.mainimg = mainimg;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public void setD_contents(String d_contents) {
		this.d_contents = d_contents;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public ProductBean() {
		super();
	}
	public int getNo() {
		return no;
	}
	public String getMainimg() {
		return mainimg;
	}
	public String getName() {
		return name;
	}
	public String getPrice() {
		return price;
	}
	public String getContents() {
		return contents;
	}
	public String getD_contents() {
		return d_contents;
	}
	public String getCategory() {
		return category;
	}
	public ProductBean(int no, String mainimg, String name, String price, String contents, String d_contents,
			String category) {
		super();
		this.no = no;
		this.mainimg = mainimg;
		this.name = name;
		this.price = price;
		this.contents = contents;
		this.d_contents = d_contents;
		this.category = category;
	}
	@Override
	public String toString() {
		return "ProductBean [no=" + no + ", mainimg=" + mainimg + ", name=" + name + ", price=" + price + ", contents="
				+ contents + ", D_contents=" + d_contents + ", category=" + category + "]";
	}
	
	
	
}

