<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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

			<!-- 환불 보드 -->

			<div class="row my-5">
				<div class="col-1"></div>
				<div class="col">
					<h1 class="fw-bold">환불 신청</h1>
					<div class="row mt-5 p-4">
						<div class="col">
							<div class="row" style="border-bottom: 4px solid #454545;">
								<div class="col">
									<h2>1. 반품 강의 확인</h2>
								</div>
							</div>
							<div class="row text-center"
								style="border-bottom: 1px solid #ddd;">
								<div class="col py-3" style="border-right: 1px solid #ddd;">
									<span>주문번호</span>
								</div>
								<div class="col-6 py-3" style="border-right: 1px solid #ddd;">
									<span>상품명</span>
								</div>
								<div class="col py-3" style="border-right: 1px solid #ddd;">
									<span>주문금액(수량)</span>
								</div>
								<div class="col py-3">
									<span>강의자</span>
								</div>
							</div>

							<!-- 강의 정보 가져올 테이블 -->
							<div class="row" style="border-bottom: 1px solid #ddd;">
								<div class="col-2 py-3 text-center"
									style="border-right: 1px solid #ddd;">
									<span>${refundData.orderVo.order_no }</span>
								</div>
								<div class="col-6 py-3" style="border-right: 1px solid #ddd;">
									<span>${refundData.courseVo.course_title }</span>
								</div>
								<div class="col-2 py-3 text-end"
									style="border-right: 1px solid #ddd;">
									<span><fmt:formatNumber pattern="#,###"
											value="${refundData.courseVo.course_price }" />원</span>
								</div>
								<div class="col-2 py-3 text-center">
									<span>강아지</span>
								</div>
							</div>
							<!-- 사유 작성 테이블 -->
							<form action="./refundProcess" method="post">
								<div class="row text-center"
									style="border-bottom: 1px solid #ddd;">
									<div class="col-2 py-3" style="border-right: 1px solid #ddd;">
										<div class="row">
											<div class="col">
												<span>사유입력</span>
											</div>
										</div>
										<div class="row mt-4">
											<div class="col">
												<span id="word" style="color: #bdbdbd">0</span><span
													style="color: #bdbdbd">/500</span>
											</div>
										</div>
									</div>
									<!-- form으로 보내야할 것-->
									<div class="col-8 d-grid py-3"
										style="border-right: 1px solid #ddd;">
										<textarea name="order_refund_text" rows="3" maxlength="500" onkeyup="wordCount(this)"
											></textarea>
									</div>
									<div class="col-2 py-3"></div>
								</div>
								<div class="row mt-3">
									<div class="col text-end">
										<a href="./myPage" class="btn btn-outline-primary">뒤로가기</a>
									</div>
									<div class="col">
										<input type="hidden" value="${refundData.orderVo.order_no }"
											name="order_no"> <input type="submit"
											class="btn btn-primary" value="신청하기">
									</div>
								</div>
								</form>
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
  
    function wordCount(object) {
        const str = object.value;
        const strLength = str.length;

        const word = document.querySelector("#word");
        word.innerText = strLength;
    }
    
</script>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
		<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
</body>
</html>