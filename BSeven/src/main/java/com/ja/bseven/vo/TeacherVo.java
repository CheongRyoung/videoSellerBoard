package com.ja.bseven.vo;

public class TeacherVo {

	private int teacher_no;
	private int member_no;
	private String introduction;
	
	public TeacherVo() {
		super();
	}

	public TeacherVo(int teacher_no, int member_no, String introduction) {
		super();
		this.teacher_no = teacher_no;
		this.member_no = member_no;
		this.introduction = introduction;
	}

	public int getTeacher_no() {
		return teacher_no;
	}

	public void setTeacher_no(int teacher_no) {
		this.teacher_no = teacher_no;
	}

	public int getMember_no() {
		return member_no;
	}

	public void setMember_no(int member_no) {
		this.member_no = member_no;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}
	
	
}
