package com.custom.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.custom.blog.service.MenuService;
import com.custom.blog.vo.Menu;

@Controller
public class MenuController {
	
	@Autowired
	private MenuService service;
	
	// the form to input data
	@RequestMapping(value="/menu/create", method=RequestMethod.GET)
	public String createMenuForm() {
		return "menu/create"; // name of jsp file
	}
	
	// send data to database
	@RequestMapping(value="/menu/create", method=RequestMethod.POST)
	public String createMenuForm(Menu menu) {
		return service.createMenu(menu); // send user to specific path
	}
}
