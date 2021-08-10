package com.custom.blog.vo;

import lombok.Data;

@Data
public class Reply {
	private int replynum;
	private int boardnum;
	private String userid;
	private String userpw;
	private String replytext;
	private String regdate;
}
