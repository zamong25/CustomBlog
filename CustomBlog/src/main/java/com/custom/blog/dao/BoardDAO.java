package com.custom.blog.dao;

import java.util.List;

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

	@Override
	public List<Board> selectRecentBoard() {
		
		List<Board> list = null;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			list = mapper.selectRecentBoard();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public Board selectOne(int boardnum) {
	
		Board board = null;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			board = mapper.selectOne(boardnum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return board;
	}

	@Override
	public int updateBoard(Board board) {
		
		int result = 0;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			result = mapper.updateBoard(board);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

	@Override
	public int deleteBoard(int boardNum) {
		
		int result = 0;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			result = mapper.deleteBoard(boardNum);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
		
	}

	@Override
	public List<Board> selectBoardByMenu(String menu_name) {
		
		List<Board> list = null;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			list = mapper.selectBoardByMenu(menu_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

}
