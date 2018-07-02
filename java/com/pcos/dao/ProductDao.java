package com.pcos.dao;

import java.util.List;

import com.pcos.vo.ProductVO;

public interface ProductDao {
	List<ProductVO> read();
	ProductVO readOne(String code);
	List<ProductVO> readCategory(String categoryCode, int order);
	List<ProductVO> readMCategory(String categoryCode, int order);
	List<ProductVO> readBrand(String brandCode, int order);
	List<ProductVO> readBrandCategory(String brandCode, String categoryCode, int order);
	List<ProductVO> readType(int type);
	List<ProductVO> readTypeCategory(int type, String categoryCode);
	List<ProductVO> readSearch(String search);
}
