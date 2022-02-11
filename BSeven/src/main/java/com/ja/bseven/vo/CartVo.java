package com.ja.bseven.vo;

public class CartVo {

	private int cart_no;
	private int member_no;
	private int course_no;
	
	public CartVo() {
		super();
	}

	public CartVo(int cart_no, int member_no, int course_no) {
		super();
		this.cart_no = cart_no;
		this.member_no = member_no;
		this.course_no = course_no;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}
	
	
}
