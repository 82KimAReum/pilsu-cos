package com.pcos.service;

import java.util.List;

import com.pcos.vo.OrderVO;

public interface OrderService {
	
	//주문
	void insert(OrderVO order);
	//주문상세
	void insertDetail(OrderVO order);

	List<OrderVO> select(String email);
	List<OrderVO> selectAll(String email);
	
	String selectOrderno();
}
