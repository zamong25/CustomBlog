package com.custom.blog.service;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import com.custom.blog.dao.BoardDAO;
import com.custom.blog.vo.Board;
import com.custom.blog.util.FileService;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	@Autowired
	private HttpServletResponse response;
	
//	private final String uploadPath = "/boardUploads";
	private final String uploadPath = "/Users/uzzing/blog/boardFiles";
	
	public String createBoard(Board board) {
		
		MultipartFile file = board.getFile();
		
		if (!file.isEmpty()) {
			String savedFile = FileService.saveFile(file, uploadPath);
			board.setOriginalfile(file.getOriginalFilename());
			board.setSavedfile(savedFile);
		}
		
		int result = dao.insertBoard(board);
		
		String path = "";
		
		if (result > 0) path = "redirect:/";
		else path = "redirect:/createBoard";
		
		return path;
	}
	
	public List<Board> selectRecentBoard() {
		
		List<Board> list = dao.selectRecentBoard();
		return list;
	}
	
	
	public Board selectOne(int boardnum) {
		
		Board board = dao.selectOne(boardnum);
		return board;
	}
	
	public void fileDownload(int boardnum) {
		
		Board board = dao.selectOne(boardnum);
		
		String originalFileName = (String) board.getOriginalfile();
		
		try {
			response.setHeader("Content-Disposition", " attachment;filename="+ URLEncoder.encode(originalFileName, "UTF-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		String fullPath = uploadPath + "/" + ((String)board.getSavedfile());
		
		FileInputStream fileIn = null;
		ServletOutputStream fileOut = null;
		
		try {
			
			fileIn = new FileInputStream(fullPath);
			fileOut = response.getOutputStream();
			
			FileCopyUtils.copy(fileIn, fileOut);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(fileIn != null)
				try {
					fileIn.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			if(fileOut != null)
				try {
					fileOut.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
		}
	}
	
	public String updateBoard(Board board) {
		
		Board b = dao.selectOne(board.getBoardnum());
		System.out.print("in service" + b);
		
		String oldfile = b.getSavedfile();
		
		if (oldfile != null) {
			String fullPath = uploadPath + "/" + oldfile;
			boolean result = FileService.deleteFile(fullPath);
			if (result) System.out.println("파일 삭제 완료");
		}
		
		MultipartFile file = board.getFile();
		
		if (!file.isEmpty()) {
			String savedFilename = FileService.saveFile(file, uploadPath);
			
			board.setOriginalfile(file.getOriginalFilename());
			board.setSavedfile(savedFilename);
		}
		
		int result = dao.updateBoard(board);
		
		String path = "";
		
		if (result > 0) path = "redirect:/";
		else path = "redirect:/updateBoard?boardnum=" + board.getBoardnum();
		
		return path;
	}
	
	
	public String deleteBoard(int boardnum) {
		
		int result = dao.deleteBoard(boardnum);
		
		String path = "";
	
		if (result > 0) path = "redirect:/";
		else path = "redirect:/readBoard?boardnum=" + boardnum;
		
		return path;
	}
	
	public List<Board> selectBoardByMenu(String menu_name) {
		
		List<Board> list = dao.selectBoardByMenu(menu_name);
		return list;
	}

}
