package com.ja.bseven.vo;

public class CourseCategory {

	private int course_category_no;
	private int course_no;
	private int category_no;
	
	public CourseCategory() {
		super();
	}

	public CourseCategory(int course_category_no, int course_no, int category_no) {
		super();
		this.course_category_no = course_category_no;
		this.course_no = course_no;
		this.category_no = category_no;
	}

	public int getCourse_category_no() {
		return course_category_no;
	}

	public void setCourse_category_no(int course_category_no) {
		this.course_category_no = course_category_no;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public int getCategory_no() {
		return category_no;
	}

	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	
	
}
