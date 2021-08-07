package com.custom.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.custom.blog.service.BoardService;
import com.custom.blog.service.MenuService;
import com.custom.blog.vo.Board;
import com.custom.blog.vo.Menu;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MenuService menuService;
	
	@RequestMapping(value="/board/create", method=RequestMethod.GET)
	public String createBoardForm(Model model) {
		List<Menu> menus = menuService.selectAllMenu();
		
		model.addAttribute("menus", menus);
		return "board/create";
	}
	
	@RequestMapping(value="/board/create", method=RequestMethod.POST)
	public String createBoardForm(Board board, MultipartFile upload) {
		return boardService.createBoard(board, upload);
	}
	
}
