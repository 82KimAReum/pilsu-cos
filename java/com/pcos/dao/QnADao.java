package com.pcos.dao;

import java.util.List;

import com.pcos.vo.QnAVO;

public interface QnADao {
	void create(QnAVO qna);
	String readQnano();
	List<QnAVO> read(String email);
	List<QnAVO> readAll(String email);
	QnAVO readOne(String qnano);
}
