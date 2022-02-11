package com.ja.bseven.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.bseven.board.mapper.BoardSQLMapper;
import com.ja.bseven.member.mapper.MemberSQLMapper;
import com.ja.bseven.vo.CategoryListVo;
import com.ja.bseven.vo.CourseCategory;
import com.ja.bseven.vo.CourseImage;
import com.ja.bseven.vo.CourseVideo;
import com.ja.bseven.vo.CourseVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.ReplyVo;

@Service
public class BoardService {
	
	@Autowired
	private BoardSQLMapper boardSQLMapper;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	public ArrayList<CategoryListVo> getCategoryList(){
		 ArrayList<CategoryListVo> categoryList = boardSQLMapper.getCategoryList();
		
		return categoryList;
	}
	
	public void insertCategory(
			CourseVo courseVo,
			int[] category_nos,
			ArrayList<CourseImage> courseImages,
			ArrayList<CourseVideo> courseVideos,
			int member_no) {
		
		int course_no = boardSQLMapper.getCourseNum();
		
		//강의 정보 등록
		int teacher_no = memberSQLMapper.getTeacherNoByMemberno(member_no);
		courseVo.setTeacher_no(teacher_no);
		courseVo.setCourse_no(course_no);
		boardSQLMapper.insertCourseInfo(courseVo);
		
		//강의 카테고리 등록
		for (int category_no : category_nos) {
			CourseCategory courseCategory = new CourseCategory();
			courseCategory.setCategory_no(category_no);
			courseCategory.setCourse_no(course_no);
			boardSQLMapper.insertCourseCategory(courseCategory);
		}
		
		// 강의 이미지 등록
		for (CourseImage courseImage : courseImages) {
			courseImage.setCourse_no(course_no);
			boardSQLMapper.insertCourseImage(courseImage);
		}
		
		// 강의 영상 등록
		for (CourseVideo courseVideo : courseVideos) {
			courseVideo.setCourse_no(course_no);
			boardSQLMapper.insertCourseVideo(courseVideo);
		}
		
	}
	
	// 강의 삭제 유효성 검사
	public boolean deleteCourse(int course_no) {
		ArrayList<OrderVo> orderListByCourse_no = memberSQLMapper.getOrderListByCourse_no(course_no);
		CourseVo courseVo = boardSQLMapper.getCourseInfo(course_no);
		
		boolean check = true;
		for(OrderVo orderVo : orderListByCourse_no) {
			Date orderDate = orderVo.getOrder_date();
			long expire = orderDate.getTime() + (courseVo.getCourse_period() *24*60*60*1000);
			long now = System.currentTimeMillis();
			if (expire > now) {
				check = false;
				break;
			}
		}
		if(check) {
			boardSQLMapper.deleteCourse(course_no);
			ArrayList<CourseImage> imageList = boardSQLMapper.getCourseImageList(course_no);
			for(CourseImage courseImage : imageList) {
				String imageUrl = courseImage.getCourse_image_url();
				File file = new File("C:/uploadFolder2/" + imageUrl) ;
				if(file.exists()) {
					file.delete();
				}
			}
			boardSQLMapper.deleteCourseImage(course_no);
			ArrayList<CourseVideo> videoList = boardSQLMapper.getCourseVideo(course_no);
			for(CourseVideo courseVideo : videoList) {
				String videoUrl = courseVideo.getCourse_video_url();
				File file = new File("C:/uploadFolder2/" + videoUrl) ;
				if(file.exists()) {
					file.delete();
				}
			}
			boardSQLMapper.deleteCourseVideo(course_no);
			boardSQLMapper.deleteCourseCategory(course_no);
		}
		return check;		
	}
	
	
	// 강의 정보 가져오기
	public HashMap<String, Object> getCourseInfo(int course_no) {
		HashMap<String, Object> courseData = new HashMap<String, Object>();
		courseData.put("courseVo", boardSQLMapper.getCourseInfo(course_no));
		
		int teacher_no = boardSQLMapper.getCourseInfo(course_no).getTeacher_no();
		String teacher_name = memberSQLMapper.getTeacherName(teacher_no).getMember_nickname();
		courseData.put("teacher_name", teacher_name);
		
		ArrayList<CourseImage> courseImageList = boardSQLMapper.getCourseImageList(course_no);
		courseData.put("image", courseImageList.get(0).getCourse_image_url());
		
		ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(course_no);
		ArrayList<String> categoryName = new ArrayList<String>();
		for (CourseCategory courseCategory : courseCategoryList) {
			categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
			
		}
		courseData.put("categoryName", categoryName);
		
		ArrayList<HashMap<String, Object>> replyDataList = new ArrayList<HashMap<String,Object>>();
		ArrayList<ReplyVo> replyList =  boardSQLMapper.getReplyListByCourseNo(course_no);
		for (ReplyVo replyVo : replyList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(replyVo.getMember_no());
			map.put("replyVo", replyVo);
			map.put("memberVo", memberVo);
			replyDataList.add(map);
		}
		courseData.put("replyDataList", replyDataList);
		
		return courseData;
	}
	
	public ArrayList<HashMap<String, Object>> getCourseList(String category_name, String searchWord, int pageNum) {

		ArrayList<HashMap<String, Object>> courseDataList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<CourseVo> courseVoList = boardSQLMapper.getCourseInfoList(category_name, searchWord, pageNum);
		
		for (CourseVo courseVo : courseVoList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			int course_no = courseVo.getCourse_no();

			ArrayList<CourseImage> courseImageList = boardSQLMapper.getCourseImageList(course_no);
			CourseImage courseImage = courseImageList.get(0);	
			String imagefirst = courseImage.getCourse_image_url();
			
			int wishCount = memberSQLMapper.countWishlistVo(course_no);
			
			map.put("wishCount", wishCount);
			map.put("imagefirst", imagefirst);
			map.put("courseVo", courseVo);
			
			courseDataList.add(map);
		}
		
		return courseDataList;

	}
	
	public ArrayList<String> mainBannerImageList() {
		
		ArrayList<CourseVo> courseVoList = boardSQLMapper.getCourseInfoListBanner();
		
		ArrayList<String> imgUrl = new ArrayList<String>();
		
		for (int i=0; i<3; i++) {
			int course_no = courseVoList.get(i).getCourse_no();
			ArrayList<CourseImage> courseImageList = boardSQLMapper.getCourseImageList(course_no);
			CourseImage courseImage = courseImageList.get(0);
			imgUrl.add(courseImage.getCourse_image_url());
		}
		
		return imgUrl;	
	}
	
	public void insertReply(ReplyVo replyVo) {
		boardSQLMapper.insertReply(replyVo);
	}
	
	public int getReviewCount(int course_no, int member_no) {
		return boardSQLMapper.getReviewCount(course_no, member_no);
	}
	
	public int checkReplyOwner(int reply_no, int member_no) {
		return boardSQLMapper.checkReplyOwner(reply_no, member_no);
	}
	
	public void deleteReply(int reply_no) {
		boardSQLMapper.deleteReply(reply_no);
	}
	public ReplyVo getReplyVoByReplyNo(int reply_no) {
		return boardSQLMapper.getReplyVoByReplyNo(reply_no);
	}
	public void updateReview(ReplyVo replyVo) {
		boardSQLMapper.updateReview(replyVo);
	}
}
