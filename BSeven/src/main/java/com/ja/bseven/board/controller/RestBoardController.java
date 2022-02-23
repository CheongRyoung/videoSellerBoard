package com.ja.bseven.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ja.bseven.board.service.BoardService;
import com.ja.bseven.board.util.FolderCreater;
import com.ja.bseven.member.mapper.MemberSQLMapper;
import com.ja.bseven.member.service.MemberService;
import com.ja.bseven.vo.ChatRoomVo;
import com.ja.bseven.vo.CourseImage;
import com.ja.bseven.vo.CourseLectureDayVo;
import com.ja.bseven.vo.CourseVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.ReplyVo;

@ResponseBody
@Controller
@RequestMapping("/board/*")
public class RestBoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("refreshMain")
	public HashMap<String, Object> refreshMain(String category_name, String searchWord, int pageNum) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		ArrayList<HashMap<String, Object>> courseDataList = boardService.getCourseList(category_name, searchWord, pageNum);
		
		if(category_name != null ) {
			data.put("result", "main");
		} else {
			data.put("result", "category" + category_name);
		}

		data.put("courseDataList", courseDataList);
		return data;
	}
	
	@RequestMapping("reviewWriteBoardModal")
	public HashMap<String, Object> reviewWriteBoard(int course_no, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if(sessionUser == null) {
			data.put("result", "login Req");
			return data;
		}

		int member_no = sessionUser.getMember_no();
		OrderVo orderVo = new OrderVo();
		orderVo.setMember_no(member_no);
		orderVo.setCourse_no(course_no);
		HashMap<String, Object> courseData = memberService.getOrderCount(orderVo);
		
		data.put("courseData", courseData);
		return data;
	}
	
	@RequestMapping("insertReviewProcessModal")
	public HashMap<String, Object> insertReply(ReplyVo replyVo, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		replyVo.setMember_no(memberVo.getMember_no());
		boardService.insertReply(replyVo);
		
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("deleteReview")
	public HashMap<String, Object> deleteReview(int reply_no, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if(sessionUser == null) {
			data.put("result", "fail");
			return data;
		}
		// 검사 
		int check = boardService.checkReplyOwner(reply_no, sessionUser.getMember_no());
		if( check < 1) {
			data.put("result", "fail");
			return data;
		}
		boardService.deleteReply(reply_no);

		
		return data;
	}
	
	@RequestMapping("reviewRefresh")
	public HashMap<String, Object> reviewRefresh(int course_no, HttpSession session){
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if(sessionUser != null) {
			int reviewCount = boardService.getReviewCount(course_no, sessionUser.getMember_no());
			int orderCount = memberService.getOrderCheck(course_no, sessionUser.getMember_no());
			if(reviewCount > 0 || orderCount == 0) {
				data.put("result", "existence");
				data.put("sessionUser", sessionUser.getMember_no());
			}
		} else {
			data.put("result", "existence");
		}
		
		HashMap<String, Object> courseData = boardService.getCourseInfo(course_no);
		data.put("courseData", courseData);

		return data;
	}

	@RequestMapping("updateReviewModal")
	public HashMap<String, Object> updateReviewModal(int reply_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		ReplyVo replyVo = boardService.getReplyVoByReplyNo(reply_no);
		data.put("replyVo", replyVo);
		
		return data;
	}
	
	@RequestMapping("updateReview")
	public HashMap<String, Object> updateReview(ReplyVo replyVo){
		HashMap<String, Object> data = new HashMap<String, Object>();
		boardService.updateReview(replyVo);
		data.put("result", "success");
		return data;
	}
	
	@RequestMapping("getCourseChartData")
	public HashMap<String, Object> getCourseChartData(int course_no){
		HashMap<String, Object> data = new HashMap<String, Object>();
		data.put("chartData", boardService.getChartData(course_no));
		
		return data;
	}
	
	@RequestMapping("offCourseUploadProcess")
	public HashMap<String, Object> offCourseUploadProcess(
			CourseVo courseVo, 
			int[] category_no, 
			MultipartFile[] thumbnail,
			String[] lectureDay_title,
			@DateTimeFormat(pattern = "yyyy-MM-dd")
			Date[] lectureDay_date,
			String[] lectureDay_hhmm,
			HttpSession session) {
		
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		
		List<CourseImage> imageList = new ArrayList<CourseImage>();
		for(MultipartFile img : thumbnail) {
			UUID uuid = UUID.randomUUID();
			String ext = img.getOriginalFilename().substring(img.getOriginalFilename().lastIndexOf("."));
			String urlName = FolderCreater.getCreateFolder() + uuid.toString() + "_" + System.currentTimeMillis() + ext;
			CourseImage corseImage = new CourseImage(0, 0, urlName, img.getOriginalFilename());
			imageList.add(corseImage);
			try {
				img.transferTo(new File(FolderCreater.uploadfolder + urlName));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		List<CourseLectureDayVo> courseLectureDayVoList = new ArrayList<CourseLectureDayVo>();
		for(int i=0; i<lectureDay_title.length; i++) {
			CourseLectureDayVo courseLectureDayVo = new CourseLectureDayVo(0, 0, lectureDay_title[i], lectureDay_date[i], lectureDay_hhmm[i]);
			courseLectureDayVoList.add(courseLectureDayVo);
		}

		boardService.offCourseUploadProcess(courseVo, courseLectureDayVoList, category_no, imageList, sessionUser.getMember_no());
		data.put("result", "success");
		
		return data;
	}
	
	@RequestMapping("insertChatRoom")
	public HashMap<String, Object> insertChatRoom(MultipartFile room_img, String room_name, HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		ChatRoomVo chatRoomVo = new ChatRoomVo();
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if(room_img != null) {
			UUID uuid = UUID.randomUUID();
			String imgURL = uuid.toString() + "_" + room_img.getOriginalFilename() + "_" + System.currentTimeMillis();
			String ext = room_img.getOriginalFilename().substring(room_img.getOriginalFilename().lastIndexOf("."));
			imgURL = imgURL + ext;
			
			try {
				room_img.transferTo(new File(FolderCreater.uploadfolder + FolderCreater.getCreateFolder() + imgURL));
			} catch (Exception e) {
				e.printStackTrace();
			}
			chatRoomVo.setRoom_img(FolderCreater.getCreateFolder() + imgURL);
		}
		chatRoomVo.setRoom_name(room_name);
		chatRoomVo.setMember_no(sessionUser.getMember_no());
		boardService.insertChatRoom(chatRoomVo);
		return data;
	}
	
	@RequestMapping("getChatRoom")
	public HashMap<String, Object> getChatRoom() {
		HashMap<String, Object> data = new HashMap<String, Object>();
		ArrayList<HashMap<String, Object>> arrayList= boardService.getChatRoom();
		data.put("chatRoomList", arrayList);
		return data;
	}
}
