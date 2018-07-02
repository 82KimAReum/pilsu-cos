package com.pcos.service;

import java.util.List;

import com.pcos.vo.CartVO;
import com.pcos.vo.MemberVO;

public interface CartService {
	List<CartVO> select(String email);
	List<CartVO> selectOne(String email);
	String selectCartno();

	void insert(CartVO cart);
	int cartSize(String email);
	
	void delete(String email, String cartNo);
}
