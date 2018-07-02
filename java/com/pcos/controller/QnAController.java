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

import com.pcos.service.QnAService;
import com.pcos.vo.QnAVO;

@Controller
public class QnAController {
	@Autowired
	private QnAService qnaService;
	
	@RequestMapping(value = "/inputQnA", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(@RequestBody QnAVO qna) {
		String maxQnano=this.qnaService.selectQnano();
		Date today=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
		if(maxQnano.substring(4, 12).equals(sdf.format(today).toString())) {
			int no=Integer.parseInt(maxQnano.substring(13));
			no+=1;
			qna.setQnano(maxQnano.substring(0,13)+String.format("%04d",no));
		}else {
			qna.setQnano("qna_"+sdf.format(today)+"_0001");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		this.qnaService.insert(qna);
		result.put("code", Boolean.TRUE);
		return result;
	}
	
	@RequestMapping(value="/myQnA/{email}", method=RequestMethod.GET)
	@ResponseBody
	public Map select(@PathVariable String email) {
		List<QnAVO> list=this.qnaService.select(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
	
	@RequestMapping(value="/QnaAll/{email}", method=RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable String email) {
		List<QnAVO> list=this.qnaService.selectAll(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
	
	@RequestMapping(value="/oneQnA/{qnano}", method=RequestMethod.GET)
	@ResponseBody
	public Map selectOne(@PathVariable String qnano) {
		QnAVO qna=this.qnaService.selectOne(qnano);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", qna);
		return result;
	}
	
   @RequestMapping(value = "/qna", method = RequestMethod.GET)
   public String goToCartPage() {
      return "qna";
   }
   
   @RequestMapping(value = "/mycomment", method = RequestMethod.GET)
   public String goToMyCommentPage() {
      return "mycomment";
   }
}
