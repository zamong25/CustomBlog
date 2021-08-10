package com.custom.blog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.custom.blog.dao.ReplyDAO;
import com.custom.blog.vo.Reply;

@Service
public class ReplyService {

	@Autowired
	private ReplyDAO dao;
	
	public int insertReply(Reply reply) {
		return dao.insertReply(reply);
	}
	
	public List<Reply> selectReplyByBoard(int boardnum) {
		return dao.selectReplyByBoard(boardnum);
	}
	
	public Reply selectOneReply(int replynum) {
		return dao.selectOneReply(replynum);
	}
	
	public int updateReply(Reply reply) {
		return dao.updateReply(reply);
	}
	
	public int deleteReply(int replynum) {
		return dao.deleteReply(replynum);
	}
}
