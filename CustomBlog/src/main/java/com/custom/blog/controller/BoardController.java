package com.custom.blog.controller;

import java.util.HashMap;
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

import com.custom.blog.util.PageNavigator;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MenuService menuService;
	
	// pagination
	private final int countPerPage = 3;
	private final int pagePerGroup = 3;
		
	
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
	public String readBoard(int boardnum, Model model) {
		
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
	
	// ajax 
	@RequestMapping("/deleteBoard")
	@ResponseBody
	public String deleteBoard(int boardnum) {
		return boardService.deleteBoard(boardnum);
	}
	
	// ajax
	@RequestMapping("/selectBoardByMenu")
	@ResponseBody
	public List<Board> selectBoardByMenu(String menu_name) {
		
		HashMap<String, String> init = new HashMap<String, String>();
		init.put("searchItem", "title");
		init.put("searchWord", "");
		init.put("menu_name", menu_name);
		
		List<Board> list = boardService.selectBoardByMenu(init);
		return list;
	}
	
	// model
	@RequestMapping("/listBoard")
	public String sendBoardByMenu(@RequestParam(value="menu") String menu
			, @RequestParam(value="currentPage", defaultValue="1") int currentPage
			, @RequestParam(value="searchItem", defaultValue="title") String searchItem
			, @RequestParam(value="searchWord", defaultValue="") String searchWord
			, Model model) {
		
		HashMap<String, String> search = new HashMap<String, String>();
		search.put("searchItem", searchItem);
		search.put("searchWord", searchWord);
		search.put("menu_name", menu);
		
		List<Board> list = boardService.selectBoardByMenu(search);
		int totalRecordCount = boardService.selectTotalCount(searchItem, searchWord);
		
		PageNavigator navi = new PageNavigator(countPerPage, pagePerGroup, currentPage, totalRecordCount);
		
		model.addAttribute("list", list);
		model.addAttribute("menu", menu);
		model.addAttribute("searchItem", searchItem);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("navi", navi);
		
		return "board/listBoard";
	}
	
}
