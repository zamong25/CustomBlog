package com.custom.blog.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.custom.blog.vo.Board;

@Repository
public class BoardDAO {
	
	@Autowired
	private SqlSession session;

	
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

	
	public List<Board> selectRecentBoard(HashMap<String, String> search) {
		
		List<Board> list = null;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			list = mapper.selectRecentBoard(search);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
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

	
	public List<Board> selectBoardByMenu(HashMap<String, String> search, int startRecord,int countPerPage) {

		
		List<Board> list = null;
		RowBounds rb = null;
		
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			
			if (startRecord != 0 || countPerPage != 0) {
				rb = new RowBounds(startRecord, countPerPage);
			}
			
			list = mapper.selectBoardByMenu(search, rb);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
	public int selectTotalCount(HashMap<String, String> paramMap) {
		
		int totalCount = 0;
		try {
			BoardMapper mapper = session.getMapper(BoardMapper.class);
			totalCount = mapper.selectTotalCount(paramMap);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return totalCount;
	}

}
