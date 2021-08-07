package com.custom.blog.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.custom.blog.dao.MenuDAO;
import com.custom.blog.vo.Menu;

@Service
public class MenuService {
	
	@Autowired
	private MenuDAO dao;
	
	
	// <-- methods -->
	public String createMenu(Menu menu) {
		
		int result = dao.insertMenu(menu);
		
		String path = "";
		
		if (result > 0) path = "redirect:/";
		else path = "/menu/create";
		
		return path;
	}
	
	public List<Menu> selectAllMenu() {
		
		List<Menu> list = new ArrayList<>();
		list = dao.selectAllMenu();
		
		return list;
	}
	
//	public String updateMenu(Menu menu) {
//		
//		int result = dao.updateMenu(menu);
//		
//		String path = "";
//		
//		if (result > 0) path = "redirect:/";
//		else path = "redirect:/menu/update";
//		
//		return path;
//	}
//	
//	public String deleteMenu(int menu_id) {
//		
//		int result = dao.deleteMenu(menu_id);
//		
//		String path = "";
//		
//		if (result > 0) path = "redirect:/";
//		else path = "redirect:/menu/update";
//		
//		return path;
//	}
	
}
