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

import com.pcos.service.GradeService;
import com.pcos.vo.GradeVO;
import com.pcos.vo.QnAVO;

@Controller
public class GradeController {
	@Autowired
	private GradeService gradeService;

	@RequestMapping(value = "/inputGrade", method = RequestMethod.POST)
	@ResponseBody
	public Map insert(@RequestBody GradeVO grade) {
		System.out.println(grade);
		String maxGradeno = this.gradeService.selectGradeno();
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		if (maxGradeno.substring(6, 14).equals(sdf.format(today).toString())) {
			int no = Integer.parseInt(maxGradeno.substring(15));
			no += 1;
			grade.setGradeno(maxGradeno.substring(0, 15) + String.format("%04d", no));
		} else {
			grade.setGradeno("grade_" + sdf.format(today) + "_0001");
		}
		Map<String, Object> result = new HashMap<String, Object>();
		this.gradeService.insert(grade);
		result.put("code", Boolean.TRUE);
		return result;
	}

	@RequestMapping(value = "/comments/{productCode}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectComments(@PathVariable String productCode) {
		List<GradeVO> list = this.gradeService.selectGrades(productCode);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/myGrade/{email}", method = RequestMethod.GET)
	@ResponseBody
	public Map select(@PathVariable String email) {
		List<GradeVO> list = this.gradeService.select(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}

	@RequestMapping(value = "/GradeAll/{email}", method = RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable String email) {
		List<GradeVO> list = this.gradeService.selectAll(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
}
