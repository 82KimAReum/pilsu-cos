package com.pcos.service;

import java.util.List;

import com.pcos.vo.ProductVO;

public interface ProductService {
	List<ProductVO> select();
	ProductVO selectOne(String code);
	List<ProductVO> selectCategory(String categoryCode, int order);
	List<ProductVO> selectMCategory(String categoryCode, int order);
	List<ProductVO> selectBrand(String brandCode, int order);
	List<ProductVO> selectBrandCategory(String brandCode, String categoryCode, int order);
	List<ProductVO> selectType(int type);
	List<ProductVO> selectTypeCategory(int type, String categoryCode);
	List<ProductVO> selectSearch(String search);
}
