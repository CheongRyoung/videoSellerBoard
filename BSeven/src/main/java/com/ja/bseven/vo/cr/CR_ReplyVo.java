package com.ja.bseven.vo.cr;

import java.util.Date;

public class CR_ReplyVo {
		
	private int reply_no;
	private int board_no;
	private int member_no;
	private String reply_content;
	private Date reply_date;
	
	public CR_ReplyVo() {
		super();
	}

	public CR_ReplyVo(int reply_no, int board_no, int member_no, String reply_content, Date reply_date) {
		super();
		this.reply_no = reply_no;
		this.board_no = board_no;
		this.member_no = member_no;
		this.reply_content = reply_content;
		this.reply_date = reply_date;
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	
	

}