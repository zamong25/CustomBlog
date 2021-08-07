package com.custom.blog.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.custom.blog.vo.Board;

@Repository
public class BoardDAO implements BoardMapper {
	
	@Autowired
	private SqlSession session;

	@Override
	public int insertBoard(Board board) {
		
		int result = 0;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			result = mapper.insertBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

}
