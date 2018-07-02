package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.ProductVO;

@Repository("productDao")
public class ProductDaoImpl implements ProductDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ProductVO> read() {
		return this.sqlSession.selectList("Product.select");
	}

	@Override
	public ProductVO readOne(String code) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productCode", code);
		this.sqlSession.selectOne("Product.selectOne", map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list.get(0);
	}

	@Override
	public List<ProductVO> readCategory(String categoryCode, int order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryCode", categoryCode);
		this.sqlSession.selectList("Product.selectCategory" + order, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readMCategory(String categoryCode, int order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryCode", categoryCode);
		this.sqlSession.selectList("Product.selectMCategory" + order, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readBrand(String brandCode, int order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandCode", brandCode);
		this.sqlSession.selectList("Product.selectBrand" + order, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readBrandCategory(String brandCode, String categoryCode, int order) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("brandCode", brandCode);
		map.put("categoryCode", categoryCode);
		this.sqlSession.selectList("Product.selectBrandCategory" + order, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readType(int type) {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectList("Product.selectType" + type, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readTypeCategory(int type, String categoryCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("categoryCode", categoryCode);
		this.sqlSession.selectList("Product.selectTypeCategory" + type, map);
		List<ProductVO> list = (List<ProductVO>) map.get("result");
		return list;
	}

	@Override
	public List<ProductVO> readSearch(String search) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		this.sqlSession.selectList("Product.selectSearch", map);
		List<ProductVO> list = (List<ProductVO>) map.get("results");
		return list;
	}

}
