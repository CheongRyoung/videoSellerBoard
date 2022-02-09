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
                                <div class="col text-end"><a href="../board/reviewWriteBoard?course_no=${myCourseData.courseVo.course_no }" style="font-size: 12px;">후기등록</a></div>
                                <div class="col text-end"><a href="./refundPage?order_no=${myCourseData.orderVo.order_no }" style="font-size: 12px;">환불하기</a></div>  
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
                                 <div class="col-2 text-end"><a href="#" style="font-size: 14px;">구매하기</a></div>
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