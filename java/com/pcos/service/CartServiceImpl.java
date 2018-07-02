package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.CartDao;
import com.pcos.vo.CartVO;

@Service("cartService")
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDao cartDao;
	
	@Override
	public List<CartVO> select(String email) {
		return this.cartDao.read(email);
	}

	@Override
	public List<CartVO> selectOne(String email) {
		return this.cartDao.readOne(email);
	}

	@Override
	public String selectCartno() {
		return this.cartDao.readCartno();
	}

	@Override
	public void insert(CartVO cart) {
		this.cartDao.create(cart);
	}

	@Override
	public int cartSize(String email) {
		return this.cartDao.cartSize(email);
	}

	@Override
	public void delete(String email, String cartNo) {
		this.cartDao.delete(email, cartNo);
	}

}
