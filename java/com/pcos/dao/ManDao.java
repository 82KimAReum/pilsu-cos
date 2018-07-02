package com.pcos.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.pcos.vo.ProductVO;

@Repository
public interface ManDao {
List<ProductVO> selectAll ();
int selectCount();


int selectCountSkin(String categoryCode);
List<ProductVO> selectSkin(String categoryCode);
int selectCountLotion(String categoryCode);
List<ProductVO> selectLotion(String categoryCode);
int selectCountEssence(String categoryCode);
List<ProductVO> selectEssence(String categoryCode);
int selectCountCream(String categoryCode);
List<ProductVO> selectCream(String categoryCode);
int selectCountOil(String categoryCode);
List<ProductVO> selectOil(String categoryCode);
int selectCountShaving(String categoryCode);
List<ProductVO> selectShaving(String categoryCode);
int selectCountCleansing(String categoryCode);
List<ProductVO> selectCleansing(String categoryCode);
int selectCountMask(String categoryCode);
List<ProductVO> selectMask(String categoryCode);
}
