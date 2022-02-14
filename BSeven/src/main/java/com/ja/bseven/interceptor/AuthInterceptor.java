package com.ja.bseven.interceptor;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.mvc.WebContentInterceptor;

public class AuthInterceptor extends WebContentInterceptor {

	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws ServletException {
		// TODO Auto-generated method stub
		System.out.println("interceptor do");
		
		if(request.getSession().getAttribute("sessionUser") == null) {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/member/loginReq");
			throw new ModelAndViewDefiningException(mav);
			
		} else {
			return true;
		}
		
	}
}
