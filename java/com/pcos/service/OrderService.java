package com.pcos.service;

import java.util.List;

import com.pcos.vo.OrderVO;

public interface OrderService {
	
	//�ֹ�
	void insert(OrderVO order);
	//�ֹ���
	void insertDetail(OrderVO order);

	List<OrderVO> select(String email);
	List<OrderVO> selectAll(String email);
	
	String selectOrderno();
}
