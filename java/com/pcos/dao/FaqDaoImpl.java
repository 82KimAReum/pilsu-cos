package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.FaqVO;
import com.pcos.vo.QnAVO;

@Repository("faqDao")
public class FaqDaoImpl implements FaqDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<FaqVO> read() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<FaqVO> list = this.sqlSession.selectList("Faq.select");
		return list;
	}

	@Override
	public FaqVO readOne(String faqno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("faqno", faqno);
		this.sqlSession.selectOne("Faq.selectOne", map);
		List<FaqVO> list = (List<FaqVO>)map.get("result");
		return list.get(0);
	}

}
