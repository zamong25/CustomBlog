package com.custom.blog.dao;

import java.util.HashMap;
import java.util.List;

import com.custom.blog.vo.Board;

public interface BoardMapper {
	public int insertBoard(Board board);
	public List<Board> selectRecentBoard();
	public Board selectOne(int boardnum);
	public int updateBoard(Board board);
	public int deleteBoard(int boardNum);
	
	public List<Board> selectBoardByMenu(String menu_name);
	
//	public List<Board> selectBoard(HashMap<String, String> search);
}
