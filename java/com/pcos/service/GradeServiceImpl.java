package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.GradeDao;
import com.pcos.vo.GradeVO;

@Service("gradeService")
public class GradeServiceImpl implements GradeService {
	@Autowired
	private GradeDao gradeDao;

	@Override
	public void insert(GradeVO grade) {
		this.gradeDao.create(grade);
	}

	@Override
	public String selectGradeno() {
		return this.gradeDao.readGradeno();
	}

	@Override
	public List<GradeVO> selectGrades(String productCode) {
		return this.gradeDao.readGrades(productCode);
	}

	@Override
	public List<GradeVO> select(String email) {
		return this.gradeDao.read(email);
	}
	
	@Override
	public List<GradeVO> selectAll(String email) {
		return this.gradeDao.readAll(email);
	}

}
