package com.pcos.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.pcos.service.MemberService;
import com.pcos.vo.MemberVO;

@Controller
public class MemberController {
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("/favicon.ico")
    public String favicon() {
        return "forward:/resources/favicon.ico";
    }
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "redirect:/PCos";
	}
	
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String myPage() {
		return "mypage";
	}

	@RequestMapping(value = "/naverLogin", method = {RequestMethod.GET, RequestMethod.POST})
	public String goToNaverLoginPage() {
		return "naverlogin";
	}
	
	@RequestMapping(value = "/login", method = {RequestMethod.GET, RequestMethod.POST})
	public String goToLoginPage() {
		return "login";
	}

	@RequestMapping(value = "/logout", method = {RequestMethod.GET, RequestMethod.POST})
	public String goToLogoutPage() {
		return "logout";
	}
	
	@RequestMapping(value = "/memberRegStat/{email}", method = RequestMethod.POST)
	@ResponseBody
	public Map memberRegStat(@PathVariable String email) {
		Map<String, Object> result = new HashMap<String, Object>();
		int accCheck = this.memberService.accountCheck(email);

		if(email == null) {
			goToLoginPage();
		} else {
			if(accCheck != 0) { //기존 회원이면
				result.put("code", Boolean.TRUE);
			} else { //신규 회원이면
				result.put("code", Boolean.FALSE);
			}
		}
		return result;
	}
	
	@RequestMapping(value = "/loginComplete", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView loginAuth(String email) {
		ModelAndView mav = new ModelAndView();
		MemberVO member;
		int accCheck = 0;
		
		if(email == null) {
			goToLoginPage();
		} else {
			accCheck = this.memberService.accountCheck(email);
			
			if(accCheck != 0) { //테이블에 기존 회원이 존재한다면
				member = this.memberService.selectOne(email);
				mav.addObject("code", Boolean.TRUE);
				mav.addObject("data", member);
				mav.setViewName("loginComplete");
				
			} else { //신규 회원이면 가입 화면으로,
				mav.addObject("email", email);
	            mav.setViewName("personalInfo");
			}
		}

		return mav;
	}

   @RequestMapping(value = "/personalInfo", method = RequestMethod.POST)
   @ResponseBody
   public Map personalInfo(@RequestBody MemberVO member) {
      Map<String, Object> result = new HashMap<String, Object>();
      int accCheck = this.memberService.accountCheck(member.getEmail());
      
      if(accCheck!=0) {
    	  this.memberService.update(member);
    	  result.put("code", "update");
      }else {
    	  this.memberService.insert(member);
    	  result.put("code", "insert");
      }
      return result;
   }
   
   @RequestMapping(value = "/myInfo", method = RequestMethod.GET)
   public String myInfo() {
      return "personalInfo";
   }
   
   @RequestMapping(value = "/myInfo/{email}", method = RequestMethod.GET)
   @ResponseBody
   public Map myInfoConfirm(@PathVariable String email) {
	   Map<String, Object> result = new HashMap<String, Object>();
	   int accCheck = this.memberService.accountCheck(email);

		if(email == null) {
			goToLoginPage();
		} else {
		   if(accCheck == 0) {
			   result.put("code", Boolean.FALSE);
		   } else {
			   MemberVO member = this.memberService.selectOne(email);
			   result.put("code", Boolean.TRUE);
			   result.put("data", member);
		   }
		}
	   return result;
   }
   
   @RequestMapping(value="/mydetail/{which}",method=RequestMethod.GET)
   @ResponseBody
   public ModelAndView goToDetailPage(@PathVariable String which) {
      ModelAndView mav = new ModelAndView();
      mav.addObject("method", which);
      mav.setViewName("mydetail");
      return mav;
   }
}