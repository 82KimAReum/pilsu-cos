package com.pcos.service;

import java.util.List;

import com.pcos.vo.MemberVO;
import com.pcos.vo.ProductVO;

public interface MemberService {
	List<MemberVO> select();
	MemberVO selectOne(String email);
	void defaultAddrUpdate(MemberVO member);
	
	int accountCheck(String email);
	void insert(MemberVO member);
	void update(MemberVO member);
}
