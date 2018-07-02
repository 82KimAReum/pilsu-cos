package com.pcos.dao;

import java.util.List;

import com.pcos.vo.MemberVO;

public interface MemberDao {
	List<MemberVO> read();
	MemberVO readOne(String email);
	void defaultAddrUpdate(MemberVO member);
	
	int accountCheck(String email);
	void create(MemberVO member);
	void update(MemberVO member);
}
