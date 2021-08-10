package com.custom.blog.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.custom.blog.dao.MemberDAO;
import com.custom.blog.vo.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberDAO dao;
	
	@Autowired
	private HttpSession session;
	
	public String login(Member inputData) {
		
		String path = "";
		
		Member searchData = dao.selectMember(inputData.getUserid());
		
		if (searchData == null) {
			path = "redirect:/login";
		}
		else {
			
			// check whether password is correct
			if (inputData.getUserpw().equals(searchData.getUserpw())) {
				session.setAttribute("loginId", searchData.getUserid());
				session.setAttribute("loginName", searchData.getUsername());
				path = "redirect:/";
			}
			else {
				path = "redirect:/login";
			}
		}
		
		return path;
	}
	
	public String logout() {
		session.removeAttribute("loginId");
		session.removeAttribute("loginName");
		
		return "redirect:/";
	}
}
