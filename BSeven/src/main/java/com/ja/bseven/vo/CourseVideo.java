package com.ja.bseven.vo;

public class CourseVideo {

	private int course_video_no;
	private int course_no;
	private String course_video_title;
	private String course_video_url;
	private String course_video_originalfilename;
	
	public CourseVideo() {
		super();
	}

	public CourseVideo(int course_video_no, int course_no, String course_video_title, String course_video_url,
			String course_video_originalfilename) {
		super();
		this.course_video_no = course_video_no;
		this.course_no = course_no;
		this.course_video_title = course_video_title;
		this.course_video_url = course_video_url;
		this.course_video_originalfilename = course_video_originalfilename;
	}

	public int getCourse_video_no() {
		return course_video_no;
	}

	public void setCourse_video_no(int course_video_no) {
		this.course_video_no = course_video_no;
	}

	public int getCourse_no() {
		return course_no;
	}

	public void setCourse_no(int course_no) {
		this.course_no = course_no;
	}

	public String getCourse_video_title() {
		return course_video_title;
	}

	public void setCourse_video_title(String course_video_title) {
		this.course_video_title = course_video_title;
	}

	public String getCourse_video_url() {
		return course_video_url;
	}

	public void setCourse_video_url(String course_video_url) {
		this.course_video_url = course_video_url;
	}

	public String getCourse_video_originalfilename() {
		return course_video_originalfilename;
	}

	public void setCourse_video_originalfilename(String course_video_originalfilename) {
		this.course_video_originalfilename = course_video_originalfilename;
	}
	
	
}
