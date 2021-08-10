package com.custom.blog.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.custom.blog.vo.Reply;

@Repository
public class ReplyDAO implements ReplyMapper {
	
	@Autowired
	private SqlSession session;
	
	
	@Override
	public int insertReply(Reply reply) {
		
		int result = 0;
		
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			result = mapper.insertReply(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public List<Reply> selectReplyByBoard(int boardnum) {
		
		List<Reply> list = null;
		
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			list = mapper.selectReplyByBoard(boardnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Reply selectOneReply(int replynum) {
		
		Reply reply = null;
		
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			reply = mapper.selectOneReply(replynum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return reply;
	}

	@Override
	public int updateReply(Reply reply) {
		
		int result = 0;
		
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			result = mapper.updateReply(reply);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public int deleteReply(int replynum) {
		
		int result = 0;
		
		try {
			ReplyMapper mapper = session.getMapper(ReplyMapper.class);
			result = mapper.deleteReply(replynum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
