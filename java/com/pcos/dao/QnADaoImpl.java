package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.ProductVO;
import com.pcos.vo.QnAVO;

@Repository("qnaDao")
public class QnADaoImpl implements QnADao {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void create(QnAVO qna) {
		this.sqlSession.insert("Qna.insert", qna);
	}

	@Override
	public String readQnano() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectOne("Qna.selectQnano", map);
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		return list.get(0).getQnano();
	}

	@Override
	public List<QnAVO> read(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Qna.select3", map);
		List<QnAVO> list = (List<QnAVO>)map.get("results");
		return list;
	}
	
	@Override
	public List<QnAVO> readAll(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Qna.select", map);
		List<QnAVO> list = (List<QnAVO>)map.get("results");
		return list;
	}

	@Override
	public QnAVO readOne(String qnano) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("qnano", qnano);
		this.sqlSession.selectList("Qna.selectOne", map);
		List<QnAVO> list = (List<QnAVO>)map.get("result");
		return list.get(0);
	}

}
