package com.pcos.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcos.service.ProductService;
import com.pcos.vo.PageVO;
import com.pcos.vo.ProductVO;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value = "/category", method = RequestMethod.GET)
	@ResponseBody
	public Map select() {
		Map<String, Object> result = new HashMap<String, Object>();
		List<ProductVO> list = this.productService.select();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
	
	//category.html
	@RequestMapping(value = "/categoryList", method = RequestMethod.GET)
	@ResponseBody
	public Map categorypaging(@RequestParam(value = "page", required = false) String page,
					@RequestParam(value = "type", required = false) String type,
					@RequestParam(value = "order", required = false) String order) {
		
		int order2 = Integer.parseInt(order);
		
		Map<String, Object> result = new HashMap<String, Object>();
			
		if (page == null) {
			System.out.println("page null");
			return result;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", (Integer.parseInt(page) - 1) * 12 + 1);
		map.put("rowEnd", (Integer.parseInt(page) - 1) * 12 + 1 + 11);

		int count = this.productService.selectCategory(type, order2).size();
		PageVO pagevo = new PageVO(count, Integer.parseInt(page));
		List<ProductVO> list = this.productService.selectCategory(type, order2);
		List<ProductVO> list2 = new ArrayList<ProductVO>();
		 
		for (int i = (Integer) map.get("rowStart"); i <= (Integer) map.get("rowEnd") && i < pagevo.getCount(); i++) {
			list2.add(list.get(i));
		}
		
		result.put("code", Boolean.TRUE);
		result.put("page", pagevo);
		result.put("data", list2);

		return result;
	}

	//man.html(페이징 포함)
	@RequestMapping(value = "/manList", method = RequestMethod.GET)
	@ResponseBody
	public Map manpaging(@RequestParam(value = "page", required = false) String page,
					@RequestParam(value = "type", required = false) String type,
					@RequestParam(value = "order", required = false) String order) {
		
		int order2 = Integer.parseInt(order);
		
		Map<String, Object> result = new HashMap<String, Object>();
			
		if (page == null) {
			System.out.println("page null");
			return result;
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", (Integer.parseInt(page) - 1) * 12 + 1);
		map.put("rowEnd", (Integer.parseInt(page) - 1) * 12 + 1 + 11);

		int count = this.productService.selectMCategory(type, order2).size();
		PageVO pagevo = new PageVO(count, Integer.parseInt(page));
		List<ProductVO> list = this.productService.selectMCategory(type, order2);
		List<ProductVO> list2 = new ArrayList<ProductVO>();
		 
		for (int i = (Integer) map.get("rowStart"); i <= (Integer) map.get("rowEnd") && i < pagevo.getCount(); i++) {
			list2.add(list.get(i));
		}
		
		result.put("code", Boolean.TRUE);
		result.put("page", pagevo);
		result.put("data", list2);

		return result;
	}

	//skintype.html(페이징 포함)
	@RequestMapping(value = "/skintypeList", method = RequestMethod.GET)
	@ResponseBody
	public Map skintypepaging(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "type", required = false) int type,
			@RequestParam(value = "categoryCode", required = false) String categoryCode) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (page == null) {
			System.out.println("page null");
			return result;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", (Integer.parseInt(page) - 1) * 12 + 1);
		map.put("rowEnd", (Integer.parseInt(page) - 1) * 12 + 1 + 11);
		
		int count = 0;
		if(Integer.parseInt(categoryCode)==0) count = this.productService.selectType(type).size();
		else count = this.productService.selectTypeCategory(type, categoryCode).size();
		PageVO pagevo = new PageVO(count, Integer.parseInt(page));
		
		List<ProductVO> list = null;
		if(Integer.parseInt(categoryCode)==0) list = this.productService.selectType(type);
		else list = this.productService.selectTypeCategory(type, categoryCode);
		
		List<ProductVO> list2 = new ArrayList<ProductVO>();
		
		for (int i = (Integer) map.get("rowStart"); i <= (Integer) map.get("rowEnd") && i < pagevo.getCount(); i++) {
			list2.add(list.get(i));
		}
		
		result.put("code", Boolean.TRUE);
		result.put("page", pagevo);
		result.put("data", list2);
		
		return result;
	}

	//brand.html(페이징 포함)
	@RequestMapping(value = "/brandList", method = RequestMethod.GET)
	@ResponseBody
	public Map brandpaging(@RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "brandCode", required = false) String brandCode,
			@RequestParam(value = "categoryCode", required = false) String categoryCode,
			@RequestParam(value = "order", required = false) int order) {
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (page == null) {
			System.out.println("page null");
			return result;
		}
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rowStart", (Integer.parseInt(page) - 1) * 12 + 1);
		map.put("rowEnd", (Integer.parseInt(page) - 1) * 12 + 1 + 11);
		
		int count = 0;
		List<ProductVO> list = null;
		if(Integer.parseInt(categoryCode) == 0) {
			count = this.productService.selectBrand(brandCode, order).size();
			list = this.productService.selectBrand(brandCode, order);
		} else {
			count = this.productService.selectBrandCategory(brandCode, categoryCode, order).size();
			list = this.productService.selectBrandCategory(brandCode, categoryCode, order);
		}
		PageVO pagevo = new PageVO(count, Integer.parseInt(page));
		List<ProductVO> list2 = new ArrayList<ProductVO>();
		
		for (int i = (Integer) map.get("rowStart"); i <= (Integer) map.get("rowEnd") && i < pagevo.getCount(); i++) {
			list2.add(list.get(i));
		}
		
		result.put("code", Boolean.TRUE);
		result.put("page", pagevo);
		result.put("data", list2);
		
		return result;
	}
	
	//상세 페이지
	@RequestMapping(value="/detail/{code}", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectOne(@PathVariable String code) {
		ProductVO prod = this.productService.selectOne(code);
		ModelAndView mav=new ModelAndView();
		mav.addObject("code", Boolean.TRUE);
		prod.setProductCode(code);
		mav.addObject("data", prod);
		mav.setViewName("detail");
		return mav;
	}
	
	//검색 페이지
	@RequestMapping(value="/search/{search}", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectSearch(@PathVariable String search) {
		ModelAndView mav=new ModelAndView();
		List<ProductVO> list=this.productService.selectSearch(search);
		mav.addObject("code", Boolean.TRUE);
		mav.addObject("data", list);
		mav.setViewName("search");
		return mav;
	}
	
}
