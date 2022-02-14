package com.ja.bseven.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.ja.bseven.board.service.BoardService;
import com.ja.bseven.member.service.MemberService;
import com.ja.bseven.vo.CategoryListVo;
import com.ja.bseven.vo.CourseImage;
import com.ja.bseven.vo.CourseVideo;
import com.ja.bseven.vo.CourseVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.ReplyVo;
import com.ja.bseven.vo.WishlistVo;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private MemberService memberService;
	
	
	@RequestMapping("mainPage")													// 페이지 활성화 할때 int 값은 null 값을 받지 못하기 때문에 @ API를 적용해줘야 함
	public String mainPage(Model model) {
		
		ArrayList<String> bannerImageList = boardService.mainBannerImageList();
		model.addAttribute("bannerImageList", bannerImageList);
		System.out.println("시스템 로그 ] 메인 페이지 실행");
		
		return "/board/mainPage";
	}
	
	@RequestMapping("courseUploadPage")
	public String courseUpload(Model model) {
		
		ArrayList<CategoryListVo> categoryList = boardService.getCategoryList();
		model.addAttribute("categoryList", categoryList);
		
		return "/board/courseUploadPage";
	}
	
	@RequestMapping("uploadCourseProcess")
	public String uploadCourseProcess(
			MultipartFile[] coursevideo,
			String[] courseTitle,
			int[] category_no,
			CourseVo courseVo,
			MultipartFile[] thumbnail,
			HttpSession session) {
		
		String folder = "C:/uploadFolder2/";
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
		String folderPath = sdf.format(date);
		
		File todayFolder = new File(folder+folderPath);
		if(!todayFolder.exists()) {
			todayFolder.mkdirs();
		}
		
		// 이미지와 동영상을 담을 ArrayList 생성
		ArrayList<CourseImage> courseImages = new ArrayList<CourseImage>();
		ArrayList<CourseVideo> courseVideos = new ArrayList<CourseVideo>();
		
		// video 변환과 트랜스퍼투
		for (int i=0; i<coursevideo.length; i++) {
			CourseVideo courseVideo = new CourseVideo();
			if( !coursevideo[i].isEmpty()) {
				UUID uuid = UUID.randomUUID();
				String randomName = uuid.toString() + "_" + System.currentTimeMillis();
				String ext = coursevideo[i].getOriginalFilename().substring(coursevideo[i].getOriginalFilename().lastIndexOf("."));
				randomName = randomName + ext;
				
				courseVideo.setCourse_video_url(folderPath+randomName);
				try {
					coursevideo[i].transferTo(new File(folder+folderPath+randomName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			courseVideo.setCourse_video_originalfilename(coursevideo[i].getOriginalFilename());
			courseVideo.setCourse_video_title(courseTitle[i]);
			courseVideos.add(courseVideo);
			System.out.println(coursevideo[i].getOriginalFilename() + " 전송완료");
		}
		
		// 이미지 변환과 트랜스퍼투
		for (int i=0; i<thumbnail.length; i++) {
			CourseImage coureImage = new CourseImage();
			if( !thumbnail[i].isEmpty()) {
				UUID uuid = UUID.randomUUID();
				String randomName = uuid.toString() + "_" + System.currentTimeMillis();
				String ext = thumbnail[i].getOriginalFilename().substring(thumbnail[i].getOriginalFilename().lastIndexOf("."));
				randomName = randomName + ext;
				
				coureImage.setCourse_image_url(folderPath+randomName);
				try {
					thumbnail[i].transferTo(new File(folder+folderPath+randomName));
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			coureImage.setCourse_image_originalName(thumbnail[i].getOriginalFilename());
			courseImages.add(coureImage);
			System.out.println(thumbnail[i].getOriginalFilename() + " 전송완료");
		}
		
		
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		int member_no = memberVo.getMember_no();
		
		boardService.insertCategory(courseVo, category_no, courseImages, courseVideos, member_no);
		
		return "redirect: ./mainPage";
	}
	
	@RequestMapping("deleteCourseProcess")
	public String deleteCourseProcess(int course_no) {
		if(boardService.deleteCourse(course_no)) {
			return "board/deleteCourseComplete";
		} else {
			return "board/deleteCourseFail";
		}
		
	}
	
	
	@RequestMapping("courseDetail")
	public String courseDetail(
			int course_no, 
			Model model, 
			HttpSession session, 
			HttpServletResponse response,
			HttpServletRequest request) {
		
		boolean cookieHas = false;
		
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String name = cookie.getName();
				String value = cookie.getValue();
				if("boardView".equals(name) && value.contains("|" + course_no + "|")) {
					cookieHas = true;
					break;
				} 
			}
		}
		
		if(!cookieHas) {
			Cookie cookie = new Cookie("boardView", "boardView|" + course_no + "|");
			cookie.setMaxAge(-1);
			response.addCookie(cookie);
			boardService.addCourseViewCount(course_no);
		}
		
		
		
		
		HashMap<String, Object> courseData = boardService.getCourseInfo(course_no);
		model.addAttribute("courseData", courseData);
		
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		if(sessionUser != null) {
			WishlistVo wish = new WishlistVo();
			wish.setCourse_no(course_no);
			wish.setMember_no(sessionUser.getMember_no());
			int wishNum = memberService.getWishlistVo(wish);
			model.addAttribute("wishNum", wishNum);

			int orderNum = memberService.getOrderCheck(course_no, sessionUser.getMember_no());
			model.addAttribute("orderNum", orderNum);
		}
		return "board/courseDetail";
	}
	
	@RequestMapping("reviewWriteBoard")
	public String reviewWriteBoard(int course_no, HttpSession session, Model model) {
		MemberVo sessionUser = (MemberVo) session.getAttribute("sessionUser");
		int member_no = sessionUser.getMember_no();
		OrderVo orderVo = new OrderVo();
		orderVo.setMember_no(member_no);
		orderVo.setCourse_no(course_no);
		
		HashMap<String, Object> courseData = memberService.getOrderCount(orderVo);
		if ( courseData == null) {
			return "/member/orderReq";
		}
		
		model.addAttribute("courseData", courseData);
		return "/board/reviewWriteBoard";
	}
	
	@RequestMapping("insertReviewProcess")
	public String insertReply(ReplyVo replyVo, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		replyVo.setMember_no(memberVo.getMember_no());
		boardService.insertReply(replyVo);
		return "/board/completeReview";
	}
	
}
