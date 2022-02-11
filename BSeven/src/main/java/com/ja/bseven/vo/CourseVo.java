package com.ja.bseven.vo;

import java.util.Date;

public class CourseVo {

	private int course_no;
	private int teacher_no;
	private String course_title;
	private int course_price;
	private int course_period;
	private String course_content;
	private int course_count;
	private Date course_date;
	
	public CourseVo() {
		super();
	}

	public CourseVo(int course_no, int teacher_no, String course_title, int course_price, int course_period,
			String course_content, int course_count, Date course_date) {
		super();
		this.course_no = course_no;
		this.teacher_no = teacher_no;
		this.course_title = course_title;
		this.course_price = course_price;
		this.course_period = course_period;
		this.course_content = course_content;
		this.course_count = course_count;
		this.course_date = course_date;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public int getTeacher_no() {
		return teacher_no;
	}

	public void setTeacher_no(int teacher_no) {
		this.teacher_no = teacher_no;
	}

	public String getCourse_title() {
		return course_title;
	}

	public void setCourse_title(String course_title) {
		this.course_title = course_title;
	}

	public int getCourse_price() {
		return course_price;
	}

	public void setCourse_price(int course_price) {
		this.course_price = course_price;
	}

	public int getCourse_period() {
		return course_period;
	}

	public void setCourse_period(int course_period) {
		this.course_period = course_period;
	}

	public String getCourse_content() {
		return course_content;
	}

	public void setCourse_content(String course_content) {
		this.course_content = course_content;
	}

	public int getCourse_count() {
		return course_count;
	}

	public void setCourse_count(int course_count) {
		this.course_count = course_count;
	}

	public Date getCourse_date() {
		return course_date;
	}

	public void setCourse_date(Date course_date) {
		this.course_date = course_date;
	}
	
	
}
