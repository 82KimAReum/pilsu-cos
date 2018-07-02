package com.pcos.dao;

import java.util.List;

import com.pcos.vo.BoardVO;

public interface BoardDao {
	List<BoardVO> read(String email);
	List<BoardVO> readAll(String email);
	BoardVO readOne(String boardno);
	List<BoardVO> readAll(int order);
	void updateOne(BoardVO board, int idx);
	void updateContents(BoardVO board);
	String readBoardno();
	void create(BoardVO board);
	void delete(String boardno);
}
