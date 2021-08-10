package com.custom.blog.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.custom.blog.vo.Member;

@Repository
public class MemberDAO implements MemberMapper {

	@Autowired
	private SqlSession session;
	
	@Override
	public Member selectMember(String userid) {

		Member member = null;
		
		try {
			MemberMapper mapper = session.getMapper(MemberMapper.class);
			member = mapper.selectMember(userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return member;
	}

}
