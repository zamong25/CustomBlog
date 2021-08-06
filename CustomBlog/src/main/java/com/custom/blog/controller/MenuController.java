package com.custom.blog.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.custom.blog.service.MenuService;

@Controller
public class MenuController {
	
	@Autowired
	private MenuService service;
	
	@RequestMapping(value = "/menu/create", method = RequestMethod.GET)
	public String createMenuForm() {
		return "menu/create"; // name of jsp file
	}
	
	@RequestMapping(value = "", method = RequestMethod.GET)
	public String updateAndDeleteMenuForm() {
		return "menu/update";
	}
}
