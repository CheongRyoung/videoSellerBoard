package com.ja.bseven.member.mapper;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;

import com.ja.bseven.vo.CartVo;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.OrderVo;
import com.ja.bseven.vo.TeacherVo;
import com.ja.bseven.vo.WishlistVo;

public interface MemberSQLMapper {

	public int idcheck(String member_id);
	
	public void joinMember(MemberVo vo);				// insert 쿼리는 정보를 입력
	
	public MemberVo getMemberByIdAndPw(MemberVo vo);	// select 쿼리는 받은 정보 확인
	
	public MemberVo getMemberByNo(int no);
	
	// 강사 관리 
	public void insertTeacherToSQL(TeacherVo teacherVo);
	public int getTeacherCheck(int member_no);
	public TeacherVo getTeacherNoByMemberno(int member_no);
	public MemberVo getTeacherName(int teacher_no);
	
	// 카트 관리
	public void insertCartVo(CartVo cartVo);
	
	// 카트 목록 가져오기
	public ArrayList<CartVo> getCartListByMemberNo(int member_no);
	public void deleteCartVo(int cart_no);
	public CartVo getCartByCartNo(int cart_no);
	public int getCartNo(CartVo cartVo);
	public int getCartCount(CartVo cartVo);
	
	// 오더 관리
	public void insertOrderVo(OrderVo orderVo);
	public ArrayList<OrderVo> getOrderList(int member_no);
	public ArrayList<OrderVo> getOrderListByCourse_no(int course_no);
	public OrderVo getOrderVo(int order_no);
	public void refundOrder(OrderVo orderVo);
	public int getOrderCount(OrderVo orderVo);
	public int getOrderCheck(
			@Param("course_no") int course_no, 
			@Param("member_no") int member_no);
	public void updateOrder(
			@Param("course_no") int course_no, 
			@Param("member_no") int member_no,
			@Param("course_period") int course_period			
			);
	
	
	// 위시리스트 관리
	public void insertWishlistVo(WishlistVo wishlistVo);
	public int checkWishlistVo(WishlistVo wishlistVo);
	public void deleteWishlistVo(WishlistVo wishlistVo);
	public int countWishlistVo(int course_no);
	public ArrayList<WishlistVo> getWishlistVo(int member_no);
}
