package com.pcos.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcos.service.BoardService;
import com.pcos.vo.BoardVO;

@Controller
public class BoardController {

	@Autowired
	private BoardService boardService;

	@RequestMapping(value = "/myBoard/{email}", method = RequestMethod.GET)
	@ResponseBody
	public Map select(@PathVariable String email) {
		List<BoardVO> list = this.boardService.select(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/BoardAll/{email}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable String email) {
		List<BoardVO> list = this.boardService.selectAll(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/oneBoard/{boardno}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectOne(@PathVariable String boardno) {
		BoardVO board = this.boardService.selectOne(boardno);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", board);
		return result;
	}

	@RequestMapping(value = "/Board/{order}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable int order) {
		List<BoardVO> list = this.boardService.selectAll(order);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/updateBoard/{boardno}/{idx}", method = RequestMethod.PUT)
	@ResponseBody
	public Map updateOne(@RequestBody BoardVO board, @PathVariable String boardno, @PathVariable int idx) {
		// System.out.println(board.getEmail());
		board.setBoardNo(boardno);
		if (idx == 3) {
			this.boardService.updateContents(board);
		} else {
			this.boardService.updateOne(board, idx);
		}
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		return result;
	}

	@RequestMapping(value = "/inputBoard", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(@RequestBody BoardVO board) {
		String maxQnano = this.boardService.selectBoardno();
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if (maxQnano.substring(6, 14).equals(sdf.format(today).toString())) {
			int no = Integer.parseInt(maxQnano.substring(15));
			no += 1;
			board.setBoardNo(maxQnano.substring(0, 15) + String.format("%04d", no));
		} else {
			board.setBoardNo("board_" + sdf.format(today) + "_0001");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		this.boardService.insert(board);
		result.put("code", Boolean.TRUE);
		return result;
	}

	@RequestMapping(value = "/board/{boardno}", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView loginAuth(@PathVariable String boardno) {
		ModelAndView mav = new ModelAndView();
		BoardVO board = this.boardService.selectOne(boardno);
		String contents = board.getContents().replaceAll("\n", "<br/>");
		board.setContents(contents);
		mav.addObject("code", Boolean.TRUE);
		mav.addObject("board", board);
		mav.setViewName("readBoard");
		return mav;

	}

	@RequestMapping(value = "/writeBoard", method = RequestMethod.GET)
	public String goToCartPage() {
		return "writeBoard";
	}

	@RequestMapping(value = "/deleteBoard/{boardno}", method = RequestMethod.DELETE)
	@ResponseBody
	public Map delete(@PathVariable String boardno) {
		this.boardService.delete(boardno);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		return result;
	}
}
