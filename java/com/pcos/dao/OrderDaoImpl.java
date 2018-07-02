package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.CartVO;
import com.pcos.vo.OrderVO;

@Repository("orderDao")
public class OrderDaoImpl implements OrderDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void create(OrderVO order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNo", order.getOrderNo());
		map.put("name", order.getName());
		map.put("zipcode", order.getZipcode());
		map.put("address1", order.getAddress1());
		map.put("address2", order.getAddress2());
		map.put("phone", order.getPhone());
		map.put("comments", order.getComments());
		map.put("email", order.getEmail());
		
		this.sqlSession.insert("Order.insertOrder", map);
	}

	@Override
	public void createDetail(OrderVO order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNo", order.getOrderNo());
		map.put("productCode", order.getProductCode());
		map.put("amount", order.getAmount());
		map.put("price", order.getPrice());
		
		this.sqlSession.insert("Order.insertOrderDetail", map);
	}
	
	@Override
	public List<OrderVO> read(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Order.select3", map);
		List<OrderVO> list = (List<OrderVO>)map.get("results");
		return list;
	}

	@Override
	public List<OrderVO> readAll(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Order.select", map);
		List<OrderVO> list = (List<OrderVO>)map.get("results");
		return list;
	}

	@Override
	public String readOrderno() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectOne("Order.selectOrderno", map);
		List<OrderVO> list = (List<OrderVO>)map.get("result");
		return list.get(0).getOrderNo();
	}
}
