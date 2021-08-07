package com.custom.blog.dao;

import java.util.List;

import com.custom.blog.vo.Menu;

public interface MenuMapper {
	public int insertMenu(Menu menu);
	public List<Menu> selectAllMenu();
//	public int deleteMenu(int menu_id);
//	public int updateMenu(Menu menu);
}
