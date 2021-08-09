package com.custom.blog;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.custom.blog.util.PageNavigator;

import com.custom.blog.service.BoardService;
import com.custom.blog.service.MenuService;
import com.custom.blog.vo.Board;
import com.custom.blog.vo.Menu;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	private MenuService menuService;
	
	@Autowired
	private BoardService boardService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		List<Menu> menuList = menuService.selectAllMenu();
		model.addAttribute(formattedDate);
		model.addAttribute("menuList", menuList);
		
		return "home";
	}
	
	@RequestMapping("/selectRecentBoard")
	@ResponseBody
	public List<Board> sendRecentBoardtoHome(@RequestParam(value="searchItem", defaultValue="title") String searchItem
			, @RequestParam(value="searchWord", defaultValue="") String searchWord) {

		List<Board> list = boardService.selectRecentBoard(searchItem, searchWord);

		return list;
	}
	
}
