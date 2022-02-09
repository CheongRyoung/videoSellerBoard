package com.ja.bseven.vo;

import java.util.Date;

public class OrderVo {

	private int order_no;
	private int member_no;
	private int course_no;
	private Date order_date;
	private String order_refund_text;
	private Date order_refund_date;
	
	public OrderVo() {
		super();
	}

	public OrderVo(int order_no, int member_no, int course_no, Date order_date, String order_refund_text,
			Date order_refund_date) {
		super();
		this.order_no = order_no;
		this.member_no = member_no;
		this.course_no = course_no;
		this.order_date = order_date;
		this.order_refund_text = order_refund_text;
		this.order_refund_date = order_refund_date;
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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

	public Date getOrder_date() {
		return order_date;
	}

	public void setOrder_date(Date order_date) {
		this.order_date = order_date;
	}

	public String getOrder_refund_text() {
		return order_refund_text;
	}

	public void setOrder_refund_text(String order_refund_text) {
		this.order_refund_text = order_refund_text;
	}

	public Date getOrder_refund_date() {
		return order_refund_date;
	}

	public void setOrder_refund_date(Date order_refund_date) {
		this.order_refund_date = order_refund_date;
	}
	
	
}
