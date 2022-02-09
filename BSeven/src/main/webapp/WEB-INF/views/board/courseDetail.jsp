<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<title>Document</title>
</head>
<body>
	<div style="max-width: 1200px; margin: 0 auto;">
		<div class="container-fluid">

			<!-- nav 영역 -->
			<jsp:include page="../commons/global_nav.jsp"></jsp:include>


			<!-- 강의 카테고리 -->
			<jsp:include page="../commons/global_category.jsp"></jsp:include>

			<!--강의 정보-->
			<div class="row my-5">
				<div class="col-1"></div>
				<div class="col">
					<div class="row mt-3">
						<div class="col-md-12 col-lg-6">
							<img src="/uploadFolder2/${courseData.image }" id="image"
								class="img-fluid img-thumbnail" style="height: 300px;">
						</div>
						<!-- 1차 예제 수준으로 따로 설명 x select만 해오면 됩니다. -->
						<div class="col-md-12 col-lg-6 d-grid">
							<div class="row">
								<div class="col">
									<div class="row my-3">
										<div class="col">
											<span>강의명: </span><span>${courseData.courseVo.course_title }</span>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col">
											<span>강사: </span><span>${courseData.teacher_name }</span>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col">
											<span>수강기간: </span><span><fmt:formatNumber
													value="${courseData.courseVo.course_period }"
													pattern="#,###" />일</span>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col">
											<span>강의가격: </span><span><fmt:formatNumber
													value="${courseData.courseVo.course_price }"
													pattern="#,###" />원</span>
										</div>
									</div>
									<div class="row mb-3">
										<div class="col">
											<span>카테고리: </span> <span> <c:forEach
													items="${courseData.categoryName }" var="categoryName">${categoryName } </c:forEach>
											</span>
										</div>
									</div>
								</div>
							</div>
							<div class="row text-center">
								<div class="col-2">
									<c:choose>
										<c:when test="${wishNum > 0 }">
											<a onclick="wishState()"><i class="bi bi-heart-fill fs-3"
												id="heart"></i></a>
										</c:when>
										<c:otherwise>
											<a onclick="wishState()"><i class="bi bi-heart fs-3"
												id="heart"></i></a>
										</c:otherwise>
									</c:choose>
								</div>
								<div class="col">
									<button onclick="addCart()" class="btn btn-outline-primary">장바구니</button>

									<c:choose>
										<c:when test="${orderNum > 0 }">
											<a class="btn btn-primary disabled">이미 구매하였습니다.</a>
										</c:when>
										<c:otherwise>
											<button class="btn btn-outline-primary" onclick="openModal()">구매하기</button>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>

					</div>
					<div class="row mt-5">
						<div class="col" style="border: 1px solid #bdbdbd">
							<h4 class="m-5">${courseData.courseVo.course_content }</h4>
						</div>
					</div>

					<div class="row mt-3" style="border-bottom: 1px solid #bdbdbd;">
						<div class="col p-2">
							<i class="bi bi-chat"></i>
							후기(${fn:length(courseData.replyDataList) })
						</div>
						<div class="col p-2 text-end">
							<a
								href="./reviewWriteBoard?course_no=${courseData.courseVo.course_no }"
								class="btn btn-outline-primary">후기등록</a>
						</div>
					</div>
					<c:forEach items="${courseData.replyDataList }" var="replyData">
						<div class="row mt-4  ">
							<div class="col-2">${replyData.memberVo.member_nickname }</div>
							<div class="col-2 p-0">
								<fmt:formatDate value="${replyData.replyVo.reply_date }"
									pattern="yyyy-MM-dd hh:mm" />
							</div>
							<div class="col text-end">
								<a href="#">수정</a> <a href="#">삭제</a>
							</div>
						</div>
						<div class="row mt-2">
							<div class="col-1"></div>
							<div class="col">${replyData.replyVo.reply_text }</div>
							<div class="col-2">
								<c:forEach begin="1" end="${replyData.replyVo.reply_star }">
									<i class="bi bi-star-fill"></i>
								</c:forEach>
								<c:forEach begin="1" end="${5 - replyData.replyVo.reply_star }">
									<i class="bi bi-star"></i>
								</c:forEach>
							</div>
						</div>

					</c:forEach>
				</div>
				<div class="col-1"></div>
			</div>
			<!-- footer -->
			<jsp:include page="../commons/global_footer.jsp"></jsp:include>
		</div>
	</div>

	<!-- Modal -->
	<div class="modal fade" id="exampleModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-xl">
			<div class="modal-content">
				<div class="modal-body" id="modalBox"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<div id="orderPage" class="d-none">
		<div class="row my-5">
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col">
						<h1 style="font-weight: bold; font-size: x-large;">결제 정보</h1>
					</div>
				</div>
				<div class="row mt-4">
					<div class="col">
						<p>선택한 강의</p>
						<div class="row"
							style="border: 1px solid #bdbdbd; border-radius: 5px;">
							<div class="col p-5 pb-3" id="cartDataBox"></div>
						</div>
					</div>
				</div>
				<div class="row mt-5">
					<div class="col-6">
						<p>주문자 정보</p>
						<div class="row"
							style="border-top: 1px solid #bdbdbd; border-bottom: 1px solid #bdbdbd;">
							<div class="col">
								<div class="row p-3 pb-0">
									<div class="col-3">
										<p style="margin: 0;">주문자명</p>
									</div>
									<div class="col d-grid">
										<input type="text" value="${sessionUser.member_nickname }">
									</div>
								</div>
								<div class="row p-3 pb-0">
									<div class="col-3">
										<p style="margin: 0;">전화번호</p>
									</div>
									<div class="col d-grid">
										<input type="text" value="${sessionUser.member_phone }">
									</div>
								</div>
								<div class="row p-3">
									<div class="col-3">
										<p style="margin: 0;">이메일</p>
									</div>
									<div class="col d-grid">
										<input type="text" value="${sessionUser.member_email }">
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="col-1"></div>
					<div class="col">
						<p>결제 수단</p>
						<div class="row p-3" style="border: 1px solid #bdbdbd">
							<div class="form-check">
								<input class="form-check-input" type="radio" name="Radios"
									id="Radios1" value="계좌이체"> <label
									class="form-check-label" for="Radios1"> 계좌이체 </label>

							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="Radios"
									id="Radios2" value="카드결제"> <label
									class="form-check-label" for="Radios2"> 카드결제 </label>
							</div>
							<div class="form-check">
								<input class="form-check-input" type="radio" name="Radios"
									id="Radios3" value="무통장입금"> <label
									class="form-check-label" for="Radios3"> 무통장입금 </label>
							</div>
						</div>
						<div class="row mt-1">
							<div class="col d-grid">
								<a href="./cartPage" class="btn btn-primary">취소하기</a>
							</div>
							<div class="col d-grid">
								<input type="submit" value="결제하기" class="btn btn-primary">
							</div>
						</div>
					</div>
				</div>

			</div>
			<div class="col-1"></div>
		</div>
	</div>


	<!-- 카트 반복문용 태크 -->
	<div class="d-none" id="selectCartData">
		<div class="row my-2 py-2" style="border-bottom: 1px solid #bdbdbd;">
			<input type="hidden" name="course_no"
				value="${CartData.courseVo.course_no}"> <input type="hidden"
				name="cart_no" value="${CartData.cartVo.cart_no}">
			<div class="col-3">${CartData.courseVo.course_title }</div>
			<div class="col-5">
				<c:forEach items="${CartData.categoryName }" var="categoryName">${categoryName } </c:forEach>
			</div>
			<div class="col-2">${CartData.teacherName}</div>
			<div class="col-2 sale">
				<fmt:formatNumber pattern="#,###"
					value="${CartData.courseVo.course_price }" />
				원
			</div>
		</div>
	</div>





	<script type="text/javascript">
	
	var myModalEl = document.querySelector('#exampleModal');
	
	function openModal(obj) {
		var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
		if(obj.innerText == '구매하기') {
			orderMoal();
		}
		if(obj.innerText == '후기등록') {
			reviewModal();
		}
		
		
		modal.show();
	}
	
	function hideModal(){
		var modal = bootstrap.Modal.getInstance(myModalEl);
		modal.hide();
	}
	
	
	</script>
	<script>
		const url = window.location.href;
		if (document.querySelector("#inputUrl") != null) {
			const inputUrl = document.querySelector("#inputUrl");
			inputUrl.value = url.substring(url.indexOf(/bseven/) + 8);
		}
	</script>

	<script type="text/javascript">
		const heart = document.getElementById("heart");
	
	
		function wishState() {
			var xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function() {
				if(xhr.readyState==4 && xhr.status == 200) {
					var map = JSON.parse(xhr.responseText);
					if ( map.loginReq) {
						alert("로그인해주세요")
						return;
					}
					if (map.checkWish == true) {
						heart.classList.remove("bi-heart");
						heart.classList.add("bi-heart-fill");
					} else {
						heart.classList.remove("bi-heart-fill");
						heart.classList.add("bi-heart");

					}
					
				}
			}
			
			
			xhr.open("get", "../member/addWishlistProcess?course_no=" + ${courseData.courseVo.course_no }, true);
			xhr.send();
		}
	
		function addCart() {
			var xhr2 = new XMLHttpRequest();
			xhr2.onreadystatechange = function(){
				if(xhr2.readyState==4 && xhr2.status==200){
					var map2 = JSON.parse(xhr2.responseText);
					alert("장바구니에 담겼습니다.")
				}
			}
			xhr2.open("get", "../member/addCartProcess?course_no=" + ${courseData.courseVo.course_no }, true);
			xhr2.send();
		}
	
	
	</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
	<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
</body>
</html>