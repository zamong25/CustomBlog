package com.custom.blog.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@RequestMapping(value="/createBoard", method=RequestMethod.GET)
	public String createBoardForm(Model model) {
		List<Menu> menus = menuService.selectAllMenu();
		model.addAttribute("menus", menus);
		return "board/writeBoard";
	}
	
	@RequestMapping(value="/createBoard", method=RequestMethod.POST)
	@ResponseBody
	public String createBoardForm(Board board) {
		return boardService.createBoard(board);
	}
	

	@RequestMapping(value="/readBoard", method=RequestMethod.GET)
	public String readBoard(@RequestParam int boardnum, Model model) {
		
		Board board = boardService.selectOne(boardnum);
		model.addAttribute("board", board);
		
		return "board/readBoard";
	}
	
	@RequestMapping("/download")
	public void fileDownload(int boardnum) {
		boardService.fileDownload(boardnum);
	}
	
	@RequestMapping("/updateBoard")
	public String updateBoard(@RequestParam int boardnum, Model model) {
		
		Board board = boardService.selectOne(boardnum);
		model.addAttribute("board", board);
		
		List<Menu> menus = menuService.selectAllMenu();
		model.addAttribute("menus", menus);
		
		return "board/writeBoard";
	}
	
	
	@RequestMapping(value="/updateBoard", method=RequestMethod.POST)
	@ResponseBody
	public String updateBoard(Board board) {
		System.out.print(board);
		return boardService.updateBoard(board);
	}
	
	@RequestMapping("/deleteBoard")
	@ResponseBody
	public String deleteBoard(int boardnum) {
		return boardService.deleteBoard(boardnum);
	}
	
	@RequestMapping("/selectBoardByMenu")
	@ResponseBody
	public List<Board> selectBoardByMenu(String menu_name) {
		List<Board> list = boardService.selectBoardByMenu(menu_name);
		System.out.println(list);
		return list;
	}
}
