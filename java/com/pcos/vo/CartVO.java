package com.pcos.vo;

public class CartVO {
	private String cartNo, email;
	private int amount, price;
	private String productCode, productName, image;

	public CartVO() {}
	
	public String getCartNo() {
		return cartNo;
	}
	
	public void setCartNo(String cartNo) {
		this.cartNo = cartNo;
	}
	
	public int getAmount() {
		return amount;
	}
	
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getProductCode() {
		return productCode;
	}
	
	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	@Override
	public String toString() {
		return "CartVO [cartNo=" + cartNo + ", email=" + email + ", amount=" + amount + ", price=" + price
				+ ", productCode=" + productCode + ", productName=" + productName + ", image=" + image + "]";
	}
	
}
