<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <title>Document</title>
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

            <!-- 리뷰 보드 -->
                <div class="row my-5">
                    <div class="col-1"></div>  
                    <div class="col">
                        <h1 class="fw-bold">후기 등록</h1>
                        <div class="row mt-5 p-4">
                            <div class="col">
                                <!-- 강의 정보 -->
                                <div class="row pb-4"  style="border-bottom: #e0e0e0 10px solid;">
                                     <!-- 강의 썸네일 -->
                                    <div class="col">
                                        <img src="/uploadFolder2/${courseData.imageUrl }" class="img-fluid">
                                    </div>
                                    <!-- 강의 요약 -->
                                    <div class="col d-grid mt-3">
                                        <div class="row text-start">
                                            <div class="col-md-3"><span>강의제목: </span></div>
                                            <div class="col"><span>${courseData.courseVo.course_title }</span></div>
                                        </div>
                                        <div class="row text-start">
                                            <div class="col-md-3"><span>강사명: </span></div>
                                            <div class="col"><span>${courseData.teacherName } </span></div>
                                        </div>
                                        <div class="row text-start">
                                            <div class="col-md-3"><span>카테고리: </span></div>
                                            <div class="col"><span><c:forEach items="${courseData.categoryListVoList }" var="categoryList">${categoryList.category_name } </c:forEach> </span></div>
                                        </div>
                                        <div class="row text-start">
                                            <div class="col-md-3"><span>가격: </span></div>
                                            <div class="col"><span><fmt:formatNumber pattern="#,###" value="${courseData.courseVo.course_price }"/>원</span></div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 별점 -->
                                <div class="row mt-3">
                                  <div class="col text-center">
                                    <span>강의는 만족하셨나요?</span>
                                  </div>
                                </div>
								<form action="./insertReviewProcess" method="post">
                                <div class="row text-center">
                                    <div class="col">
                                      <label class="star" for="star1">★</label><input type="radio" class="checkStar" id="star1" value="1" name="reply_star">
                                      <label class="star" for="star2">★</label><input type="radio" class="checkStar" id="star2" value="2" name="reply_star">
                                      <label class="star" for="star3">★</label><input type="radio" class="checkStar" id="star3" value="3" name="reply_star">
                                      <label class="star" for="star4">★</label><input type="radio" class="checkStar" id="star4" value="4" name="reply_star">
                                      <label class="star" for="star5">★</label><input type="radio" class="checkStar" id="star5" value="5" name="reply_star">
                                    </div>
                                </div>
                                <div class="row">
                                  <div class="col text-center">
                                    <span style="font-size: small; color: #bdbdbd" id="chooseWord">선택해주세요</span>
                                  </div>
                                </div>

                                <div class="row mt-3">
                                  <div class="coltext-center d-grid">
                                    <textarea placeholder="강의평을 작성해주세요" name="reply_text"></textarea>
                                  </div>
                                </div>
                                <div class="row text-end mt-3">
                                  <div class="col">
                                  	<input type="hidden" value="${courseData.courseVo.course_no }" name="course_no">
                                    <input type="submit" value="후기 등록" class="btn btn-outline-primary">
                                  </div>
                                </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>          
           <!-- footer -->
           <jsp:include page="../commons/global_footer.jsp"></jsp:include>
            </div>
        </div>
            
<script>
    const url = window.location.href;
    if(document.querySelector("#inputUrl") != null) {
  	  const inputUrl = document.querySelector("#inputUrl");
  	  inputUrl.value = url.substring(url.indexOf(/bseven/)+8);
    }

    // 별점 구현
    const checkStar = document.querySelectorAll(".checkStar");
    const star = document.querySelectorAll(".star");
    const chooseWord = document.querySelector("#chooseWord");


function color(event) {
    const num = parseInt(event.target.value);
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

for(var i=0; i<checkStar.length; i++){
    checkStar[i].addEventListener("click", color);
}
   
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>