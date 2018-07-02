package com.pcos.service;

import java.util.List;

import com.pcos.vo.FaqVO;

public interface FaqService {

	List<FaqVO> select();
	FaqVO selectOne(String faqno);
}
