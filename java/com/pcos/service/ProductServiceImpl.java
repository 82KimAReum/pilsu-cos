package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.ProductDao;
import com.pcos.vo.ProductVO;

@Service("productService")
public class ProductServiceImpl implements ProductService {
	@Autowired
	private ProductDao productDao;
	
	@Override
	public List<ProductVO> select() {
		return this.productDao.read();
	}

	@Override
	public ProductVO selectOne(String code) {
		return this.productDao.readOne(code);
	}

	@Override
	public List<ProductVO> selectCategory(String categoryCode,int order) {
		return this.productDao.readCategory(categoryCode,order);
	}
	
	@Override
	public List<ProductVO> selectMCategory(String categoryCode,int order) {
		return this.productDao.readMCategory(categoryCode,order);
	}

	@Override
	public List<ProductVO> selectBrand(String brandCode, int order) {
		return this.productDao.readBrand(brandCode, order);
	}

	@Override
	public List<ProductVO> selectBrandCategory(String brandCode, String categoryCode, int order) {
		return this.productDao.readBrandCategory(brandCode, categoryCode, order);
	}

	@Override
	public List<ProductVO> selectType(int type) {
		return this.productDao.readType(type);
	}

	@Override
	public List<ProductVO> selectTypeCategory(int type, String categoryCode) {
		return this.productDao.readTypeCategory(type, categoryCode);
	}

	@Override
	public List<ProductVO> selectSearch(String search) {
		return this.productDao.readSearch(search);
	}

}
