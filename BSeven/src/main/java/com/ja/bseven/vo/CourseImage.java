package com.ja.bseven.vo;

public class CourseImage {

	private int course_image_no;
	private int course_no;
	private String course_image_url;
	private String course_image_originalName;
	
	public CourseImage() {
		super();
	}

	public CourseImage(int course_image_no, int course_no, String course_image_url, String course_image_originalName) {
		super();
		this.course_image_no = course_image_no;
		this.course_no = course_no;
		this.course_image_url = course_image_url;
		this.course_image_originalName = course_image_originalName;
	}

	public int getCourse_image_no() {
		return course_image_no;
	}

	public void setCourse_image_no(int course_image_no) {
		this.course_image_no = course_image_no;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public String getCourse_image_url() {
		return course_image_url;
	}

	public void setCourse_image_url(String course_image_url) {
		this.course_image_url = course_image_url;
	}

	public String getCourse_image_originalName() {
		return course_image_originalName;
	}

	public void setCourse_image_originalName(String course_image_originalName) {
		this.course_image_originalName = course_image_originalName;
	}
	
	
}
