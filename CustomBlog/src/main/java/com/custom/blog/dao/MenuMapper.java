package com.custom.blog.dao;

import java.util.List;

import com.custom.blog.vo.MenuVO;

public interface MenuMapper {
	public int insertMenu(MenuVO menu) throws Exception;
	public int updateMenu(MenuVO menu) throws Exception;
	public List<MenuVO> selectAllMenu() throws Exception;
	public int deleteMenu(int menu_id) throws Exception;
}
