package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.OrderDao;
import com.pcos.vo.OrderVO;

@Service("orderService")
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDao orderDao;

	@Override
	public void insert(OrderVO order) {
		this.orderDao.create(order);
	}

	@Override
	public void insertDetail(OrderVO order) {
		this.orderDao.createDetail(order);
	}
	
	@Override
	public List<OrderVO> select(String email) {
		return this.orderDao.read(email);
	}

	@Override
	public List<OrderVO> selectAll(String email) {
		return this.orderDao.readAll(email);
	}

	@Override
	public String selectOrderno() {
		return this.orderDao.readOrderno();
	}
}
