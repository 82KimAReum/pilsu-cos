package com.pcos.dao;

import java.util.List;

import com.pcos.vo.CartVO;

public interface CartDao {
	List<CartVO> read(String email);
	String readCartno();

	List<CartVO> readOne(String email);
	
	void create(CartVO cart);
	
	int cartSize(String email);
	
	void delete(String email, String cartNo);
}
