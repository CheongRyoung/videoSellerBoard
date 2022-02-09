<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="row" id="nav">
            <div class="col" style="box-shadow: 0px 0px 3px #000808;">
                <nav class="navbar navbar-expand-lg navbar-light bg-white">
                    <div class="container-fluid">
                      <a class="navbar-brand" href="/bseven/board/mainPage">B7</a>
                      <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                      </button>
                      <div class="collapse navbar-collapse" id="navbarNavDropdown">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="#">쇼핑몰</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" aria-current="page" href="#">고남곤</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#">김장문</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#">김진경</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="../boardCr/CR_board">김청룡</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#">안준석</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#">정세종</a>
                              </li>
                              <li class="nav-item">
                                <a class="nav-link" href="#">허지수</a>
                              </li>
                              </ul>
                        
                        
                        
                        <c:choose>
                        	<c:when test="${!empty sessionUser }">
		                       <ul class="navbar-nav ms-auto mb-2 mb-lg-0 d-grid">
					              <li class="nav-item dropdown ali">
					              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">
					                ${sessionUser.member_nickname }
					              </a>
					              <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
					                <li><a class="dropdown-item" href="/bseven/member/myPage">마이페이지</a></li>
					                <li><a class="dropdown-item" href="/bseven/member/cartPage">장바구니</a></li>
					                <li><a class="dropdown-item" href="/bseven/member/myCoursePage">내 강의실</a></li>
					                <li><a class="dropdown-item" href="/bseven/member/logoutProcess">로그아웃</a></li>

					              </ul>
					            </li>
					          </ul>
                        	</c:when>
                        	<c:otherwise>
                        		<form action="/bseven/member/loginProcess" method="post" class="d-flex">
	                          		<input name="member_id" class="form-control me-2" type="text" placeholder="ID" aria-label="Search">
	                          		<input name="member_pw" class="form-control me-2" type="password" placeholder="PW" aria-label="Search">
	                          		<input id="inputUrl" type="hidden" value="board/mainPage" name="page">
	                          		<input class="btn btn-outline-success" type="submit" value="login">
	                          		<a href="/bseven/member/joinMemberPage" class="btn btn-outline-success ms-1">Join</a>
                         		</form>
                        	</c:otherwise>
                        
                        </c:choose>

                      </div>
                    </div>
                </nav>
            </div>
          </nav>