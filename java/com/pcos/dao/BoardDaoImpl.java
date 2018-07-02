package com.pcos.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pcos.vo.BoardVO;
import com.pcos.vo.QnAVO;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<BoardVO> read(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Board.select3", map);
		List<BoardVO> list = (List<BoardVO>)map.get("results");
		return list;
	}
	
	@Override
	public List<BoardVO> readAll(String email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("email", email);
		this.sqlSession.selectList("Board.select", map);
		List<BoardVO> list = (List<BoardVO>)map.get("results");
		return list;
	}

	@Override
	public BoardVO readOne(String boardno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardno);
		this.sqlSession.selectList("Board.selectOne", map);
		List<BoardVO> list = (List<BoardVO>)map.get("result");
		return list.get(0);
	}

	@Override
	public List<BoardVO> readAll(int order) {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectList("Board.selectAll"+order, map);
		List<BoardVO> list = (List<BoardVO>)map.get("results");
		return list;
	}

	@Override
	public void updateOne(BoardVO board, int idx) {
		this.sqlSession.update("Board.updateOne"+idx, board);
	}

	@Override
	public void updateContents(BoardVO board) {
		this.sqlSession.update("Board.updateContents",board);
	}

	@Override
	public String readBoardno() {
		Map<String, Object> map = new HashMap<String, Object>();
		this.sqlSession.selectOne("Board.selectBoardno", map);
		List<BoardVO> list = (List<BoardVO>)map.get("result");
		return list.get(0).getBoardNo();
	}

	@Override
	public void create(BoardVO board) {
		this.sqlSession.insert("Board.insert", board);
	}

	@Override
	public void delete(String boardno) {
		this.sqlSession.delete("Board.delete", boardno);
	}

}
