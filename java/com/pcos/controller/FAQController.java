package com.pcos.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pcos.service.FaqService;
import com.pcos.vo.FaqVO;
import com.pcos.vo.QnAVO;

@Controller
public class FAQController {
	@Autowired
	private FaqService faqService;
	
	@RequestMapping(value = "/FAQ", method = RequestMethod.GET)
	@ResponseBody
	public Map select() {
		
		List<FaqVO> list = this.faqService.select();
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
	
	@RequestMapping(value="/oneFaq/{faqno}", method=RequestMethod.GET)
	@ResponseBody
	public Map selectOne(@PathVariable String faqno) {
		FaqVO faq=this.faqService.selectOne(faqno);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", faq);
		return result;
	}

	
}
