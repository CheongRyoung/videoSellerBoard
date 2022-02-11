package com.ja.bseven.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ja.bseven.member.service.MemberService;
import com.ja.bseven.vo.CartVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.TeacherVo;
import com.ja.bseven.vo.WishlistVo;


@Controller
@RequestMapping("/member/*")
public class MemberController {

	
	@Autowired
	private MemberService memberService;
	
	@RequestMapping("registerPage")
	public String loginPage() {
		
		System.out.println("시스템 로그 ] 로그인 페이지 실행 ");
		
		return "member/registerPage";
	}
	
	
	@RequestMapping("joinMemberPage")
	public String joinMemberPage(Model model) {
		
		System.out.println("시스템 로그 ] 회원가입 페이지 실행");
		
		return "member/joinMemberPage";
	}
	
	
	@RequestMapping("joinMemberProcess")
	public String joinMemberProcess(MemberVo param) {
		
		System.out.println("시스템 로그 ] 회원가입 프로세스 실행");
		System.out.println("시스템 로그 ] 파라미터 값 no : " + param.getMember_no());
		System.out.println("시스템 로그 ] 파라미터 값 ID : " + param.getMember_id());
		System.out.println("시스템 로그 ] 파라미터 값 PW : " + param.getMember_pw());
		System.out.println("시스템 로그 ] 파라미터 값 Nickname : " + param.getMember_nickname());
		System.out.println("시스템 로그 ] 파라미터 값 Gender : " + param.getMember_gender());
		System.out.println("시스템 로그 ] 파라미터 값 Birth : " + param.getMember_birth());
		System.out.println("시스템 로그 ] 파라미터 값 Phone : " + param.getMember_phone());
		System.out.println("시스템 로그 ] 파라미터 값 Email : " + param.getMember_email());
		
		memberService.joinMember(param);
		
		return "member/joinMemberComplete";
	}
	
	
	
	@RequestMapping("loginProcess")
	public String loginProcess(MemberVo param, HttpSession session, String page) {
		
		System.out.println("시스템 로그 ] 로그인 프로세스 실행");
				
		MemberVo sessionUser = memberService.login(param);
		
		if(sessionUser != null) {
			
			System.out.println("시스템 로그 ] 파라미터 값 ID : " + sessionUser.getMember_id());
			System.out.println("시스템 로그 ] 파라미터 값 PW : " + sessionUser.getMember_pw());
			System.out.println("시스템 로그 ] 파라미터 값 Nickname : " + sessionUser.getMember_nickname());
			System.out.println("시스템 로그 ] 파라미터 값 Gender : " + sessionUser.getMember_gender());
			System.out.println("시스템 로그 ] 파라미터 값 Birth : " + sessionUser.getMember_birth());
			System.out.println("시스템 로그 ] 파라미터 값 Phone : " + sessionUser.getMember_phone());
			System.out.println("시스템 로그 ] 파라미터 값 Email : " + sessionUser.getMember_email());
			
			// 인증 성공
			// 이 부분의 이해가 필요
			session.setAttribute("sessionUser", sessionUser);
			
			System.out.println("시스템 로그 ] 로그인 성공 프로세스 실행 종료");

			return "redirect:../"+page;
			
		}else{
			// 인증 실패
			
			System.out.println("시스템 로그 ] 로그인 실패 프로세스 실행 종료");
			
			return "member/loginFail";
		}
	}
	
	

	@RequestMapping("logoutProcess")
	public String logoutProcess(HttpSession session) {
		
		session.invalidate(); 	// 세션 저장 공간을 날리고 재구성
		
		System.out.println("시스템 로그 ] 로그아웃 프로세스 실행");
		
		return "redirect:../board/mainPage";
	}
	
	@RequestMapping("myPage")
	public String myPage(HttpSession session, Model model) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		
		if (sessionUser != null ) {
			MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
			boolean checkTeacher = memberService.getTeacherCheck(memberVo.getMember_no());
			if (checkTeacher) {
				model.addAttribute("checkTeacher", checkTeacher);
			}
			
			int member_no = sessionUser.getMember_no();
			// 구매한 강의 정보
			ArrayList<HashMap<String, Object>> myCourseDataList = memberService.getMyCourseDataList(member_no);
			model.addAttribute("myCourseDataList", myCourseDataList);

			// 위시리스트 정보
			ArrayList<HashMap<String, Object>> myWishDataList = memberService.getMyWishDataList(member_no);
			model.addAttribute("myWishDataList", myWishDataList);
			
			// 올린 강의 정보
			ArrayList<HashMap<String, Object>> myUploadDataList = memberService.getMyUploadDataList(member_no);
			model.addAttribute("myUploadDataList", myUploadDataList);
		}
		

		
		return "member/myPage";
	}
	
	@RequestMapping("teacherRegister")
	public String teacherRegister() {
		
		return "member/teacherRegister";
	}
	
	@RequestMapping("cartPage")
	public String cartPage(HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		ArrayList<HashMap<String, Object>> CartDataList = memberService.getCartDataList(member_no);
		model.addAttribute("CartDataList", CartDataList);
		
		return "member/cartPage";
	}
	
	@RequestMapping("orderPage")
	public String orderPage(int[] cart_no, Model model) {
		ArrayList<HashMap<String, Object>> selectCartDataList = memberService.getSelectCartDataList(cart_no);
		model.addAttribute("selectCartDataList", selectCartDataList);
		return "member/orderPage";
	}
	
	@RequestMapping("myCoursePage")
	public String myCoursePage(HttpSession session, Model model) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		ArrayList<HashMap<String, Object>> myCourseDataList = memberService.getMyCourseDataList(member_no);
		int count = myCourseDataList.size();
		
		model.addAttribute("count", count);
		model.addAttribute("myCourseDataList", myCourseDataList);
				
		return "member/myCoursePage";
	}
	
	@RequestMapping("refundPage")
	public String refundPage(int order_no, Model model, HttpSession session) {
		HashMap<String, Object> refundData = memberService.getRefundData(order_no);
		model.addAttribute("refundData", refundData);
		
		OrderVo orderVo = (OrderVo) refundData.get("orderVo");
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if (sessionUser == null ||sessionUser.getMember_no() != orderVo.getMember_no()) {
			return "member/loginReq";
		}
		return "member/refundPage";
	}
	
	@RequestMapping("refundProcess")
	public String refundProcess(OrderVo orderVo) {
		memberService.refundOrder(orderVo);
		
		return "member/refundComplete";
	}
	
	@RequestMapping("loginReq")
	public String loginReq() {
		
		return "member/loginReq";
	}
	
	// 강사등록 프로세스
	@RequestMapping("teacherRegisterProcess")
	public String teacherRegisterProcess(TeacherVo teacherVo, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		teacherVo.setMember_no(memberVo.getMember_no());
		
		System.out.println(teacherVo.getIntroduction() + teacherVo.getMember_no());
		memberService.insertTeacherToSQL(teacherVo);
		
		return "member/teacherRegisterComplete";
	}
}
