package com.custom.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.custom.blog.service.MemberService;
import com.custom.blog.vo.Member;

@Controller
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	// login.jsp
	@RequestMapping("/login")
	public String login() {
		return "/login";
	}
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String login(Member member) {
		return service.login(member);
	}
	
	@RequestMapping(value="/logout", method=RequestMethod.GET)
	public String logout() {
		return service.logout();
	}
}
