package com.custom.blog.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.custom.blog.service.ReplyService;
import com.custom.blog.vo.Reply;


@Controller
public class ReplyController {
	
	@Autowired
	ReplyService service;
	
	
	@RequestMapping(value="/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public void insertReply(Reply reply) {
		
		System.out.print(reply);

		service.insertReply(reply);
	}
	
	@RequestMapping("/selectReplyByBoard")
	@ResponseBody
	public List<Reply> selectReplyByBoard(@RequestParam(value="boardnum") int boardnum) {

		System.out.print("boardnum : " + boardnum);
		
		return service.selectReplyByBoard(boardnum);
	}
	
	
	@RequestMapping("/selectOneReply")
	@ResponseBody
	public Reply selectOneReply(int replynum) {
		
		return service.selectOneReply(replynum);
	}
	
	@RequestMapping(value="/updateReply", method=RequestMethod.POST)
	@ResponseBody
	public void updateReply(Reply reply) {
		service.updateReply(reply);
	}
	
	@RequestMapping("/deleteReply")
	@ResponseBody
	public String deleteReply(int replynum) {
		
		int result = service.deleteReply(replynum);
		
		if (result == 1) {
			return "Deleted successfully";
		}
		return "Failed to delete";
	}
	
}
