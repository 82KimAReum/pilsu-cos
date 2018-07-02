package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.MemberVO;

@Repository("memberDao")
public class MemberDaoImpl implements MemberDao {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<MemberVO> read() {
		return this.sqlSession.selectList("Member.select");
	}

	@Override
	public MemberVO readOne(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		
		this.sqlSession.selectList("Member.selectByEmail", map);
		List<MemberVO> list = (List<MemberVO>)map.get("result");
		
		return list.get(0);
	}

	//기본 배송지 저장
	@Override
	public void defaultAddrUpdate(MemberVO member) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("address1", member.getAddress1());
		map.put("address2", member.getAddress2());
		map.put("zipcode", member.getZipcode());
		map.put("email", member.getEmail());
		this.sqlSession.update("Member.updateDefaultAddr", member);
	}

	@Override
	public int accountCheck(String email) {
		return this.sqlSession.selectOne("Member.accountCheck", email);
	}

	@Override
	public void create(MemberVO member) {
		this.sqlSession.insert("Member.insert", member);
	}

	@Override
	public void update(MemberVO member) {
		this.sqlSession.update("Member.update", member);
	}
}
