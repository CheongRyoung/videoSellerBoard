package com.ja.bseven.vo.cr;

import java.util.Date;

public class CR_boardContentImageVo {
	private int bci_no;
	private int board_no;
	private int member_no;
	private String bci_uri;
	private String bci_originalName;
	private Date bci_date;
	
	public CR_boardContentImageVo() {
		super();
	}

	public CR_boardContentImageVo(int bci_no, int board_no, int member_no, String bci_uri, String bci_originalName,
			Date bci_date) {
		super();
		this.bci_no = bci_no;
		this.board_no = board_no;
		this.member_no = member_no;
		this.bci_uri = bci_uri;
		this.bci_originalName = bci_originalName;
		this.bci_date = bci_date;
	}

	public int getBci_no() {
		return bci_no;
	}

	public void setBci_no(int bci_no) {
		this.bci_no = bci_no;
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

	public String getBci_uri() {
		return bci_uri;
	}

	public void setBci_uri(String bci_uri) {
		this.bci_uri = bci_uri;
	}

	public String getBci_originalName() {
		return bci_originalName;
	}

	public void setBci_originalName(String bci_originalName) {
		this.bci_originalName = bci_originalName;
	}

	public Date getBci_date() {
		return bci_date;
	}

	public void setBci_date(Date bci_date) {
		this.bci_date = bci_date;
	}
	
	
}
