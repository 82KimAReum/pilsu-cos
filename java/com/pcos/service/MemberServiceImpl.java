package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.MemberDao;
import com.pcos.vo.MemberVO;
import com.pcos.vo.ProductVO;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public List<MemberVO> select() {
		return this.memberDao.read();
	}

	@Override
	public MemberVO selectOne(String email) {
		return this.memberDao.readOne(email);
	}

	@Override
	public void defaultAddrUpdate(MemberVO member) {
		this.memberDao.defaultAddrUpdate(member);
	}

	//계정 존재 유무 체크
	@Override
	public int accountCheck(String email) {
		return this.memberDao.accountCheck(email);
	}
	
	@Override
	public void insert(MemberVO member) {
		this.memberDao.create(member);
	}

	@Override
	public void update(MemberVO member) {
		this.memberDao.update(member);
	}
}
