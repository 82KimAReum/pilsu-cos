package com.pcos.service;

import java.util.List;

import com.pcos.vo.GradeVO;

public interface GradeService {
	void insert(GradeVO grade);
	String selectGradeno();
	List<GradeVO> selectGrades(String productCode);
	List<GradeVO> select(String email);
	List<GradeVO> selectAll(String email);
}
