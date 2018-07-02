package com.pcos.vo;

import java.util.ArrayList;
import java.util.List;

public class Cart2VO {
	private String cartNo, email;
	private ArrayList<Object> cartProducts;
	
	public Cart2VO() {}
	
	public Cart2VO(String cartNo, String email, ArrayList<Object> cartProductList) {
		this.cartNo = cartNo;
		this.email = email;
		this.cartProducts = cartProductList;
	}

	public String getCartNo() {
		return cartNo;
	}
	
	public void setCartNo(String cartNo) {
		this.cartNo = cartNo;
	}

	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public ArrayList<Object> getCartProducts() {
		return cartProducts;
	}

	public void setCartProducts(ArrayList<Object> cartProducts) {
		this.cartProducts = cartProducts;
	}

	@Override
	public String toString() {
		return "Cart2VO [cartNo=" + cartNo + ", email=" + email + ", cartProducts=" + cartProducts + "]";
	}

	

}
