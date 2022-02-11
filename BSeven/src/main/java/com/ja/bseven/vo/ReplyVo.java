package com.ja.bseven.vo;

import java.util.Date;

public class ReplyVo {

	private int reply_no;
	private int course_no;
	private int member_no;
	private int reply_star;
	private String reply_text;
	private Date reply_date;
	
	public ReplyVo() {
		super();
	}

	public ReplyVo(int reply_no, int course_no, int member_no, int reply_star, String reply_text, Date reply_date) {
		super();
		this.reply_no = reply_no;
		this.course_no = course_no;
		this.member_no = member_no;
		this.reply_star = reply_star;
		this.reply_text = reply_text;
		this.reply_date = reply_date;
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getReply_star() {
		return reply_star;
	}

	public void setReply_star(int reply_star) {
		this.reply_star = reply_star;
	}

	public String getReply_text() {
		return reply_text;
	}

	public void setReply_text(String reply_text) {
		this.reply_text = reply_text;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	
	
}
