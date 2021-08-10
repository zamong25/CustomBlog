package com.custom.blog.dao;

import java.util.List;

import com.custom.blog.vo.Reply;

public interface ReplyMapper {
	
	public int insertReply(Reply reply);
	public List<Reply> selectReplyByBoard(int boardnum);
	public Reply selectOneReply(int replynum);
	public int updateReply(Reply reply);
	public int deleteReply(int replynum);
	
}
