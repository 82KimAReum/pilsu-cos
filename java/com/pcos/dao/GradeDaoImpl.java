package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.GradeVO;

@Repository("gradeDao")
public class GradeDaoImpl implements GradeDao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public String readGradeno() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectOne("Grade.selectGradeno", map);
		List<GradeVO> list = (List<GradeVO>)map.get("result");
		return list.get(0).getGradeno();
	}

	@Override
	public List<GradeVO> readGrades(String productCode) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productCode", productCode);
		this.sqlSession.selectList("Grade.selectGrades", map);
		List<GradeVO> list = (List<GradeVO>)map.get("results");
		return list;
	}

	@Override
	public List<GradeVO> read(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Grade.select3", map);
		List<GradeVO> list = (List<GradeVO>)map.get("results");
		return list;
	}
	
	@Override
	public List<GradeVO> readAll(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Grade.select", map);
		List<GradeVO> list = (List<GradeVO>)map.get("results");
		return list;
	}
	
   @Override
   public void create(GradeVO grade) {
      System.out.println(grade.getSkintype());
      if(grade.getSkintype().equals("지성")) {
    	  this.sqlSession.insert("Grade.insert1", grade);
      } else if(grade.getSkintype().equals("건성")) {
    	  this.sqlSession.insert("Grade.insert2", grade);
      } else if(grade.getSkintype().equals("복합성")) {
    	  this.sqlSession.insert("Grade.insert3", grade);
      }
   }
}
