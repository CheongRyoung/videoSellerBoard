<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <title>Document</title>
<script>
// 별점 구현
function color(num) {
    const checkStar = document.querySelectorAll(".checkStar");
    const star = document.querySelectorAll(".star");
    const chooseWord = document.querySelector("#chooseWord");
    starNum = num;
    
    for(var i=0; i<checkStar.length; i++){
        star[i].classList.remove("redStar");
    }
    for(var i=0; i<num; i++){
        star[i].classList.add("redStar");
    }

    switch(num) {
    case 1:  // if (x === 'value1')
      chooseWord.style.color = 'red';
      chooseWord.innerText = "1점 별로에요";
      break;

    case 2:  // if (x === 'value2')
    chooseWord.style.color = 'red';
      chooseWord.innerText = "2점 그저그래요";
      break;

    case 3:  // if (x === 'value2')
    chooseWord.style.color = 'red';
    chooseWord.innerText = "3점 괜찮아요";
    break;

    case 4:  // if (x === 'value2')
    chooseWord.style.color = 'red';
    chooseWord.innerText = "4점 좋아요";
    break;

    case 5:  // if (x === 'value2')
    chooseWord.style.color = 'red';
    chooseWord.innerText = "5점 최고에요";
    break;
    }
}

</script>
<style>
.star {
	font-size: 2rem;
	color: #ddd;
}

.checkStar {
	display: none;
}

.redStar {
	color: red;
}
</style>    
</head>
<body>
    <div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
          <!-- nav 영역 -->  
          <jsp:include page="../commons/global_nav.jsp"></jsp:include>
          
          <!-- 강의 카테고리 -->
          <jsp:include page="../commons/global_category.jsp"></jsp:include>

          <!-- 회원가입 form -->
          <div class="row my-5">
                <div class="col-1"></div>  
                <div class="col">
                  <div class="row">
                      <div class="col">
                        <h1 class="fw-bold">마이페이지</h1>
                      </div>
                      <div class="col text-end">
                        <c:if test="${checkTeacher }">
                        <a href="./teacherRegister" class="btn btn-outline-success">강사신청</a>
                        </c:if>
                    </div>
                  </div>
                  <!-- 내가 듣는 강의 -->
                  <div class="row my-5 p-4" style="border-radius: 8px; border: #bdbdbd 1px solid;">
                      <div class="col" id="myOrderBox">
                            <h5 class="fw-bold mb-5">내가 듣는 강의</h5>
                           
                      </div>
                  </div>

                  <!-- 관심 강의 -->
                  <div class="row my-5  p-4" style="border-radius: 8px; border: #bdbdbd 1px solid;">
                    <div class="col"  id="myWishBox">
                          <h5 class="fw-bold mb-5">관심 강의</h5>
                            <c:forEach items="${myWishDataList }" var="myCourseData">
                            <div class="row fs-6 mt-3 pb-2" style="border-bottom: 1px solid #dbdbdb;">
                                <div class="col-3" >${myCourseData.courseVo.course_title }</div>
                                <div class="col-5"><c:forEach items="${myCourseData.categoryName }" var="categoryName">${categoryName } </c:forEach></div>
                                <div class="col-2">${myCourseData.teacherName }</div>
                                 <div class="col-2 text-end"><button class="btn btn-outline-primary btn-sm" onclick="orderMoal(${myCourseData.courseVo.course_no })">구매하기</button></div>
                            </div>
                            </c:forEach>
                    </div>
                  </div>

                  <!-- 내가 올린 강의 -->
                  <c:if test="${!checkTeacher }">
                  <div class="row my-5  p-4" style="border-radius: 8px; border: #bdbdbd 1px solid;">
                    <div class="col" id="myCourseBox">
                            <div class="row">
                                <div class="col">
                                    <h5 class="fw-bold mb-5" >내가 올린 강의</h5>
                                </div>
                                <div class="col text-end">
                                    <a href="/bseven/board/courseUploadPage">강의 등록</a>
                                </div>
                            </div>
                           <c:forEach items="${myUploadDataList }" var="myCourseData">
                            <div class="row fs-6 mt-3 pb-2" style="border-bottom: 1px solid #dbdbdb;">
                                <div class="col-3" >${myCourseData.courseVo.course_title }</div>
                                <div class="col-5"><c:forEach items="${myCourseData.categoryName }" var="categoryName">${categoryName } </c:forEach></div>
                                <div class="col-2">${myCourseData.teacherName }</div>
                                <div class="col-2 text-end"><a href="../board/deleteCourseProcess?course_no=${myCourseData.courseVo.course_no }" style="font-size: 14px;">삭제하기</a></div>
                            </div>
                            </c:forEach>  
                    </div>
                  </div>
                  </c:if>

                </div>
                <div class="col-1"></div>
          </div>

         <!-- footer -->
         <jsp:include page="../commons/global_footer.jsp"></jsp:include>
        </div>
    </div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-body" id="modalBox">
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<div id="reviewPage" class="d-none">
	<div class="row my-5">
		<div class="col-1"></div>
		<div class="col">
			<h1 class="fw-bold">후기 등록</h1>
			<div class="row mt-5 p-4">
				<div class="col">
					<!-- 강의 정보 -->
					<div class="row pb-4" style="border-bottom: #e0e0e0 10px solid;">
						<!-- 강의 썸네일 -->
						<div class="col">
							<img class="img-fluid" id="reviewImgBox">
						</div>
						<!-- 강의 요약 -->
						<div class="col d-grid mt-3">
							<div class="row text-start">
								<div class="col-md-3">
									<span>강의제목: </span>
								</div>
								<div class="col">
									<span id="reviewTitleBox"></span>
								</div>
							</div>
							<div class="row text-start">
								<div class="col-md-3">
									<span>강사명: </span>
								</div>
								<div class="col">
									<span id="reviewTeacherBox"> </span>
								</div>
							</div>
							<div class="row text-start">
								<div class="col-md-3">
									<span>카테고리: </span>
								</div>
								<div class="col" id="reviewCategoryBox"></div>
							</div>
							<div class="row text-start">
								<div class="col-md-3">
									<span>가격: </span>
								</div>
								<div class="col" id="reviewPriceBox"></div>
							</div>
						</div>
					</div>
					<!-- 별점 -->
					<div class="row mt-3">
						<div class="col text-center">
							<span>강의는 만족하셨나요?</span>
						</div>
					</div>
					<div class="row text-center">
						<div class="col">
							<label class="star" for="star1" onclick="color(1)">★</label><input
								type="radio" class="checkStar" value="1"> <label
								class="star" for="star2" onclick="color(2)">★</label><input
								type="radio" class="checkStar" value="2"> <label
								class="star" for="star3" onclick="color(3)">★</label><input
								type="radio" class="checkStar" value="3"> <label
								class="star" for="star4" onclick="color(4)">★</label><input
								type="radio" class="checkStar" value="4"> <label
								class="star" for="star5" onclick="color(5)">★</label><input
								type="radio" class="checkStar" value="5">
						</div>
					</div>
					<div class="row">
						<div class="col text-center">
							<span style="font-size: small; color: #bdbdbd" id="chooseWord">선택해주세요</span>
						</div>
					</div>

					<div class="row mt-3">
						<div class="coltext-center d-grid">
							<textarea placeholder="강의평을 작성해주세요" id="reply_text"></textarea>
						</div>
					</div>
					<div class="row text-end mt-3">
						<div class="col">
							<button type="button" class="btn btn-outline-primary" id="reviewButtonBox"
								onclick="insertReview()">후기 등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>

<!-- orderPage source -->
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
						<div class="col p-5 pb-3 cartDataBox"></div>
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
									<input type="text" class="sessionUserNick">
								</div>
							</div>
							<div class="row p-3 pb-0">
								<div class="col-3">
									<p style="margin: 0;">전화번호</p>
								</div>
								<div class="col d-grid">
									<input type="text" class="sessionUserPhone">
								</div>
							</div>
							<div class="row p-3">
								<div class="col-3">
									<p style="margin: 0;">이메일</p>
								</div>
								<div class="col d-grid">
									<input type="text" class="sessionUserEmail">
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
							<button class="btn btn-primary" data-bs-dismiss="modal">취소하기</button>
						</div>
						<div class="col d-grid">
							<button type="button" class="btn btn-primary orderAccessButton"
								onclick="orderProcess(cart_no_arr, course_no_arr)">결제하기</button>
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
		<div class="col">
			<div class="row">
				<input type="hidden" name="course_no" value=""
					class="cartDataCourse_no"> <input type="hidden"
					name="cart_no" value="" class="cartDataCart_no">
				<div class="col-3 cartDataCourse_title">제목</div>
				<div class="col-4 categoryBox">카테고리로 for문</div>
				<div class="col-2 cartDataTeacherName">강사명</div>
				<div class="col-2 sale cartDataCourse_price">금액</div>
				<div class="col-1 rePurchase">구매</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
 
let myMemberNO = 0;
 
let myModalEl = document.querySelector('#exampleModal');
myModalEl.addEventListener('hidden.bs.modal', function (event) {
	let modalBox = document.getElementById("modalBox")
	modalBox.innerHTML = "";
	});
	

function getLoginInfo() {
	let xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4&&xhr.status==200){
			let data = JSON.parse(xhr.responseText);
			if (data.result == 'success') {
				myMemberNO = data.member_no;
			} else {
				alert("로그인이 필요합니다.");
				location.href = "../board/mainPage";
			}

		}
	}
	xhr.open("get", "./getLoginInfo", false);
	xhr.send();
	
}	

function reviewBoardModal(num) {
	
let xhr = new XMLHttpRequest();
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4&&xhr.status==200){
			let data = JSON.parse(xhr.responseText);
			
			if(data.result == "login Req"){
				alert("로그인 해줘");
				return;
			}
			let reviewCourseData = data.courseData;
			
			let reviewPage = document.getElementById("reviewPage");
			let mainNode = reviewPage.firstElementChild.cloneNode(true);
			let modalBox = document.getElementById("modalBox");
			modalBox.innerHTML = "";
			modalBox.append(mainNode);
			
			let reviewImgBox = document.getElementById("reviewImgBox");
			reviewImgBox.setAttribute("src", "/uploadFolder2/"+ reviewCourseData.imageUrl +"");
			let reviewTitleBox = document.getElementById("reviewTitleBox");
			reviewTitleBox.innerText = reviewCourseData.courseVo.course_title;
			let reviewTeacherBox = document.getElementById("reviewTeacherBox");
			reviewTeacherBox.innerText = reviewCourseData.teacherName;
			let reviewCategoryBox = document.getElementById("reviewCategoryBox");
			let categoryList = "";
			for (categoryName of reviewCourseData.categoryListVoList) {
				categoryList += categoryName.category_name;
			}
			reviewCategoryBox.innerText = categoryList;
			let reviewPriceBox = document.getElementById("reviewPriceBox");
			let reviewPrice = reviewCourseData.courseVo.course_price
			reviewPriceBox.innerText = reviewPrice.toLocaleString() + "원";
			let reviewButtonBox = document.getElementById("reviewButtonBox");
			reviewButtonBox.setAttribute("onclick", "insertReview("+num+")");

			let modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
			modal.show();
		}
	}
	xhr.open("get", "../board/reviewWriteBoardModal?course_no=" + num, false);
	xhr.send();
	
}


function insertReview(num) {
	var xhr = new XMLHttpRequest();
	var reviewSting = "reply_text=" + document.querySelector("#modalBox #reply_text").value + "&reply_star=" + starNum + "&course_no=" + num;
	
	xhr.onreadystatechange = function() {
		if(xhr.readyState==4&& xhr.status==200){
			var data = JSON.parse(xhr.responseText);
			if(data.result = 'success'){
				var modalBox = document.querySelector("#modalBox");
				modalBox.innerHTML = "";
				modalBox.innerText = "리뷰작성이 완료되었습니다."	
			}
			refreshMyOrderBox();
		}
	}
	xhr.open("post", "../board/insertReviewProcessModal", true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(reviewSting);
	
}

function updateReviewBoardModal(replyNo, courseNo){
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status==200){
			var data = JSON.parse(xhr.responseText);
			reviewBoardModal(courseNo);
			document.querySelector("#modalBox #reply_text").value = data.replyVo.reply_text;
			document.querySelector("#modalBox button").setAttribute("onclick", "updateReview("+replyNo+", "+courseNo+")");
			console.log(replyNo);
			document.querySelector("#modalBox button").innerText = "후기 수정";
			color(data.replyVo.reply_star);
		}
	}
	xhr.open("get", "../board/updateReviewModal?reply_no="+replyNo, true);
	xhr.send();
}

function updateReview(replyNO, courseNo) {
	var xhr = new XMLHttpRequest();
	var reviewSting = "reply_no="+ replyNO + "&reply_text=" + document.querySelector("#modalBox #reply_text").value + "&reply_star=" + starNum + "&course_no=" + courseNo;

	xhr.onreadystatechange = function() {
		if(xhr.readyState==4&& xhr.status==200){
			var data = JSON.parse(xhr.responseText);
			if(data.result = 'success'){
				var modalBox = document.querySelector("#modalBox");
				modalBox.innerHTML = "";
				modalBox.innerText = "리뷰수정이 완료되었습니다."
				
			}
		}
	}
	xhr.open("post", "../board/updateReview", true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send(reviewSting);
	
}

function deleteReviewBoardModal(replyNo) {
	var modalBox = document.querySelector("#modalBox");
	modalBox.innerHTML = "";
	var modalBoxInP = document.createElement("p");
	modalBoxInP.innerText = "리뷰를 삭제 하겠습니까?";
	var deleteButton = document.createElement("button");
	deleteButton.setAttribute("class", "btn btn-danger");
	deleteButton.setAttribute("onclick", "deleteReview("+replyNo+")");
	deleteButton.innerText = "삭제해주세요"
	modalBox.append(modalBoxInP, deleteButton);
	
	var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
	modal.show();
}

function deleteReview(replyNo) {
	var xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4 && xhr.status==200){
			var modalBox = document.querySelector("#modalBox");
			modalBox.innerHTML = "";
			modalBox.innerText = "리뷰가 삭제되었습니다.";
			
		}
		refreshMyOrderBox();
	}
	xhr.open("get", "../board/deleteReview?reply_no=" + replyNo, true);
	xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhr.send();
}




function refreshMyOrderBox() {
	let xhr = new XMLHttpRequest();
	xhr.onreadystatechange = function(){
		if(xhr.readyState==4&&xhr.status==200){
			let data = JSON.parse(xhr.responseText);
			let myOrderDataList = data.myOrderDataList;
			
			if(myOrderDataList.length == 0) {
				const myOrder = document.createElement("div");
				myOrder.setAttribute("class", "row fs-6 mt-3 pb-2");
				myOrder.setAttribute("style", "border-bottom: 1px solid #dbdbdb;");
				myOrder.innerText = "구매한 강의가 없습니다."
				const myOrderBox = document.getElementById("myOrderBox");
				myOrderBox.innerHTML = "";
				const myOrderBoxH5 = document.createElement("h5");
				myOrderBoxH5.setAttribute("class", "fw-bold mb-5");
				myOrderBoxH5.innerText = "내가 듣는 강의";
				myOrderBox.append(myOrderBoxH5, myOrder);
				return;
			}
			const myOrderBox = document.getElementById("myOrderBox");
			myOrderBox.innerHTML = "";
			const myOrderBoxH5 = document.createElement("h5");
			myOrderBoxH5.setAttribute("class", "fw-bold mb-5");
			myOrderBoxH5.innerText = "내가 듣는 강의";
			myOrderBox.append(myOrderBoxH5);

			for(myOrderData of myOrderDataList){
				const myOrder = document.createElement("div");
				myOrder.setAttribute("class", "row fs-6 mt-3 pb-2");
				myOrder.setAttribute("style", "border-bottom: 1px solid #dbdbdb;");

					const myOrderTitle = document.createElement("div");
					myOrderTitle.setAttribute("class", "col-3");
					myOrderTitle.innerText = myOrderData.courseVo.course_title;

					const myOrderCategory = document.createElement("div");
					myOrderCategory.setAttribute("class", "col-3");
					let categoryStr = "";
					for(category of myOrderData.categoryName) {
						categoryStr = categoryStr + category;
					}
					myOrderCategory.innerText = categoryStr;

					const myOrderTeacher = document.createElement("div");
					myOrderTeacher.setAttribute("class", "col-1");
					myOrderTeacher.innerText = myOrderData.teacherName;

					const myOrderReview = document.createElement("div");
					myOrderReview.setAttribute("class", "col text-end");
					
						if(myOrderData.replyCount == 0) {
							const reviewButton = document.createElement("button");
							reviewButton.setAttribute("class", "btn btn-outline-success btn-sm");
							reviewButton.setAttribute("onclick", "reviewBoardModal("+myOrderData.courseVo.course_no+")");
							reviewButton.innerText = "후기 등록"
					myOrderReview.append(reviewButton)
						} else {
							const reviewButtonGroup = document.createElement("div");
							reviewButtonGroup.setAttribute("class", "btn-group");

								const updateReviewButton = document.createElement("button");
								updateReviewButton.setAttribute("class", "btn btn-outline-success btn-sm");
								updateReviewButton.setAttribute("onclick", "updateReviewBoardModal("+myOrderData.replyVo.reply_no+", "+myOrderData.courseVo.course_no+")");
								updateReviewButton.innerText = "후기 수정"

								const deleteReviewButton = document.createElement("button");
								deleteReviewButton.setAttribute("class", "btn btn-outline-danger btn-sm");
								deleteReviewButton.setAttribute("onclick", "deleteReviewBoardModal("+myOrderData.replyVo.reply_no+")");
								deleteReviewButton.innerText = "후기 삭제"
							reviewButtonGroup.append(updateReviewButton, deleteReviewButton)
					myOrderReview.append(reviewButtonGroup);
						}

					const myOrderRefund = document.createElement("div");
					myOrderRefund.setAttribute("class", "col-1 text-end");

						const refundButton = document.createElement("a");
						refundButton.setAttribute("class", "btn btn-outline-danger btn-sm");
						refundButton.setAttribute("href", "./refundPage?order_no="+myOrderData.orderVo.order_no );
						refundButton.innerText = "환불"
					myOrderRefund.append(refundButton);
				myOrder.append(myOrderTitle, myOrderCategory, myOrderTeacher, myOrderReview, myOrderRefund);
				const myOrderBox = document.getElementById("myOrderBox");
				myOrderBox.append(myOrder);
			}
			
			
			
		}
	}
	xhr.open("get", "./refreshMyOrderBox?member_no=" + myMemberNO, true);
	xhr.send();
}


window.addEventListener("DOMContentLoaded", e => {
	getLoginInfo();
	refreshMyOrderBox();
})

function orderMoal(num){
		var course_no = url.substring(url.indexOf('no') + 3);
		var xhr = new XMLHttpRequest();
		
		var cart_no_arr = new Array();
		var course_no_arr = new Array();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				
				if(data.result == 'login req') {
					alert("로그인해줘");
					return;
				}
				
				var memberVo = data.sessionUser;
				var selectCartDataList = data.selectCartDataList;
				
				var orderPage = document.getElementById("orderPage");
				var mainNode = orderPage.firstElementChild.cloneNode(true);
				var modalBox = document.getElementById("modalBox");
				modalBox.innerHTML = "";
				modalBox.append(mainNode);
				
				var sessionUserNick = document.querySelector("#modalBox .sessionUserNick");
				sessionUserNick.setAttribute("value", memberVo.member_nickname);
				var sessionUserPhone = document.querySelector("#modalBox .sessionUserPhone");
				sessionUserPhone.setAttribute("value", memberVo.member_phone);
				var sessionUserEmail = document.querySelector("#modalBox .sessionUserEmail");
				sessionUserEmail.setAttribute("value", memberVo.member_email);
				
				for (CartData of selectCartDataList) {
					var selectCartData = document.getElementById("selectCartData");
					var cartData = selectCartData.firstElementChild.cloneNode(true);
					var cartDataBox = document.querySelector("#modalBox .cartDataBox");
					cartDataBox.append(cartData);
					var cartDataCourse_no = document.querySelector("#modalBox .cartDataCourse_no");
					cartDataCourse_no.setAttribute("value", CartData.courseVo.course_no);
					course_no_arr[course_no_arr.length] = CartData.courseVo.course_no;
					var cartDataCart_no = document.querySelector("#modalBox .cartDataCart_no");
					cartDataCart_no.setAttribute("value", CartData.cartVo.cart_no);
					cart_no_arr[cart_no_arr.length] = CartData.cartVo.cart_no;
					var cartDataCourse_title = document.querySelector("#modalBox .cartDataCourse_title");
					cartDataCourse_title.innerText = CartData.courseVo.course_title
					
					var categoryBox = document.querySelector("#modalBox .categoryBox");
					for(categoryName of CartData.categoryName) {
						var tempName = ""
						tempName = tempName + categoryName + " ";
						categoryBox.innerText = tempName;
					}
					var cartDataTeacherName = document.querySelector("#modalBox .cartDataTeacherName");
					cartDataTeacherName.innerText = CartData.teacherName;
					var cartDataCourse_price = document.querySelector("#modalBox .cartDataCourse_price");
					var tempPrice = CartData.courseVo.course_price
					cartDataCourse_price.innerText = tempPrice.toLocaleString() + "원";
					var rePurchase = document.querySelector("#modalBox .rePurchase");
					if(CartData.orderCheck == 'new') {
						rePurchase.innerText = "구매";
					} else {
						rePurchase.innerText = "재구매";
						rePurchase.setAttribute("style", "color: red;");
					}
					
				}
				var orderAccessButton = document.querySelector("#modalBox .orderAccessButton");
				orderAccessButton.setAttribute("onclick", "orderProcess("+cart_no_arr+", "+course_no_arr+")");
				var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
				modal.show();
			}
			
		}
		
		xhr.open("get", "../member/directOrder?course_no="+num, true);
		xhr.send();
	}
	
	function orderProcess(cart_no_arr, course_no_arr) {
		var xhr = new XMLHttpRequest();
		var	cartNoStr = "cart_no=" + cart_no_arr + "&";
		var courseNoStr = "course_no=" + course_no_arr;
		deleteWishAferOrder(course_no_arr);

		xhr.onreadystatechange = function(){
			if(xhr.readyState==4&&xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				if(data.result == 'complete') {
					modalBox.innerHTML = "";
					modalBox.innerText = "구매가 완료되었습니다.";
				} else {
					alert("오류가 발생했습니다.")
				}
			}
			location.reload();
		}
		xhr.open("post", "../member/orderProcess", true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send(cartNoStr + courseNoStr);
	}
	
	function deleteWishAferOrder(course_no) {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState==4&&xhr.status==200){
				var data = JSON.parse(xhr.responseText);
	
			}
		}
		xhr.open("get", "../member/deleteWishAferOrder?course_no=" + course_no, true);
		xhr.send();
		
		
	}
</script>

<script>
  const url = window.location.href;
  if(document.querySelector("#inputUrl") != null) {
	  const inputUrl = document.querySelector("#inputUrl");
	  inputUrl.value = url.substring(url.indexOf(/bseven/)+8);
  }
</script>
<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>