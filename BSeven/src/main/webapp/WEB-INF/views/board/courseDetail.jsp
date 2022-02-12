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
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<title>Document</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
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

    
   window.addEventListener("DOMContentLoaded", e => {
   	reviewRefresh();
    })
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
<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
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
				<div class="col" id="courseBoard">
					<div class="row mt-3">
						<div class="col-md-12 col-lg-6">
							<img src="/uploadFolder2/${courseData.image }" id="image"
								class="img-fluid img-thumbnail" style="height: 300px;">
						</div>
						
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
								<div class="col-3">
									<c:choose>
										<c:when test="${wishNum > 0 }">
											<i class="bi bi-heart-fill fs-3" onclick="wishState()"
												id="heart"></i>
										</c:when>
										<c:otherwise>
											<i class="bi bi-heart fs-3" onclick="wishState()"
												id="heart"></i>
										</c:otherwise>
									</c:choose>
									<i class="bi bi-bar-chart-line fs-3 m-3" onclick="openChart()"></i>
								</div>
								<div class="col">
									<c:choose>
										<c:when test="${orderNum > 0 }">
											<a class="btn btn-primary disabled">이미 구매하였습니다.</a>
										</c:when>
										<c:otherwise>
											<button onclick="addCart()" class="btn btn-outline-primary">장바구니</button>
											<button class="btn btn-outline-primary" onclick="orderMoal()">구매하기</button>
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
							<i class="bi bi-chat"></i> <span>후기(</span><span id="reviewCount">${fn:length(courseData.replyDataList) })</span>
						</div>
						<div class="col p-2 text-end" id="reviewBoardOpendiv">

						</div>
					</div>
					<div class="row">
						<div class="col" id="reviewSection"></div>
					</div>
				</div>
				<div class="col-1"></div>
			</div>
			<!-- footer -->
			<jsp:include page="../commons/global_footer.jsp"></jsp:include>
		</div>
	</div>
	
	<jsp:include page="../commons/modalData.jsp"></jsp:include>
	
	
	<script type="text/javascript">
	
	var myModalEl = document.querySelector('#exampleModal');
	myModalEl.addEventListener('hidden.bs.modal', function (event) {
		var modalBox = document.getElementById("modalBox")
		modalBox.innerHTML = "";
		})
	
	
	var cart_no_arr = new Array();
	var course_no_arr = new Array();
	var starNum = "";
	var courseNum = ${courseData.courseVo.course_no };

	function reviewRefresh() {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if(xhr.readyState==4&&xhr.status){
				var date = JSON.parse(xhr.responseText);
				var reviewSection = document.getElementById("reviewSection");
				reviewSection.innerHTML = "";
				
				
				if(date.result != 'existence') {
					var reviewBoardOpendiv = document.getElementById("reviewBoardOpendiv");
					reviewBoardOpendiv.innerHTML = "";
					var reviewButton = document.createElement("button");
					
					reviewButton.setAttribute("type", "button");
					reviewButton.setAttribute("class", "btn btn-outline-primary");
					reviewButton.setAttribute("onclick", "reviewModal("+${courseData.courseVo.course_no }+")");
					reviewButton.innerText = "후기 등록";
					reviewBoardOpendiv.append(reviewButton);
				}
				
				var reviewCount = document.getElementById("reviewCount");
				reviewCount.innerText = date.courseData.replyDataList.length + ")";
				
				
				
				for(replyData of date.courseData.replyDataList) {
					var reviewBoardset = document.getElementById("reviewBoardset");
					var reviewBoardMemberNick = document.querySelector("#reviewBoardset .reviewBoardMemberNick");
					reviewBoardMemberNick.innerText = replyData.memberVo.member_nickname;
					var reviewBoardDate = document.querySelector("#reviewBoardset .reviewBoardDate");
					var transDateforStr = new Date(replyData.replyVo.reply_date);
					reviewBoardDate.innerText = transDateforStr.getFullYear() - 2000 + ". " + (transDateforStr.getMonth() +1) + ". " + transDateforStr.getDate() + " " + String(transDateforStr.getHours()).padStart(2, "0") + ":" + String(transDateforStr.getMinutes()).padStart(2, "0");
					var reviewBoardText = document.querySelector("#reviewBoardset .reviewBoardText");
					reviewBoardText.innerText = replyData.replyVo.reply_text;
					var yellowStar = document.querySelector("#reviewBoardset .yellowStar");
					yellowStar.innerText = "";
					for(var i=1; i<=replyData.replyVo.reply_star; i++) {
						yellowStar.innerText += "★";
					}
					var emptyStar = document.querySelector("#reviewBoardset .emptyStar");
					emptyStar.innerText = "";
					for(var i=1; i<=(5 - replyData.replyVo.reply_star); i++) {
						emptyStar.innerText += "★";
					}
					
					var reviewControl = document.querySelector("#reviewBoardset .reviewControl");
					reviewControl.innerHTML = "";
					
					if (date.sessionUser == replyData.replyVo.member_no) {
						var reviewReviseButton = document.createElement("button");
						reviewReviseButton.setAttribute("class", "btn btn-outline-primary")
						reviewReviseButton.setAttribute("onclick", "updateReviewModal("+replyData.replyVo.reply_no+")");
						reviewReviseButton.innerText = "수정";
						var reviewDeleteButton = document.createElement("button");
						reviewDeleteButton.setAttribute("class", "btn btn-outline-danger");
						reviewDeleteButton.innerText = "삭제";
						reviewDeleteButton.setAttribute("onclick", "deleteReviewAnswer("+replyData.replyVo.reply_no+")");
						reviewControl.append(reviewReviseButton, reviewDeleteButton);
					}
					x = replyData.replyVo;
					var reviewClon = reviewBoardset.firstElementChild.cloneNode(true);
					reviewSection.appendChild(reviewClon);
				}
				var reviews = document.querySelectorAll("#reviewSection > div");
					for(var i=0; i<reviews.length; i++) {
						if ( (i+1)%2 == 0) {
							reviews[i].style.backgroundColor = "#dddd";
						}
					}
			}
		}
		
		xhr.open("get", "./reviewRefresh?course_no="+ ${courseData.courseVo.course_no }, true);
		xhr.send();
	}
	
	function hideModal(){
		var modal = bootstrap.Modal.getInstance(myModalEl);
		modal.hide();
	}
	
	function orderMoal(){
		var course_no = url.substring(url.indexOf('no') + 3);
		var xhr = new XMLHttpRequest();
		
		cart_no_arr = new Array();
		course_no_arr = new Array();
		
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
				}
				var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
				modal.show();
			}
			
		}
		
		xhr.open("get", "../member/directOrder?course_no="+course_no, true);
		xhr.send();
	}
	
	function orderProcess(cart_no_arr, course_no_arr) {
		var xhr = new XMLHttpRequest();
		var cartNoStr = "";
		for (cart_no of cart_no_arr) {
			cartNoStr += "cart_no=" + cart_no + "&";
		}
		var courseNoStr = "";
		for (course_no of course_no_arr){
			courseNoStr += "course_no=" + course_no + "&";
		}
		
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
		}
		xhr.open("post", "../member/orderProcess", true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
		xhr.send(cartNoStr + courseNoStr);
	}
	
	function reviewModal(course_no){
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4&&xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				
				if(data.result == "login Req"){
					alert("로그인 해줘");
					return;
				}
				var reviewCourseData = data.courseData;
				
				var reviewPage = document.getElementById("reviewPage");
				var mainNode = reviewPage.firstElementChild.cloneNode(true);
				var modalBox = document.getElementById("modalBox");
				modalBox.innerHTML = "";
				modalBox.append(mainNode);
				
				var reviewImgBox = document.getElementById("reviewImgBox");
				reviewImgBox.setAttribute("src", "/uploadFolder2/"+ reviewCourseData.imageUrl +"");
				var reviewTitleBox = document.getElementById("reviewTitleBox");
				reviewTitleBox.innerText = reviewCourseData.courseVo.course_title;
				var reviewTeacherBox = document.getElementById("reviewTeacherBox");
				reviewTeacherBox.innerText = reviewCourseData.teacherName;
				var reviewCategoryBox = document.getElementById("reviewCategoryBox");
				var categoryList = "";
				for (categoryName of reviewCourseData.categoryListVoList) {
					categoryList += categoryName.category_name;
				}
				reviewCategoryBox.innerText = categoryList;
				var reviewPriceBox = document.getElementById("reviewPriceBox");
				var reviewPrice = reviewCourseData.courseVo.course_price
				reviewPriceBox.innerText = reviewPrice.toLocaleString() + "원";

				var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
				modal.show();
			}
		}
		xhr.open("get", "../board/reviewWriteBoardModal?course_no=" + course_no, false);
		xhr.send();
	}
	function insertReview() {
		var xhr = new XMLHttpRequest();
		var reviewSting = "reply_text=" + document.querySelector("#modalBox #reply_text").value + "&reply_star=" + starNum + "&course_no=" + ${courseData.courseVo.course_no };
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState==4&& xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				if(data.result = 'success'){
					var modalBox = document.querySelector("#modalBox");
					modalBox.innerHTML = "";
					modalBox.innerText = "리뷰작성이 완료되었습니다."
					
				}
				reviewRefresh();
			}
		}
		xhr.open("post", "./insertReviewProcessModal", true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send(reviewSting);
		
	}
	
	function deleteReviewAnswer(replyNo) {
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
			reviewRefresh();
		}
		xhr.open("get", "./deleteReview?reply_no=" + replyNo, true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send();
	}
	
	function updateReviewModal(replyNo){
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				reviewModal(courseNum);
				document.querySelector("#modalBox #reply_text").value = data.replyVo.reply_text;
				document.querySelector("#modalBox button").setAttribute("onclick", "updateReview("+replyNo+")");
				console.log(replyNo);
				document.querySelector("#modalBox button").innerText = "후기 수정";
				color(data.replyVo.reply_star);
			}
		}
		xhr.open("get", "./updateReviewModal?reply_no="+replyNo, true);
		xhr.send();
	}
	
	function updateReview(num) {
		var xhr = new XMLHttpRequest();
		var reviewSting = "reply_no="+ num + "&reply_text=" + document.querySelector("#modalBox #reply_text").value + "&reply_star=" + starNum + "&course_no=" + ${courseData.courseVo.course_no };

		xhr.onreadystatechange = function() {
			if(xhr.readyState==4&& xhr.status==200){
				var data = JSON.parse(xhr.responseText);
				if(data.result = 'success'){
					var modalBox = document.querySelector("#modalBox");
					modalBox.innerHTML = "";
					modalBox.innerText = "리뷰수정이 완료되었습니다."
					
				}
				reviewRefresh();
			}
		}
		xhr.open("post", "./updateReview", true);
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send(reviewSting);
		
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
	<script type="text/javascript">
	
	function openChart() {
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function(){
			if(xhr.readyState==4 && xhr.status==200){
				var restApidata = JSON.parse(xhr.responseText);
				var maleRestApidata = restApidata.chartData.ageMaleDataList;
				var fmaleRestApidata = restApidata.chartData.ageFemaleDataList;
				
				var maledata = [0, 0, 0, 0, 0, 0];
				var fmaledata = [0, 0, 0, 0, 0, 0];
				
				for (male of maleRestApidata){
					if ( male.AGE < 20) {
						maledata[0] = maledata[0] + male.CNT;
					} else if( male.AGE < 30) {
						maledata[1] = maledata[1] + male.CNT;
					} else if( male.AGE < 40) {
						maledata[2] = maledata[2] + male.CNT;
					} else if( male.AGE < 50) {
						maledata[3] = maledata[3] + male.CNT;
					} else if( male.AGE < 50) {
						maledata[4] = maledata[4] + male.CNT;
					} else {
						maledata[5] = maledata[5] + male.CNT;
					}
				}
				
				for (female of fmaleRestApidata){
					if ( female.AGE < 20) {
						fmaledata[0] = fmaledata[0] + female.CNT;
					} else if( male.AGE < 30) {
						fmaledata[1] = fmaledata[1] + female.CNT;
					} else if( male.AGE < 40) {
						fmaledata[2] = fmaledata[2] + female.CNT;
					} else if( male.AGE < 50) {
						fmaledata[3] = fmaledata[3] + female.CNT;
					} else if( male.AGE < 50) {
						fmaledata[4] = fmaledata[4] + female.CNT;
					} else {
						fmaledata[5] = fmaledata[5] + female.CNT;
					}
				}		
				
				const labels = ['10대', '20대', '30대', '40대', '50대', '60대'];
				const data = {
				  labels: labels,
				  datasets: [{
				    label: 'Male',
				    data: maledata,
				    backgroundColor: [
				      'rgba(255, 99, 132, 0.2)',
				      'rgba(255, 99, 132, 0.2)',
				      'rgba(255, 99, 132, 0.2)',
				      'rgba(255, 99, 132, 0.2)',
				      'rgba(255, 99, 132, 0.2)',
				      'rgba(255, 99, 132, 0.2)'
				    ],
				    borderColor: [
				      'rgb(255, 99, 132)',
				      'rgb(255, 99, 132)',
				      'rgb(255, 99, 132)',
				      'rgb(255, 99, 132)',
				      'rgb(255, 99, 132)',
				      'rgb(255, 99, 132)'
				      
				    ],
				    borderWidth: 1
				  },
		          {
				    label: 'Female',
				    data: fmaledata,
				    backgroundColor: [
				      'rgba(255, 159, 64, 0.2)',
				      'rgba(255, 159, 64, 0.2)',
				      'rgba(255, 159, 64, 0.2)',
				      'rgba(255, 159, 64, 0.2)',
				      'rgba(255, 159, 64, 0.2)',
				      'rgba(255, 159, 64, 0.2)'
				    ],
				    borderColor: [
				      'rgb(255, 159, 64)',
				      'rgb(255, 159, 64)',
				      'rgb(255, 159, 64)',
				      'rgb(255, 159, 64)',
				      'rgb(255, 159, 64)',
				      'rgb(255, 159, 64)'
				    ],
				    borderWidth: 1
				  }]
				};
				
				const config = {
						  type: 'bar',
						  data: data,
						  options: {
						    scales: {
						      y: {
						        beginAtZero: true
						      }
						    }
						  },
						};

				var modalBox = document.getElementById("modalBox");
				var chartBox = document.getElementById("chartBox");
				var cloneChartBox = chartBox.firstElementChild.cloneNode(true);
				modalBox.append(cloneChartBox);
				var cloneCanvas = document.querySelector("#modalBox canvas")
				cloneCanvas.id = 'myChart1';
				

				var myChart = new Chart(
					    document.getElementById('myChart1'),
					    config
					  );

				var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
				modal.show();
			}
		}
		xhr.open("get", "./getCourseChartData?course_no=" + courseNum, true);
		xhr.send();
		
	}

	</script>
</body>
</html>