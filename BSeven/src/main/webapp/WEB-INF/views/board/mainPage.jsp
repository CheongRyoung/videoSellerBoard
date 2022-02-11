<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

			<!-- 메인 배너 -->
			<div class="row mt-3" id="bannerBax">
				<div class="col" style="padding: 0px;">
					<div id="mainBannerIndicators" class="carousel slide"
						data-bs-ride="carousel">
						<div class="carousel-indicators">
							<button type="button" data-bs-target="#mainBannerIndicators"
								data-bs-slide-to="0" class="active" aria-current="true"
								aria-label="Slide 1"></button>
							<button type="button" data-bs-target="#mainBannerIndicators"
								data-bs-slide-to="1" aria-label="Slide 2"></button>
							<button type="button" data-bs-target="#mainBannerIndicators"
								data-bs-slide-to="2" aria-label="Slide 3"></button>
						</div>
						<div class="carousel-inner">
							<c:forEach items="${bannerImageList }" var="bannerImage">
								<div class="carousel-item">
									<img src="/uploadFolder2/${bannerImage }" class="d-block w-100"
										alt="..." style="height: 200px;">
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>

			<!-- 강의 카테고리 -->
			<jsp:include page="../commons/global_category.jsp"></jsp:include>

			<!-- footer -->
			<jsp:include page="../commons/global_footer.jsp"></jsp:include>
		</div>

	</div>

	<script>
		const url = window.location.href;
		if (document.querySelector("#inputUrl") != null) {
			const inputUrl = document.querySelector("#inputUrl");
			inputUrl.value = url.substring(url.indexOf(/bseven/) + 8);
		}
		var searchParam = null;
		var categoryParam = null;
		var categoryName = "";
		var pageParam = 1;
		var queryString = null;
		var bodyHeight;
		
		function refreshCardList(obj) {
			var xhr = new XMLHttpRequest();

			if (obj != null) {
				category.nextElementSibling.remove();
				categoryName = obj.innerText;
				categoryParam = categoryName;
			}
			pageParam = 1;
			queryString = "";
			queryString += "pageNum=" + pageParam;
			if(categoryParam != null) {
				queryString += "&category_name=" + categoryParam;
			} 
			if(searchParam != null) {
				queryString += "&searchWord=" + searchParam;
			} 
			
			
			

			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var data = JSON.parse(xhr.responseText);
					var courseDataList = data.courseDataList;
					const category = document.getElementById("category");

					const section = document.createElement("div");
					section.setAttribute("class", "row m-3")
					const sectionCol = document.createElement("div");
					sectionCol.setAttribute("class", "col");
					const sectionColRow1 = document.createElement("div");
					sectionColRow1.setAttribute("class", "row mt-5");
					const sectionColRow1Col = document.createElement("div");
					sectionColRow1Col.setAttribute("class", "col");
					const sectionColRow1ColP = document.createElement("p");
					sectionColRow1ColP.setAttribute("class", "fw-bold");

					if (categoryName != "") {
						sectionColRow1ColP.innerText = categoryName;
					} else {
						sectionColRow1ColP.innerText = "최신 강의 순";
					}
					sectionColRow1Col.append(sectionColRow1ColP);
					sectionColRow1.append(sectionColRow1Col);

					const sectionColRow2 = document.createElement("div");
					sectionColRow2.setAttribute("class", "row mt-3");
					const sectionColRow2Col = document.createElement("div");
					sectionColRow2Col.setAttribute("class", "col");
					const sectionColRow2ColDiv = document.createElement("div");
					sectionColRow2ColDiv.setAttribute("class",
							"row row-cols-1 row-cols-md-3 g-4");
					sectionColRow2ColDiv.setAttribute("id", "cardBox");
					sectionColRow2Col.append(sectionColRow2ColDiv)
					sectionColRow2.append(sectionColRow2Col);
					sectionCol.append(sectionColRow1, sectionColRow2);
					section.append(sectionCol);
					category.after(section);

					const cardBox = document.getElementById("cardBox")

					for (var i = 0; i < courseDataList.length; i++) {
						const cardDiv = document.createElement("div");
						cardDiv.setAttribute("class", "col");

						const cardh = document.createElement("div");
						cardh.setAttribute("class", "card h-100");
						cardh.setAttribute("id",
								courseDataList[i].courseVo.course_no);
						cardh.style.cursor = "pointer";
						cardh.setAttribute("onclick", "moveLink(this)");

						const imgfile = document.createElement("img");
						imgfile.setAttribute("src", "/uploadFolder2/"
								+ courseDataList[i].imagefirst);
						imgfile.setAttribute("class", "card-img-top");
						imgfile.style.height = "200px";

						cardh.append(imgfile);

						const cardb = document.createElement("div");
						cardb.setAttribute("class", "card-body");

						const cardbRow = document.createElement("div");
						cardbRow.setAttribute("class", "row");

						const cardbRowCol1 = document.createElement("div");
						cardbRowCol1.setAttribute("class", "col");

						const cardTitle = document.createElement("h5");
						cardTitle.setAttribute("class", "card-title");
						cardTitle.style.marginBottom = "16px";
						cardTitle.innerText = courseDataList[i].courseVo.course_title;

						const cardPrice = document.createElement("p");
						cardPrice.setAttribute("class", "card-text");
						var price = courseDataList[i].courseVo.course_price
								.toLocaleString();
						cardPrice.innerText = price + "원";

						cardbRowCol1.append(cardTitle, cardPrice);

						const cardbRowCol2 = document.createElement("div");
						cardbRowCol2.setAttribute("class", "col text-end");

						const cardbRowCol2P1 = document.createElement("p");
						cardbRowCol2P1.setAttribute("class", "card-text");

						const cardbRowCol2P1I = document.createElement("i");
						cardbRowCol2P1I.setAttribute("class",
								"bi bi-heart-fill")

						cardbRowCol2P1.append(cardbRowCol2P1I, " "
								+ courseDataList[i].wishCount);

						const cardbRowCol2P2 = document.createElement("p");
						cardbRowCol2P2.setAttribute("class", "card-text");

						const cardbRowCol2P2I = document.createElement("i");
						cardbRowCol2P2I.setAttribute("class", "bi bi-eye");

						cardbRowCol2P2.append(cardbRowCol2P2I, " "
								+ courseDataList[i].courseVo.course_count);

						cardbRowCol2.append(cardbRowCol2P1, cardbRowCol2P2);
						cardbRow.append(cardbRowCol1, cardbRowCol2);
						cardb.append(cardbRow);
						cardh.append(imgfile, cardb);
						cardDiv.append(cardh);
						cardBox.append(cardDiv);
					}
				}
			}

			xhr.open("post", "./refreshMain", true);
			xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
			xhr.send(queryString);
		}

		function moveLink(obj) {
			const idValue = obj.getAttribute("id");
			location.href = "./courseDetail?course_no=" + idValue;
		}

		function searchProcess() {
			category.nextElementSibling.remove();
			const inputValue = document.getElementById("searchinput").value;
			if (inputValue == "") {
				searchParam = "";
			} else {
				searchParam =  inputValue;
			}
			refreshCardList();
		}
		
		function appendCard() {
			if(typeof cardBox == 'undefined') {
				return;
			}
			
			pageParam = pageParam + 1;
			queryString = "";
			queryString += "pageNum=" + pageParam;
			
			if(categoryParam != null) {
				queryString += "&category_name=" + categoryParam;
			} 
			if(searchParam != null) {
				queryString += "&searchWord=" + searchParam;
			} 
			
			bodyHeight = document.body.scrollHeight;
			
			var xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function(){
				if(xhr.readyState==4 && xhr.status==200){
					var data = JSON.parse(xhr.responseText);
					
					var courseDataList = data.courseDataList;
					
					for (var i = 0; i < courseDataList.length; i++) {
						const cardDiv = document.createElement("div");
						cardDiv.setAttribute("class", "col");

						const cardh = document.createElement("div");
						cardh.setAttribute("class", "card h-100");
						cardh.setAttribute("id",
								courseDataList[i].courseVo.course_no);
						cardh.style.cursor = "pointer";
						cardh.setAttribute("onclick", "moveLink(this)");

						const imgfile = document.createElement("img");
						imgfile.setAttribute("src", "/uploadFolder2/"
								+ courseDataList[i].imagefirst);
						imgfile.setAttribute("class", "card-img-top");
						imgfile.style.height = "200px";

						cardh.append(imgfile);

						const cardb = document.createElement("div");
						cardb.setAttribute("class", "card-body");

						const cardbRow = document.createElement("div");
						cardbRow.setAttribute("class", "row");

						const cardbRowCol1 = document.createElement("div");
						cardbRowCol1.setAttribute("class", "col");

						const cardTitle = document.createElement("h5");
						cardTitle.setAttribute("class", "card-title");
						cardTitle.style.marginBottom = "16px";
						cardTitle.innerText = courseDataList[i].courseVo.course_title;

						const cardPrice = document.createElement("p");
						cardPrice.setAttribute("class", "card-text");
						var price = courseDataList[i].courseVo.course_price
								.toLocaleString();
						cardPrice.innerText = price + "원";

						cardbRowCol1.append(cardTitle, cardPrice);

						const cardbRowCol2 = document.createElement("div");
						cardbRowCol2.setAttribute("class", "col text-end");

						const cardbRowCol2P1 = document.createElement("p");
						cardbRowCol2P1.setAttribute("class", "card-text");

						const cardbRowCol2P1I = document.createElement("i");
						cardbRowCol2P1I.setAttribute("class",
								"bi bi-heart-fill")

						cardbRowCol2P1.append(cardbRowCol2P1I, " "
								+ courseDataList[i].wishCount);

						const cardbRowCol2P2 = document.createElement("p");
						cardbRowCol2P2.setAttribute("class", "card-text");

						const cardbRowCol2P2I = document.createElement("i");
						cardbRowCol2P2I.setAttribute("class", "bi bi-eye");

						cardbRowCol2P2.append(cardbRowCol2P2I, " "
								+ courseDataList[i].courseVo.course_count);

						cardbRowCol2.append(cardbRowCol2P1, cardbRowCol2P2);
						cardbRow.append(cardbRowCol1, cardbRowCol2);
						cardb.append(cardbRow);
						cardh.append(imgfile, cardb);
						cardDiv.append(cardh);
						cardBox.append(cardDiv);
					}
					
				}
			}
			
			xhr.open("post", "./refreshMain", true);
			xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded")
			xhr.send(queryString);
		}
		
		window.onload = function() {
			document.querySelector(".carousel-item").classList.add("active")
			refreshCardList();
		}
		
		window.onscroll = function() {
			if (bodyHeight == document.body.scrollHeight){
				return;
			}
			
			if (window.scrollY > document.body.scrollHeight * 0.6) {
				appendCard();
		    	}
			}
	</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
</body>
</html>