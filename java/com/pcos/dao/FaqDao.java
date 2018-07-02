package com.pcos.dao;

import java.util.List;

import com.pcos.vo.FaqVO;

public interface FaqDao {
	List<FaqVO> read();
	FaqVO readOne(String faqno);
}
