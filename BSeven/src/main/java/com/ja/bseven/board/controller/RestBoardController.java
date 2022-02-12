package com.ja.bseven.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.bseven.board.service.BoardService;
import com.ja.bseven.member.mapper.MemberSQLMapper;
import com.ja.bseven.member.service.MemberService;
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
		int reviewCount = 0;
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		OrderVo orderVo = new OrderVo();
		if ( sessionUser != null ) {
			data.put("login", true);
			data.put("sessionUser", sessionUser.getMember_no());
			reviewCount = boardService.getReviewCount(course_no, sessionUser.getMember_no());
			orderVo.setCourse_no(course_no);
			orderVo.setMember_no(sessionUser.getMember_no());
			HashMap<String, Object> orderData = memberService.getOrderCount(orderVo);
			if ( orderData == null || reviewCount > 0) {
				data.put("result", "existence");
			} else {
				data.put("result", "success");
			}
		} else {
			data.put("result", "existence");
			data.put("sessionUser", 0);
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
}
