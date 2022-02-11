package com.ja.bseven.vo;

public class WishlistVo {

	private int wishlist_no;
	private int member_no;
	private int course_no;
	
	public WishlistVo() {
		super();
	}

	public WishlistVo(int wishlist_no, int member_no, int course_no) {
		super();
		this.wishlist_no = wishlist_no;
		this.member_no = member_no;
		this.course_no = course_no;
	}

	public int getWishlist_no() {
		return wishlist_no;
	}

	public void setWishlist_no(int wishlist_no) {
		this.wishlist_no = wishlist_no;
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
