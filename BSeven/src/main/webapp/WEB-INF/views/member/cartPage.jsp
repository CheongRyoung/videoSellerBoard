<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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


			<!-- 장바구니 -->
			<form>
				<div class="row my-5">
					<div class="col-1"></div>
					<div class="col">
						<h1 class="fw-bold">장바구니</h1>
						<div class="row mt-5 p-4"
							style="border-radius: 8px; border: #bdbdbd 1px solid;">
							<div class="col">
								<h5 class="fw-bold mb-5">내가 담은 강의</h5>
								<div class="row">
									<div class="col" id="cart">
									</div>
								</div>
							</div>
						</div>

						<div class="row mt-3 text-center">
							<div class="col">
								<span id="cartTotalCount"> 총개수 : </span>
							</div>
							<div class="col-5">

								<input type="button" onclick="deleteCart()" value="선택 삭제하기"
									class="btn btn-primary"> <input type="submit"
									formaction="./orderPage" value="선택 구매하기"
									class="btn btn-primary">
							</div>
							<div class="col">
								<span id="cartTotalSales"> 총합 : </span>
							</div>
						</div>
					</div>
					<div class="col-1"></div>
				</div>
			</form>

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
  var inputList = document.querySelectorAll("input[name='cart_no']");
  var sales = document.querySelectorAll(".sale")
  const totals = document.querySelector("#cartTotalSales");
  const counts = document.querySelector("#cartTotalCount");
  
  function handleTotal() {
    let total = 0;
    let count = 0;
    
	cartTotalSales.innerText = '총합: ' + total + "원";
	cartTotalCount.innerText = '총개수: ' + count;  
	
    inputList = document.querySelectorAll("input[name='cart_no']");
    for(var i=0; i<inputList.length; i++){
        if(inputList[i].checked) {
            var cost = sales[i].innerText.substring(0, sales[i].innerText.indexOf("원"));
            cost = cost.replace(/,/g, "");
            total += parseInt(cost);
            count += 1;
        }
    }
    total = total.toLocaleString();
    cartTotalSales.innerText = '총합: ' + total + "원";
    cartTotalCount.innerText = '총개수: ' + count;
  }
  
  function deleteCart() {
	  
	  var cart_no = "";
	  
	  inputList = document.querySelectorAll("input[name='cart_no']");
	  for(var i=0; i<inputList.length; i++){
		  if(inputList[i].checked) {
			  cart_no +=  "cart_no=" + inputList[i].getAttribute("value") + "&";
	  	}
	  }
	  var xhr = new XMLHttpRequest();
	  xhr.onreadystatechange = function(){
		  if(xhr.readyState==4 && xhr.status==200){		  
			  alert("장바구니에서 삭제되었습니다.")
			  handleTotal()
		  }
	  }
	  xhr.open("post", "./deleteCartProcess", true);
	  xhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
	  xhr.send(cart_no);
	 	
	  for(var i=0; i<inputList.length; i++){
		  if(inputList[i].checked) {
			  inputList[i].parentElement.parentElement.remove();
	  	}
	  }
  }
  
  function refreshCart() {
	  var xhr = new XMLHttpRequest();
	  
	  xhr.onreadystatechange = function() {
		  if(xhr.readyState==4&&xhr.status==200){
			  var data = JSON.parse(xhr.responseText);
			  var cartDataList = data.CartDataList;
			  const cart = document.getElementById("cart");
			  
			  if(data.result == 'Empty') {
				  const emptyMention = document.createElement("p");
				  emptyMention.innerText = "장바구니가 비었습니다."
				  cart.append(emptyMention);
			  } else {
				  for(var i=0; i<cartDataList.length; i++){
					  const cartBox = document.createElement("div");
				      cartBox.setAttribute("class", "row fs-6 mt-3 pb-2");
				      cartBox.style.borderBottom = "1px solid #dbdbdb";

				          const cartTitle = document.createElement("div");
				          cartTitle.setAttribute("class", "col-3");

				              const inputNo = document.createElement("input");
				              inputNo.setAttribute("type", "checkbox");
				              inputNo.setAttribute("value", cartDataList[i].cartVo.cart_no);
				              inputNo.setAttribute("name", "cart_no");
				              inputNo.setAttribute("onclick", "handleTotal()");
				              cartTitle.append(inputNo, " " + cartDataList[i].courseVo.course_title);
				          
				          const cartCategory = document.createElement("div");
				          cartCategory.setAttribute("class", "col-5");

				              //카테고리 for 문 작성
				              for(var j=0; j<cartDataList[i].categoryName.length; j++){
					              const categoryName = document.createElement("span");
					              categoryName.innerText = cartDataList[i].categoryName[j] + " ";
					              cartCategory.append(categoryName);
				              }

				          const cartTeacher = document.createElement("div");
				          cartTeacher.setAttribute("class", "col-2");
				          cartTeacher.innerText = cartDataList[i].teacherName;

				          const cartPrice = document.createElement("div");
				          cartPrice.setAttribute("class", "col-2 sale");

				          var price = cartDataList[i].courseVo.course_price.toLocaleString();
				          cartPrice.innerText = price + "원";
				      cartBox.append(cartTitle, cartCategory, cartTeacher, cartPrice)
				      cart.append(cartBox);
				  }
				  inputList = document.querySelectorAll("input[name='cart_no']");
				  sales = document.querySelectorAll(".sale");
			  } 
		  }
	  }
	  xhr.open("get", "./refreshCart", true);
	  xhr.send();
  }
  
  function deleteCartNodes(){
	  var parent = document.getElementById("cart");
	  const count = parent.childElementCount;
	  for (var i=0; i<count; i++){
		  parent.firstElementChild.remove();
	  }
  }
  
  window.onload = e => {
	  refreshCart()
  }

</script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p"
		crossorigin="anonymous"></script>
		<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
</body>
</html>