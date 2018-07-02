package com.pcos.service;

import java.util.List;

import com.pcos.vo.QnAVO;

public interface QnAService {
	void insert(QnAVO qna);
	String selectQnano();
	List<QnAVO> select(String email);
	List<QnAVO> selectAll(String email);
	QnAVO selectOne(String qnano);
}
