<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    function checkForm() {
    	var inputThumbnail = document.getElementById("inputThumbnail");
    	var categoryBox = document.querySelectorAll(".categoryBox");
    	var floatingCourseName = document.getElementById("floatingCourseName");
    	var floatingCourseDate = document.getElementById("floatingCourseDate");
    	var floatingCourseSale = document.getElementById("floatingCourseSale");
    	var floatingCourseContent = document.getElementById("floatingCourseContent");
    	var formBox = document.getElementById("formBox");
    	var coursevideo = document.querySelectorAll(".coursevideo");
    	var courseTitle = document.querySelectorAll(".courseTitle");
    	
    	if(inputThumbnail.files[0] == null){
    		alert("썸네일을 등록해주세요");
    		return
    	}
    	var result = false;
    	for(category of categoryBox){
    		if(category.checked) {
    			result = true;
    		}	
    	}
    	if(!result) {
    		alert("카테고리를 선택해주세요");
    		return;
    	}
    	if(floatingCourseName.value == "") {
    		alert("강의명을 입력해주세요");
    		return;
    	}
    	if(floatingCourseDate.value == "") {
    		alert("강의기간을 입력해주세요");
    		return;
    	}
    	if(floatingCourseSale.value == "") {
    		alert("강의가격을 입력해주세요");
    		return;
    	}
    	if(floatingCourseContent.value == "") {
    		alert("강의설명을 입력해주세요");
    		return;
    	}
    	var result = false;
    	for(title of courseTitle){
    		if(title.value != "") {
    			result = true;
    		}	
    	}
    	if(!result) {
    		alert("강의별 제목을 등록해주세요");
    		return;
    	}
    	
    	var result = false;
    	for(video of coursevideo){
    		if(video.files[0] != null) {
    			result = true;
    		}	
    	}
    	if(!result) {
    		alert("강의 영상을 등록해주세요");
    		return;
    	}
    	formBox.submit();

    }
    
    </script>

</head>
<body>
    <div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
            <!-- nav 영역 -->  
                <jsp:include page="../commons/global_nav.jsp"></jsp:include>


            <!-- 강의 카테고리 -->
            <jsp:include page="../commons/global_category.jsp"></jsp:include>
            
            <!-- 강의 업로드 페이지 -->
            <div class="row my-5">
              <div class="col-1"></div>
              <div class="col">
                <span>강의 등록</span>
                <!-- form 시작-->
                <form action="./uploadCourseProcess" method="post" enctype="multipart/form-data" id="formBox">
                  <div class="row mt-3">
                      <div class="col-lg-6 col-md-12">
                          <!--이미지 미리보기-->
                          <img src="/bseven/resources/img/imagePreview.jpg" id="previewImage" class="img-fluid img-thumbnail d-grid" style="height: 300px;">
                          <input type="file" style="display: block;" id="inputThumbnail" name="thumbnail" class="form-control form-control-sm" accept="image/*">
                      </div>
                      <div class="col-md-12 col-lg-6  d-grid">
                        <div class="row">
                          <div class="col">
							<span>카테고리를 선택해주세요</span>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <div class="col">
                          <c:forEach items="${categoryList }" var="category">
                            <input type="checkbox" value="${category.category_no }" name="category_no" class="categoryBox"><span style="font-size: 14px; margin-right: 15px" > ${category.category_name }</span> 
                          	</c:forEach>
                          </div>
                        </div>
                        <div class="row">
                          <div class="col">
                            <div class="form-floating my-2">
                              <input type="text" class="form-control" id="floatingCourseName" placeholder="이것이... 자바...?!" name="course_title">
                              <label for="floatingCourseName">강의명</label>
                            </div>
                            <div class="form-floating my-2">
                              <c:if test="${!empty sessionUser }">
                              <input type="text" class="form-control" id="floatingTeacherName" placeholder="나의 이름은..." value="${sessionUser.member_nickname }" readonly >
                              </c:if>
                              <label for="floatingTeacherName">강사 이름</label>
                            </div>
                            <div class="form-floating my-2">
                              <input type="number" class="form-control" id="floatingCourseDate" placeholder="수강 기간은??" name="course_period">
                              <label for="floatingCourseDate">강의 기간</label>
                            </div>
                            <div class="form-floating my-2">
                              <input type="number" class="form-control" id="floatingCourseSale" placeholder="가격 제시좀" name="course_price">
                              <label for="floatingCourseSale">강의 가격</label>
                            </div>
                          </div>
                        </div>
                      </div>
                  </div>

                    <!-- 강의 상세 소개 글-->
				<div class="row p-3 mt-3" style="background-color: aliceblue;">
                      <div class="col d-grid">
                          <textarea name="course_content" rows="5" id="floatingCourseContent"></textarea>
                      </div>
                  </div>
                  <div class="row mt-4">
                    <div class="col">
                      <span>추가 버튼을 통해 목차별로 강의 영상을 올려주세요</span>
                    </div>
                  </div>

                  <div class="row mt-3">
                    <div class="col-2">
                          <button class="btn btn-outline-primary p-1 px-2" id="addVideo">추가</button>
                          <button class="btn btn-outline-danger p-1 px-2" id="deleteVideo">삭제</button>
                    </div>
                    <div class="col-8" id="videoPlus">
                      <div class="row mb-2" id="videoNode">
                        <div class="col d-grid">
                          <input type="text" class="form-text px-2  mt-0 courseTitle" name="courseTitle" placeholder="강의 목차 제목">
                        </div>
                        <div class="col  d-grid">
                          <input type="file" class="coursevideo" name="coursevideo"  value="강의 영상" style="border: 1px solid #bdbdbd;">
                        </div>
                      </div>
                    </div>
                    <div class="col text-end" style="align-self: flex-end;">
                      <button type="button" onclick="checkForm()" class="btn btn-primary">강좌 등록</button>
                    </div>
                  </div>
                </form>
              </div>
              <div class="col-1"></div>
            </div>
            <jsp:include page="../commons/global_footer.jsp"></jsp:include>
            </div>
        </div>
    
    
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">업로드중...</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="progressBar" style="width: 50%; background-color: #ddd;">123</div>
        <button onclick="stopUpload()">업로드 중지</button>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary">Close</button>
      </div>
    </div>
  </div>
</div>
<script>
const url = window.location.href;
if(document.querySelector("#inputUrl") != null) {
	  const inputUrl = document.querySelector("#inputUrl");
	  inputUrl.value = url.substring(url.indexOf(/bseven/)+8);
}
const inputThumbnail = document.getElementById("inputThumbnail");
const previewImage = document.getElementById("previewImage");
const addVideo = document.getElementById("addVideo");
const videoPlus = document.getElementById("videoPlus");
const videoNode = document.getElementById("videoNode");


function readImage(event) {
  var urlsrc = URL.createObjectURL(event.target.files[0]);
  previewImage.src = urlsrc;
  }


inputThumbnail.addEventListener("change", readImage)


function handlevideoInputPlus(event){
	  event.preventDefault();
	  var node = document.importNode(videoNode, true);
	  videoPlus.appendChild(node); 
	}

function handlevideoInputDelete(event) {
	  event.preventDefault();
	  document.querySelector("#videoPlus").lastElementChild.remove()
	}

addVideo.addEventListener("click", handlevideoInputPlus);
deleteVideo.addEventListener("click", handlevideoInputDelete)

var myModalEl = document.querySelector('#exampleModal');

var transfer = false;

function stopUpload() {
	transfer = false;
	var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
	modal.hide();
	alert("업로드가 중지되었습니다.");
}

function uploadProcess() {
	transfer = true;
	var modal = bootstrap.Modal.getOrCreateInstance(myModalEl);
	modal.show();

	var formData = new FormData();
	var fileBox = document.querySelectorAll(".coursevideo");
	for(var i=0; i<fileBox.length; i++) {
		formData.append('video', fileBox[i].files[0]);
	}
	
	var xhr = new XMLHttpRequest();
	
	xhr.onload = () => {
		alert("업로드가 완료되었습니다.");
		location.href = "../member/myPage"
	};
	
	xhr.onabort = () => {
		alert("업로드가 취소되었습니다.")};
	
	xhr.upload.addEventListener('progress', function(e) { 
		if(transfer) {
		let percentage = (e.loaded / e.total * 100);
		var progressBar = document.querySelector(".progressBar");
		progressBar.innerText = Math.floor(percentage) + "%";
		progressBar.style.width = percentage+"%";
		} 
	})

	xhr.onreadystatechange = function() {
		if(xhr.readyState==4 && xhr.status==200){
		}
	}
	xhr.open("post", "./uploadProgressBarTest");
	xhr.send(formData);
}	

</script>
<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>