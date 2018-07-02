package com.pcos.dao;

import java.util.List;

import com.pcos.vo.OrderVO;

public interface OrderDao {
	
	//¡÷πÆ
	void create(OrderVO order);
	void createDetail(OrderVO order);
	List<OrderVO> read(String email);
	List<OrderVO> readAll(String email);

	String readOrderno();
}
