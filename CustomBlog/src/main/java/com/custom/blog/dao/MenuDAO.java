package com.custom.blog.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.custom.blog.vo.MenuVO;

@Repository
public class MenuDAO implements MenuMapper {

	@Autowired
	private SqlSession session;

	@Override
	public int insertMenu(MenuVO menu) {
		
		int cnt = 0;
		
		try {
			MenuMapper mapper = session.getMapper(MenuMapper.class);
			cnt = mapper.insertMenu(menu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public int updateMenu(MenuVO menu) {
		
		int cnt = 0;
		
		try {
			MenuMapper mapper = session.getMapper(MenuMapper.class);
			cnt = mapper.updateMenu(menu);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}

	@Override
	public List<MenuVO> selectAllMenu() {
		
		List<MenuVO> list = null;
		
		try {
			MenuMapper mapper = session.getMapper(MenuMapper.class);
			list = mapper.selectAllMenu();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}

	@Override
	public int deleteMenu(int menu_id) {
		
		int cnt = 0;
		
		try {
			MenuMapper mapper = session.getMapper(MenuMapper.class);
			cnt = mapper.deleteMenu(menu_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return cnt;
	}
	
	
}
