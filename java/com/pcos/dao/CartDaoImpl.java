package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.CartVO;
import com.pcos.vo.GradeVO;

@Repository("cartDao")
public class CartDaoImpl implements CartDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<CartVO> read(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		this.sqlSession.selectList("Cart.select", map);
		List<CartVO> list = (List<CartVO>)map.get("result");
		
		return list;
	}

	@Override
	public String readCartno() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectOne("Cart.selectCartno", map);
		List<CartVO> list = (List<CartVO>)map.get("result");
		return list.get(0).getCartNo();
	}

	@Override
	public List<CartVO> readOne(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		this.sqlSession.selectOne("Cart.selectCartByEmail", map);
		List<CartVO> list = (List<CartVO>)map.get("result");
		
		return list;
	}
	
	@Override
	public void create(CartVO cart) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("cartNo", cart.getCartNo());
		map.put("amount", cart.getAmount());
		map.put("email", cart.getEmail());
		map.put("productCode", cart.getProductCode());
		this.sqlSession.insert("Cart.insertCart", map);
	}

	//이메일별 카트 사이즈
	@Override
	public int cartSize(String email) {
		return this.sqlSession.selectOne("Cart.cartSizeByEmail", email);
	}

	//주문 완료 후 카트에서 삭제
	@Override
	public void delete(String email, String cartNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		map.put("cartNo", cartNo);
		this.sqlSession.delete("Cart.delete", map);
	}

}
