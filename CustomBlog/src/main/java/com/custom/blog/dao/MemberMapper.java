package com.custom.blog.dao;

import com.custom.blog.vo.Member;

public interface MemberMapper {

	public Member selectMember(String userid);
}
