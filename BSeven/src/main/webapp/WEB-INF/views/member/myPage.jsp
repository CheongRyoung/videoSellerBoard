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
                      <div class="col">
                            <h5 class="fw-bold mb-5" >내가 듣는 강의</h5>
                            <c:forEach items="${myCourseDataList }" var="myCourseData">
                            <div class="row fs-6 mt-3 pb-2" style="border-bottom: 1px solid #dbdbdb;">
                                <div class="col-3" >${myCourseData.courseVo.course_title }</div>
                                <div class="col-5"><c:forEach items="${myCourseData.categoryName }" var="categoryName">${categoryName } </c:forEach></div>
                                <div class="col-1">${myCourseData.teacherName }</div>
                                <div class="col text-end reviewBox"><button class="btn btn-outline-success btn-sm" onclick="reviewBoardModal(${myCourseData.courseVo.course_no })">후기등록</button></div>
                                <div class="col text-end"><a href="./refundPage?order_no=${myCourseData.orderVo.order_no }" class="btn btn-outline-danger btn-sm">환불하기</a></div>  
                            </div>
                            </c:forEach>
                      </div>
                  </div>

                  <!-- 관심 강의 -->
                  <div class="row my-5  p-4" style="border-radius: 8px; border: #bdbdbd 1px solid;">
                    <div class="col">
                          <h5 class="fw-bold mb-5" >관심 강의</h5>
                            <c:forEach items="${myWishDataList }" var="myCourseData">
                            <div class="row fs-6 mt-3 pb-2" style="border-bottom: 1px solid #dbdbdb;">
                                <div class="col-3" >${myCourseData.courseVo.course_title }</div>
                                <div class="col-5"><c:forEach items="${myCourseData.categoryName }" var="categoryName">${categoryName } </c:forEach></div>
                                <div class="col-2">${myCourseData.teacherName }</div>
                                 <div class="col-2 text-end"><a class="btn btn-outline-primary btn-sm" onclick="reviewBoardModal(">구매하기</a></div>
                            </div>
                            </c:forEach>
                    </div>
                  </div>

                  <!-- 내가 올린 강의 -->
                  <c:if test="${!checkTeacher }">
                  <div class="row my-5  p-4" style="border-radius: 8px; border: #bdbdbd 1px solid;">
                    <div class="col">
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
						<div class="col" id="reviewButtonBox">
							<button type="button" class="btn btn-outline-primary"
								onclick="insertReview()">후기 등록</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-1"></div>
	</div>
</div>
<script type="text/javascript">
 
var myModalEl = document.querySelector('#exampleModal');
myModalEl.addEventListener('hidden.bs.modal', function (event) {
	var modalBox = document.getElementById("modalBox")
	modalBox.innerHTML = "";
	})
	
function reviewBoardModal(num) {
	
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
	xhr.open("get", "../board/reviewWriteBoardModal?course_no=" + num, false);
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