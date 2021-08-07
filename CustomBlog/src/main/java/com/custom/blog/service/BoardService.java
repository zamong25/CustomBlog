package com.custom.blog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import com.custom.blog.dao.BoardDAO;
import com.custom.blog.vo.Board;
import com.custom.blog.util.FileService;

@Service
public class BoardService {
	
	@Autowired
	private BoardDAO dao;
	
	private final String uploadPath = "/boardUploads";
//	private final String uploadPath = "/Users/uzzing/blog/boardFiles";
	
	public String createBoard(Board board, MultipartFile upload) {
		
		if (!upload.isEmpty()) {
			String originalFile = upload.getOriginalFilename();
			String savedFile = FileService.saveFile(upload, uploadPath);
			board.setOriginalfile(originalFile);
			board.setSavedfile(savedFile);
		}
		
		
		int result = dao.insertBoard(board);
		
		String path = "";
		
		if (result > 0) path = "redirect:/";
		else path = "redirect:/board/create";
		
		return path;
	}

}
