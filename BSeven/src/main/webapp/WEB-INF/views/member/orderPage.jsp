<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
    <title>Document</title>
 
</head>
<body>
    <div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
            <!-- nav 영역 -->  
            <jsp:include page="../commons/global_nav.jsp"></jsp:include>


            <!-- 강의 카테고리 -->
            <jsp:include page="../commons/global_category.jsp"></jsp:include> 


        <!-- 결제 페이지 -->
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
                            <div class="row mt-2">
						<div class="col">
							<p class="text-danger">재구매시 수강기간이 연장됩니다</p>
						</div>
					</div>
                            <div class="row" style="border: 1px solid #bdbdbd; border-radius: 5px;">
                                <div class="col p-5 pb-3">
                                    <c:forEach items="${selectCartDataList }" var="CartData">
                                    <div class="row my-2 py-2" style="border-bottom: 1px solid #bdbdbd;">
                                    	<input type="hidden" name="course_no" value="${CartData.courseVo.course_no}">
                                    	<input type="hidden" name="cart_no" value="${CartData.cartVo.cart_no}">
                                        <div class="col-3" >${CartData.courseVo.course_title } </div>
                                        <div class="col-5"><c:forEach items="${CartData.categoryName }" var="categoryName">${categoryName } </c:forEach> </div>
                                        <div class="col-2">${CartData.teacherName}</div>
                                        <div class="col-2 sale"><fmt:formatNumber pattern="#,###" value="${CartData.courseVo.course_price }"/>원</div>
                                    </div>
                                    </c:forEach>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-5">
                        <div class="col-6">
                            <p>주문자 정보</p>
                            <div class="row" style="border-top: 1px solid #bdbdbd; border-bottom: 1px solid #bdbdbd;">
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
                                    <input class="form-check-input" type="radio" name="Radios" id="Radios1" value="계좌이체">
                                    <label class="form-check-label" for="Radios1">
                                      계좌이체
                                    </label>

                                  </div>
                                  <div class="form-check">
                                    <input class="form-check-input" type="radio" name="Radios" id="Radios2" value="카드결제">
                                    <label class="form-check-label" for="Radios2">
                                      카드결제
                                    </label>
                                  </div>
                                  <div class="form-check">
                                    <input class="form-check-input" type="radio" name="Radios" id="Radios3" value="무통장입금">
                                    <label class="form-check-label" for="Radios3">
                                      무통장입금
                                    </label>
                                  </div>
                            </div>
                            <div class="row mt-1">
                                  <div class="col d-grid"><a href="./cartPage" class="btn btn-primary">취소하기</a></div>
                                  <div class="col d-grid"><input type="submit" value="결제하기" class="btn btn-primary"></div>
                            </div>
                        </div>
                    </div>
                    
                </div>
                <div class="col-1"></div>
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
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>