package com.ja.bseven.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ja.bseven.member.service.MemberService;
import com.ja.bseven.vo.CartVo;
import com.ja.bseven.vo.CourseVideo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.WishlistVo;

@RestController
@RequestMapping("/member/*")
public class RestMemberController {
	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("addWishlistProcess")
	public HashMap<String, Object> addWishlistProcess(int course_no, HttpSession session) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		WishlistVo wishlistVo = new WishlistVo();
		wishlistVo.setCourse_no(course_no);

		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		
		if (sessionUser == null) {
			map.put("loginReq", true);
			return map;
		}
		wishlistVo.setMember_no(sessionUser.getMember_no());
		boolean checkWish = memberService.checkWishlistVo(wishlistVo);
		map.put("checkWish", checkWish);
		return map;
	}
	
	@RequestMapping("getCourseVideo")
	public HashMap<String, Object> getCourseVideo(int course_no){
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		ArrayList<CourseVideo> videoList = memberService.getCourseVideo(course_no);
		map.put("videoList", videoList);
		
		return map;
	}
	
	@RequestMapping("addCartProcess")
	public HashMap<String, Object> addCartProcess(int course_no, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		
		CartVo cartVo = new CartVo();
		cartVo.setCourse_no(course_no);
		
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		cartVo.setMember_no(memberVo.getMember_no());
		
		memberService.insertCartVo(cartVo);
		return map;
	}
	
	@RequestMapping("deleteCartProcess")
	public HashMap<String, Object> deleteCartProcess(int[] cart_no, HttpSession session) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		for(int a : cart_no) {
			memberService.deleteCartVo(a);
		}
		
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		ArrayList<HashMap<String, Object>> CartDataList = memberService.getCartDataList(member_no);
		map.put("CartDataList", CartDataList);
		
		System.out.println("장바구니 삭제 완료");
		
		return map;
	}
	
	@RequestMapping("refreshCart")
	public HashMap<String, Object> refreshCart(HttpSession session) {
		HashMap<String, Object> data = new HashMap<String, Object>();
		
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		ArrayList<HashMap<String, Object>> CartDataList = memberService.getCartDataList(member_no);
		if (CartDataList.isEmpty()) {
			data.put("result", "Empty");
		} else {
			data.put("CartDataList", CartDataList);
		}

		return data;
	}
	
}