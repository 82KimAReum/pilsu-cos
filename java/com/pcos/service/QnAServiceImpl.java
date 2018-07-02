package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.QnADao;
import com.pcos.vo.QnAVO;

@Service("qnaService")
public class QnAServiceImpl implements QnAService {
	@Autowired
	private QnADao qnaDao;

	@Override
	public void insert(QnAVO qna) {
		this.qnaDao.create(qna);
	}

	@Override
	public String selectQnano() {
		return this.qnaDao.readQnano();
	}

	@Override
	public List<QnAVO> select(String email) {
		return this.qnaDao.read(email);
	}
	
	@Override
	public List<QnAVO> selectAll(String email) {
		return this.qnaDao.read(email);
	}

	@Override
	public QnAVO selectOne(String qnano) {
		return this.qnaDao.readOne(qnano);
	}

}
