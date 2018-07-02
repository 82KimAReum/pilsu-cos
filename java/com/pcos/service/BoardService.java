package com.pcos.service;

import java.util.List;

import com.pcos.vo.BoardVO;

public interface BoardService {
	List<BoardVO> select(String email);
	List<BoardVO> selectAll(String email);
	BoardVO selectOne(String boardno);
	List<BoardVO> selectAll(int order);
	void updateOne(BoardVO board, int idx);
	void updateContents(BoardVO board);
	String selectBoardno();
	void insert(BoardVO board);
	void delete(String boardno);
}
