package com.pcos.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pcos.dao.BoardDao;
import com.pcos.vo.BoardVO;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;

	@Override
	public List<BoardVO> select(String email) {
		return this.boardDao.read(email);
	}
	
	@Override
	public List<BoardVO> selectAll(String email) {
		return this.boardDao.readAll(email);
	}

	@Override
	public BoardVO selectOne(String boardno) {
		return this.boardDao.readOne(boardno);
	}

	@Override
	public List<BoardVO> selectAll(int order) {
		return this.boardDao.readAll(order);
	}

	@Override
	public void updateOne(BoardVO board, int idx) {
		this.boardDao.updateOne(board, idx);
	}

	@Override
	public void updateContents(BoardVO board) {
		this.boardDao.updateContents(board);
	}

	@Override
	public String selectBoardno() {
		return this.boardDao.readBoardno();
	}

	@Override
	public void insert(BoardVO board) {
		this.boardDao.create(board);
	}

	@Override
	public void delete(String boardno) {
		this.boardDao.delete(boardno);
	}

}
