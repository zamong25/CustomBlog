package com.custom.blog.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.custom.blog.vo.Board;

public interface BoardMapper {
	public int insertBoard(Board board);
	public List<Board> selectRecentBoard(HashMap<String, String> search);
	public Board selectOne(int boardnum);
	public int updateBoard(Board board);
	public int deleteBoard(int boardNum);
	public List<Board> selectBoardByMenu(HashMap<String, String> search, RowBounds rb);
	public int selectTotalCount(HashMap<String, String> paramMap);
}
