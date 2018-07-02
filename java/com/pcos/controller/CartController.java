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

import com.pcos.service.CartService;
import com.pcos.vo.CartVO;
import com.pcos.vo.OrderVO;

@Controller
public class CartController {
	@Autowired
	private CartService cartService;

	// 회원 아이디와 일치하는 카트 목록 전체
	@RequestMapping(value = "/cartList", method = RequestMethod.POST)
	@ResponseBody
	public Map cartList(@RequestBody CartVO cart) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<CartVO> list = this.cartService.select(cart.getEmail());

		result.put("code", Boolean.TRUE);
		result.put("data", list);

		return result;
	}

	//상품 하나 클릭시에 내용 뿌려주기
	@RequestMapping(value="/CartAll/{email}", method=RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable String email) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<CartVO> list = this.cartService.select(email);

		result.put("code", Boolean.TRUE);
		result.put("data", list);
		
		return result;
	}
	
	// detail.jsp에서 장바구니 담으면,
	@RequestMapping(value = "/inputCart", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public Map inputCart(@RequestBody CartVO cart) {
		String maxCartno = this.cartService.selectCartno();
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

		if (maxCartno.substring(5, 13).equals(sdf.format(today).toString())) {
			int no = Integer.parseInt(maxCartno.substring(14));
			no++;
			cart.setCartNo(maxCartno.substring(0, 14) + String.format("%04d", no));
		} else {
			cart.setCartNo("cart_" + sdf.format(today) + "_0001");
		}

		Map<String, Object> result = new HashMap<String, Object>();
		CartVO cart2 = new CartVO();
		cart2.setCartNo(cart.getCartNo());
		cart2.setAmount(cart.getAmount());
		cart2.setEmail(cart.getEmail());
		cart2.setProductCode(cart.getProductCode());
		this.cartService.insert(cart2);
		result.put("code", Boolean.TRUE);

		return result;
	}

	//장바구니에서 삭제
	@RequestMapping(value = "/deleteFromCart", method = RequestMethod.POST)
	@ResponseBody
	public Map deleteCart(String email, String cartNo) {
		Map<String, Object> result = new HashMap<String, Object>();
		this.cartService.delete(email, cartNo);
		result.put("code", Boolean.TRUE);
		
		return result;
	}
	
	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String goToCartPage() {
		return "cart";
	}
	
}
