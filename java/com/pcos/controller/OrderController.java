package com.pcos.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
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

import com.pcos.service.CartService;
import com.pcos.service.MemberService;
import com.pcos.service.OrderService;
import com.pcos.service.ProductService;
import com.pcos.vo.MemberVO;
import com.pcos.vo.OrderVO;
import com.pcos.vo.ProductVO;

@Controller
public class OrderController {
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CartService cartService;
	
	@Autowired
	private ProductService productService;
	
	@Autowired
    private OrderService orderService;

	//�ֹ� ȭ��
	@RequestMapping(value = "/order", method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView cartToOrder(@RequestParam("email") String email,
									@RequestParam(required = false, value="productCode") String productCode,
									@RequestParam(required = false, value="amount") int amount) {
		
		ModelAndView mav = new ModelAndView();
		MemberVO member = this.memberService.selectOne(email);
		ProductVO product = null;
		
		
		//��ǰ �󼼺��⿡�� �ٷ� ���� ������ �� ����
		if(productCode != null) {
			product = this.productService.selectOne(productCode);
			product.setProductCode(productCode);
			product.setOrderAmount(amount);
			mav.addObject("product", product);
		}

		mav.addObject("code", Boolean.TRUE);
		mav.addObject("data", member);
		mav.setViewName("order");
		
		return mav;
	}
	
	//�ֹ� �Ϸ� ȭ��
	@RequestMapping(value = "/orderComplete", method = RequestMethod.POST)
	public String orderInsert(@RequestParam("recipient") String recipient,
							@RequestParam("zipcode") String zipcode,
							@RequestParam("address1") String address1,
							@RequestParam("address2") String address2,
							@RequestParam("phone21") String phone21,
							@RequestParam("phone22") String phone22,
							@RequestParam("phone23") String phone23,
							@RequestParam("comments") String comments,
							@RequestParam("email") String email,
							@RequestParam(value = "cartNo", required = false) String[] cartNo,
							@RequestParam("productCode") String[] productCode,
							@RequestParam("amount") String[] amount,
							@RequestParam("price") String[] price,
							@RequestParam("deliveryAddrVal") String deliveryAddrVal,
							@RequestParam("defaultDeliveryAddrVal") String defaultDeliveryAddrVal) {

		OrderVO order = new OrderVO();
		
		String maxOrderno = this.orderService.selectOrderno();
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		
		if(maxOrderno.substring(6, 14).equals(sdf.format(today).toString())) {
			int no = Integer.parseInt(maxOrderno.substring(15));
			no += 1;
			order.setOrderNo(maxOrderno.substring(0, 15) + String.format("%04d", no));
		} else {
			order.setOrderNo("order_" + sdf.format(today) + "_0001");
		}		
		
		order.setName(recipient);
		order.setZipcode(zipcode);
		order.setAddress1(address1);
		order.setAddress2(address2);
		order.setPhone(phone21 + phone22 + phone23);
		order.setComments(comments);
		order.setEmail(email);
		this.orderService.insert(order);
		
		for(int i=0; i < productCode.length; i++) {
			order.setProductCode(productCode[i]);
			order.setAmount(Integer.parseInt(amount[i]));
			order.setPrice(Integer.parseInt(price[i]));
			this.orderService.insertDetail(order);
		}
		
		//�⺻ ������� ���� �������� �� DB�� ������Ʈ
		if(deliveryAddrVal.equals("true") || defaultDeliveryAddrVal.equals("true")) {
			MemberVO member = new MemberVO();
			member.setZipcode(zipcode);
			member.setAddress1(address1);
			member.setAddress2(address2);
			member.setEmail(email);
			this.memberService.defaultAddrUpdate(member);
		}

		//�ֹ� �Ϸ� �� īƮ���� �ش� īƮ��ȣ ����
		//�ٷ� ���� �ÿ��� īƮ ��ȣ�� ����
		if(cartNo.length != 0) {
			for(int i=0; i < cartNo.length; i++) {
				this.cartService.delete(email, cartNo[i]);
			}
		}
		
		return "orderComplete";
	}
	
	@RequestMapping(value="/myOrder/{email}", method=RequestMethod.GET)
	@ResponseBody
	public Map select(@PathVariable String email) {
		List<OrderVO> list=this.orderService.select(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
	
	//��ǰ �ϳ� Ŭ���ÿ� ���� �ѷ��ֱ�
	@RequestMapping(value="/OrderAll/{email}", method=RequestMethod.GET)
	@ResponseBody
	public Map selectAll(@PathVariable String email) {
		List<OrderVO> list=this.orderService.selectAll(email);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("code", Boolean.TRUE);
		result.put("data", list);
		return result;
	}
}
