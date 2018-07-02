package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.FaqDao;
import com.pcos.vo.FaqVO;

@Service("faqService")
public class FaqServiceImpl implements FaqService {
	
	@Autowired
	private FaqDao faqDao;

	@Override
	public List<FaqVO> select() {
		return this.faqDao.read();
	}

	@Override
	public FaqVO selectOne(String faqno) {
		return this.faqDao.readOne(faqno);
	}

}
