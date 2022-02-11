package com.ja.bseven.vo.cr;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class CR_BoardVo {
	private int board_no;
	private int member_no;
	private String board_title;
	private String board_content;
	private int board_viewCount;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date board_date;
	
	public CR_BoardVo() {
		super();
	}

	public CR_BoardVo(int board_no, int member_no, String board_title, String board_content, int board_viewCount,
			Date board_date) {
		super();
		this.board_no = board_no;
		this.member_no = member_no;
		this.board_title = board_title;
		this.board_content = board_content;
		this.board_viewCount = board_viewCount;
		this.board_date = board_date;
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

	public String getBoard_title() {
		return board_title;
	}

	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}

	public String getBoard_content() {
		return board_content;
	}

	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}

	public int getBoard_viewCount() {
		return board_viewCount;
	}

	public void setBoard_viewCount(int board_viewCount) {
		this.board_viewCount = board_viewCount;
	}

	public Date getBoard_date() {
		return board_date;
	}

	public void setBoard_date(Date board_date) {
		this.board_date = board_date;
	}
	
	

}