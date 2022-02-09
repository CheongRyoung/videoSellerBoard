package com.ja.bseven.vo.cr;

import java.util.Date;

public class CR_boardLikeVO {

	private int boardLike_no;
	private int board_no;
	private int member_no;
	private Date like_date;
	
	public CR_boardLikeVO() {
		super();
	}

	public CR_boardLikeVO(int boardLike_no, int board_no, int member_no, Date like_date) {
		super();
		this.boardLike_no = boardLike_no;
		this.board_no = board_no;
		this.member_no = member_no;
		this.like_date = like_date;
	}

	public int getBoardLike_no() {
		return boardLike_no;
	}

	public void setBoardLike_no(int boardLike_no) {
		this.boardLike_no = boardLike_no;
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

	public Date getLike_date() {
		return like_date;
	}

	public void setLike_date(Date like_date) {
		this.like_date = like_date;
	}
	
	
}
