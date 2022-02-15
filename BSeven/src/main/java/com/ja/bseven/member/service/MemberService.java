package com.ja.bseven.member.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.bseven.board.mapper.BoardSQLMapper;
import com.ja.bseven.member.mapper.MemberSQLMapper;
import com.ja.bseven.vo.CartVo;
import com.ja.bseven.vo.CategoryListVo;
import com.ja.bseven.vo.CourseCategory;
import com.ja.bseven.vo.CourseImage;
import com.ja.bseven.vo.CourseVideo;
import com.ja.bseven.vo.CourseVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.ReplyVo;
import com.ja.bseven.vo.TeacherVo;
import com.ja.bseven.vo.WishlistVo;


@Service
public class MemberService {

	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	@Autowired
	private BoardSQLMapper boardSQLMapper; 
	
	public int idcheck(String member_id) {
		return memberSQLMapper.idcheck(member_id);
	}
	
	public void joinMember(MemberVo vo) {
		
		memberSQLMapper.joinMember(vo);
	}
	
	// 로그인
	public MemberVo login(MemberVo vo) {
		
		MemberVo result = memberSQLMapper.getMemberByIdAndPw(vo);
		
		return result;
	}
	
	// 강사 관리
	public void insertTeacherToSQL(TeacherVo teacherVo) {
		memberSQLMapper.insertTeacherToSQL(teacherVo);
	}
	
	public boolean getTeacherCheck(int member_no) {
		
		if (memberSQLMapper.getTeacherCheck(member_no) == 1) {
			return false;
		} else {
			return true;
		}
	}
	
	public boolean insertCartVo(CartVo cartVo) {
		if (memberSQLMapper.getCartCount(cartVo) > 0) {
			return false;
		}  else {
			memberSQLMapper.insertCartVo(cartVo);
			return true;
		}
		
		
	}
	
	public boolean checkCartVo(CartVo cartVo) {
		if(memberSQLMapper.getCartCount(cartVo) > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	public ArrayList<HashMap<String, Object>> getCartDataList(int member_no){
		ArrayList<HashMap<String, Object>> cartDataList = new ArrayList<HashMap<String,Object>>();
		
		ArrayList<CartVo> cartList = memberSQLMapper.getCartListByMemberNo(member_no);
		
		for (CartVo cartVo : cartList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int course_no = cartVo.getCourse_no();
			CourseVo courseVo = boardSQLMapper.getCourseInfo(course_no);
			map.put("courseVo", courseVo);
			
			String teacherName = memberSQLMapper.getTeacherName(courseVo.getTeacher_no()).getMember_nickname();
			map.put("teacherName", teacherName);
			
			ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(course_no);
			ArrayList<String> categoryName = new ArrayList<String>();
			for(CourseCategory courseCategory : courseCategoryList) {
				categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
			}
			map.put("categoryName", categoryName);
			map.put("cartVo", cartVo);
			
			cartDataList.add(map);
		}

		return cartDataList;
	}
	
	public void deleteCartVo(int cart_no) {
		memberSQLMapper.deleteCartVo(cart_no);
	}
	
	public ArrayList<HashMap<String, Object>> getSelectCartDataList(int[] cart_no){
		ArrayList<HashMap<String, Object>> selectCartDataList = new ArrayList<HashMap<String,Object>>();
		ArrayList<CartVo> cartList = new ArrayList<CartVo>();
		for (int number : cart_no) {
			cartList.add(memberSQLMapper.getCartByCartNo(number));
		}
		
		for (CartVo cartVo : cartList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			int course_no = cartVo.getCourse_no();
			CourseVo courseVo = boardSQLMapper.getCourseInfo(course_no);
			map.put("courseVo", courseVo);
			
			String teacherName = memberSQLMapper.getTeacherName(courseVo.getTeacher_no()).getMember_nickname();
			map.put("teacherName", teacherName);
			
			ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(course_no);
			ArrayList<String> categoryName = new ArrayList<String>();
			for(CourseCategory courseCategory : courseCategoryList) {
				categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
			}
			int orderCount = memberSQLMapper.getOrderCheck(cartVo.getCourse_no(), cartVo.getMember_no());
			if (orderCount > 0) {
				map.put("orderCheck", "ext");
			} else {
				map.put("orderCheck", "new");
			}
			
			map.put("categoryName", categoryName);
			map.put("cartVo", cartVo);
			
			selectCartDataList.add(map);
		}

		return selectCartDataList;
	}
	
	public int getCartNo(CartVo cartVo) {
		return memberSQLMapper.getCartNo(cartVo);
	}

	
	public void insertOrderVo(int[] course_no, int[] cart_no, int member_no) {
		
		for(int i=0; i<course_no.length; i++) {
			int checkOrderCount = memberSQLMapper.getOrderCheck(course_no[i], member_no);
			
			if (checkOrderCount == 0 ) {
				OrderVo orderVo = new OrderVo();
				orderVo.setMember_no(member_no);
				orderVo.setCourse_no(course_no[i]);
				memberSQLMapper.insertOrderVo(orderVo);
				memberSQLMapper.deleteCartVo(cart_no[i]);
			} else {
				CourseVo courseVo = boardSQLMapper.getCourseInfo(course_no[i]);
				memberSQLMapper.updateOrder(course_no[i], member_no, courseVo.getCourse_period());
				memberSQLMapper.deleteCartVo(cart_no[i]);
			}
		}
	}
	
	public HashMap<String, Object> getOrderCount(OrderVo orderVo) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int checkOrder =  memberSQLMapper.getOrderCount(orderVo);
		if(checkOrder > 0) {
			CourseVo courseVo = boardSQLMapper.getCourseInfo(orderVo.getCourse_no());
			MemberVo memberVo = memberSQLMapper.getTeacherName(courseVo.getTeacher_no());
			String teacherName = memberVo.getMember_nickname();
			ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(courseVo.getCourse_no());
			ArrayList<CategoryListVo> categoryListVoList = new ArrayList<CategoryListVo>();
			for (CourseCategory courseCategory : courseCategoryList) {
				categoryListVoList.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()));
			}
			
			
			ArrayList<CourseImage> courseImageList = boardSQLMapper.getCourseImageList(courseVo.getCourse_no());
			String imageUrl = courseImageList.get(0).getCourse_image_url();
			
			map.put("courseVo", courseVo);
			map.put("teacherName", teacherName);
			map.put("categoryListVoList", categoryListVoList);
			map.put("imageUrl", imageUrl);
			
			return map;

		} else {
			map = null;
			return map;
		}
	}
	
	public int getOrderCheck(int course_no, int member_no) {
		return memberSQLMapper.getOrderCheck(course_no, member_no);
	}
	
	public void deleteCartVoByOrder(int[] course_no, int[] cart_no, int member_no) {
		for(int i=0; i<course_no.length; i++) {
			CartVo cartVo = new CartVo();
			cartVo.setCourse_no(course_no[i]);
			cartVo.setMember_no(member_no);
			int cartCheck = memberSQLMapper.getCartCount(cartVo);
			if(cartCheck > 0) {
				memberSQLMapper.deleteCartVo(cart_no[i]);
			}
		}
	}
	
	public ArrayList<HashMap<String, Object>> getMyCourseDataList(int member_no) {
		ArrayList<OrderVo> orderList = memberSQLMapper.getOrderList(member_no);
		ArrayList<HashMap<String, Object>> myCourseDataList = new ArrayList<HashMap<String,Object>>();
		
		for (OrderVo orderVo : orderList) {
			if (orderVo.getOrder_refund_date() == null) {
				HashMap<String, Object> map = new HashMap<String, Object>();
				
				CourseVo courseVo = boardSQLMapper.getCourseInfo(orderVo.getCourse_no());
				
				MemberVo memberVo = memberSQLMapper.getTeacherName(courseVo.getTeacher_no());
				String teacherName = memberVo.getMember_nickname();
				
			    Date orderDate = orderVo.getOrder_date();
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			    
			    Calendar cal = Calendar.getInstance();
			    cal.setTime(orderDate);
			    cal.add(Calendar.DATE, courseVo.getCourse_period());
			    Date expire = new Date(cal.getTimeInMillis());
			    
			    int replyCount = boardSQLMapper.getReviewCount(courseVo.getCourse_no(), member_no);
			    ReplyVo replyVo = boardSQLMapper.getReplyVoByMemNoCourseNo(courseVo.getCourse_no(), member_no);
			    
			    ArrayList<CourseVideo> courseVideoList = boardSQLMapper.getCourseVideo(courseVo.getCourse_no());
			    
			    ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(courseVo.getCourse_no());
				ArrayList<String> categoryName = new ArrayList<String>();
				for(CourseCategory courseCategory : courseCategoryList) {
					categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
				}
				
				map.put("replyCount", replyCount);
				map.put("replyVo", replyVo);
				map.put("orderVo", orderVo);
				map.put("categoryName", categoryName);
			    map.put("courseVo", courseVo);
			    map.put("teacherName", teacherName);
			    map.put("expire", expire);
			    map.put("courseVideoList", courseVideoList);
			    
			    myCourseDataList.add(map);
			}
			
		}
		
		return myCourseDataList;
		
	}
	
	public ArrayList<CourseVideo> getCourseVideo(int course_no) {
		return boardSQLMapper.getCourseVideo(course_no);

	}
	
	
	public boolean checkWishlistVo(WishlistVo wishlistVo) {
		int checkNum = memberSQLMapper.checkWishlistVo(wishlistVo);
		
		if (checkNum > 0) {
			memberSQLMapper.deleteWishlistVo(wishlistVo);
			return false;
		} else {
			memberSQLMapper.insertWishlistVo(wishlistVo);
			return true;
		}
	}
	
	public int getWishlistVo(WishlistVo wishlistVo) {
		
		return memberSQLMapper.checkWishlistVo(wishlistVo);
	}
	
	public ArrayList<HashMap<String, Object>> getMyWishDataList(int member_no){
		
		ArrayList<HashMap<String, Object>> myWishDataList = new ArrayList<HashMap<String,Object>>();
		ArrayList<WishlistVo> WishlistVoList = memberSQLMapper.getWishlistVo(member_no);
		for (WishlistVo wishlistVo : WishlistVoList) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			CourseVo courseVo = boardSQLMapper.getCourseInfo(wishlistVo.getCourse_no());
			
			MemberVo memberVo = memberSQLMapper.getTeacherName(courseVo.getTeacher_no());
			String teacherName = memberVo.getMember_nickname();
			
		    ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(courseVo.getCourse_no());
			ArrayList<String> categoryName = new ArrayList<String>();
			for(CourseCategory courseCategory : courseCategoryList) {
				categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
			}
			
			map.put("categoryName", categoryName);
			map.put("courseVo", courseVo);
			map.put("teacherName", teacherName);
			myWishDataList.add(map);
		}
		
		return myWishDataList;
	}
	
	public ArrayList<HashMap<String, Object>> getMyUploadDataList(int member_no) {
		ArrayList<HashMap<String, Object>> myUploadDataList = new ArrayList<HashMap<String,Object>>();
		int teacher_no = memberSQLMapper.getTeacherNoByMemberno(member_no).getTeacher_no();
		
		ArrayList<CourseVo> courseInfoListByteacher = boardSQLMapper.getCourseInfoListByteacher(teacher_no);
		for (CourseVo courseVo : courseInfoListByteacher) {
			HashMap<String, Object> map = new HashMap<String, Object>();
			
			MemberVo memberVo = memberSQLMapper.getTeacherName(teacher_no);
			String teacherName = memberVo.getMember_nickname();
			
		    ArrayList<CourseCategory> courseCategoryList = boardSQLMapper.getCourseCategoryList(courseVo.getCourse_no());
			ArrayList<String> categoryName = new ArrayList<String>();
			for(CourseCategory courseCategory : courseCategoryList) {
				categoryName.add(boardSQLMapper.getCategory(courseCategory.getCategory_no()).getCategory_name());
			}
			
			map.put("categoryName", categoryName);
			map.put("courseVo", courseVo);
			map.put("teacherName", teacherName);
			myUploadDataList.add(map);
		}
		return myUploadDataList;
	}
	
	public HashMap<String, Object> getRefundData(int order_no) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		OrderVo orderVo = memberSQLMapper.getOrderVo(order_no);
		CourseVo courseVo = boardSQLMapper.getCourseInfo(orderVo.getCourse_no());
		MemberVo memberVo = memberSQLMapper.getTeacherName(courseVo.getTeacher_no());
		String teacherName = memberVo.getMember_nickname();
		
		map.put("orderVo", orderVo);
		map.put("courseVo", courseVo);
		map.put("teacherName", teacherName);
		
		return map;
	}
	
	public void refundOrder(OrderVo orderVo) {
		memberSQLMapper.refundOrder(orderVo);
	}
	
	
		
}
