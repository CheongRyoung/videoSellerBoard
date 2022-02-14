package com.ja.bseven.board.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ja.bseven.vo.CategoryListVo;
import com.ja.bseven.vo.CourseCategory;
import com.ja.bseven.vo.CourseImage;
import com.ja.bseven.vo.CourseVideo;
import com.ja.bseven.vo.CourseVo;
import com.ja.bseven.vo.ReplyVo;

public interface BoardSQLMapper {

	//카테고리 가져오기
	public ArrayList<CategoryListVo> getCategoryList();
	public CategoryListVo getCategory(int category_no);
	
	// 강의 넘버 생성
	public int getCourseNum();
	
	// 강의 정보 insert
	public void insertCourseInfo(CourseVo courseVo);
	
	// 강의 카테고리 insert
	public void insertCourseCategory(CourseCategory courseCategory);
	public void deleteCourseCategory(int course_no);
	
	// 강의번호와 매칭되는 카테고리 가져오기
	public ArrayList<CourseCategory> getCourseCategoryList(int course_no);
	
	// 강의 이미지 insert
	public void insertCourseImage(CourseImage courseImage);
	public ArrayList<CourseImage> getCourseImageList(int course_no);
	public void deleteCourseImage(int course_no);
	
	// 강의 동영상 insert
	public void insertCourseVideo(CourseVideo courseVideo);
	public ArrayList<CourseVideo> getCourseVideo(int course_no);
	public void deleteCourseVideo(int course_no);
	
	
	// 강의 정보 단일 가져오기
	public CourseVo getCourseInfo(int course_no);
	
	// 강의 정보 리스트 가져오기
	public ArrayList<CourseVo> getCourseInfoList(
			@Param("category_name") String category_name,
			@Param("searchWord") String searchWord,
			@Param("pageNum") int pageNum
			);
	// 배너용 강의정보 리스트
	public ArrayList<CourseVo> getCourseInfoListBanner();
	
	// 강의 정보 리스트 가져오기 티처넘버로
	public ArrayList<CourseVo> getCourseInfoListByteacher(int teacher_no);
	
	// 강의 정보 삭제
	public void deleteCourse(int course_no);
	
	// 리플 저장
	public void insertReply(ReplyVo replyVo);
	public ArrayList<ReplyVo> getReplyListByCourseNo(int course_no);
	public int getReviewCount(
			@Param("course_no") int course_no, 
			@Param("member_no") int member_no);
	public int checkReplyOwner(
			@Param("reply_no") int reply_no, 
			@Param("member_no") int member_no);
	public void deleteReply(int reply_no);
	public ReplyVo getReplyVoByReplyNo(int reply_no);
	public void updateReview(ReplyVo replyVo);
	public ReplyVo getReplyVoByMemNoCourseNo(
			@Param("course_no") int course_no,
			@Param("member_no") int member_no
			);
	
	// chart
	public ArrayList<HashMap<String, Object>> getChartOrderByGenderM(int course_no);
	public ArrayList<HashMap<String, Object>> getChartOrderByGenderF(int course_no);
}
