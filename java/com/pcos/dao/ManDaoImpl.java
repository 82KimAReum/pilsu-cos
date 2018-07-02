package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.ProductVO;

@Repository("manDao")
public class ManDaoImpl implements ManDao {
@Autowired
private SqlSession sqlSession;
	@Override
	public List<ProductVO> selectAll() {
		//System.out.println(categoryCode);
		return this.sqlSession.selectList("Man.selectAll");
	}
	@Override
	public int selectCount() {
		return this.sqlSession.selectOne("Man.selectCount");
	}
	
	@Override
	public int selectCountSkin(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountSkin",categoryCode);
	}
	@Override
	public List<ProductVO> selectSkin(String categoryCode) {
		return this.sqlSession.selectList("Man.selectSkin",categoryCode);
	}
	@Override
	public int selectCountLotion(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountLotion",categoryCode);
	}
	@Override
	public List<ProductVO> selectLotion(String categoryCode) {
		return this.sqlSession.selectList("Man.selectLotion",categoryCode);
	}
	@Override
	public int selectCountEssence(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountEssence",categoryCode);
	}
	@Override
	public List<ProductVO> selectEssence(String categoryCode) {
		return this.sqlSession.selectList("Man.selectEssence",categoryCode);
	}
	@Override
	public int selectCountCream(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountCream",categoryCode);
	}
	@Override
	public List<ProductVO> selectCream(String categoryCode) {
		return this.sqlSession.selectList("Man.selectCream",categoryCode);
	}
	@Override
	public int selectCountOil(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountOil",categoryCode);
	}
	@Override
	public List<ProductVO> selectOil(String categoryCode) {
		return this.sqlSession.selectList("Man.selectOil",categoryCode);
	}
	@Override
	public int selectCountShaving(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountShaving",categoryCode);
	}
	@Override
	public List<ProductVO> selectShaving(String categoryCode) {
		return this.sqlSession.selectList("Man.selectShaving",categoryCode);
	}
	@Override
	public int selectCountCleansing(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountCleansing",categoryCode);
	}
	@Override
	public List<ProductVO> selectCleansing(String categoryCode) {
		return this.sqlSession.selectList("Man.selectCleansing",categoryCode);
	}
	@Override
	public int selectCountMask(String categoryCode) {
		return this.sqlSession.selectOne("Man.selectCountMask",categoryCode);
	}
	@Override
	public List<ProductVO> selectMask(String categoryCode) {
		return this.sqlSession.selectList("Man.selectMask",categoryCode);
	}

}
