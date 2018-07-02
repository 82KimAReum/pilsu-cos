package com.pcos.dao;

import java.util.List;

import com.pcos.vo.GradeVO;

public interface GradeDao {
	void create(GradeVO grade);
	String readGradeno();
	List<GradeVO> readGrades(String productCode);
	List<GradeVO> read(String email);
	List<GradeVO> readAll(String email);
}
