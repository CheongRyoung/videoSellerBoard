<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">


<title>Insert title here</title>
</head>
<body>
	<div style="max-width:1200px; margin: 0 auto">
		<div class="container-fluid">
					<jsp:include page="../commons/global_nav.jsp"></jsp:include>
			<div class="row">
				<div class="col"><!-- 글로벌 search -->
					<jsp:include page="../commons/global_search.jsp"></jsp:include>
				</div>
			</div>
		
			<div class="row">
				<div class="col mt-3">
		    		
						<div class="row row-cols-1 row-cols-md-3 g-4">
		            		<c:forEach items="${boardData }" var="board">
							  <div class="col">
							    <div class="card h-100">
							    	<c:if test="${board.fistImage != null }">
							    	<img src="/uploadFolder2/${board.fistImage.bci_uri }" class="img-fluid" style="height: 200px">
							    	</c:if>
							    	<c:if test="${board.fistImage == null }">
							    	<img src="/uploadFolder2/NoImage.png" class="img-fluid" style="height: 200px">
							    	</c:if>
							    	<div class="card-body">
							    		<div class="row">
							    			<div class="col-8">
							    				<h5 class="card-title">
							    				<c:choose>
							    					<c:when test="${fn: length(board.board.board_title) gt 10 }">
							    						<c:out value="${fn:substring(board.board.board_title, 0, 9)}">
        												</c:out>...
							    					</c:when>
							    					<c:otherwise>
							    						<c:out value="${board.board.board_title }"></c:out>
							    					</c:otherwise>
							    				</c:choose>
									      		</h5>
									      		<p class="card-text">
									      			<c:choose>
									      				<c:when test="${fn: length(board.board.board_content) gt 25 }">
									      					<c:out value="${fn: substring(board.board.board_content, 0, 24) }"></c:out>...
									      				</c:when>
									      				<c:otherwise>
									      					<c:out value="${board.board.board_content }"></c:out>
									      				</c:otherwise>
									      			</c:choose>
												</p>
									      	</div>
									      	<div class="col">
									      		<p class="text-end"><i class="bi bi-heart"></i> ${board.like }</p>
									      		<p class="text-end"><i class="bi bi-eye"></i> ${board.board.board_viewCount }</p>
									      	</div>
							      		</div>
							    	</div>
							    	<div class="card-footer">
							    	
							    		<div class="d-flex justify-content-between align-items-center">
							                <div class="btn-group">
							                  <a class="btn btn-sm btn-outline-secondary" href="./detailBoard?board_no=${board.board.board_no }">View</a>
							                  <c:if test="${!empty sessionUser && board.board.member_no == sessionUser.member_no }">
							                  <a class="btn btn-sm btn-outline-secondary" href="./updateBoard?board_no=${board.board.board_no }">Edit</a>
							                  </c:if>
							                </div>
							                <small class="text-muted">${board.member_nick }</small>
							                <small class="text-muted">${board.agoTime } ago</small>
						              	</div>
							    
							    	
							    	</div>
							   </div>

							  </div>
		            		</c:forEach>
		            	</div>
		           	
		         </div>
			</div>
			<div class="row ">
				<div class="col-3"></div>
				<div class="col mt-5">
					<nav aria-label="...">
					  <ul class="pagination justify-content-center">
					    
					    <c:choose>
					   		<c:when test="${startNum == 1 }">
					   			<li class="page-item disabled">
					      			<a class="page-link">앞으로</a>
					    		</li>					   		
					   		</c:when>
					   		<c:otherwise>
					   			<li class="page-item">
					      			<a class="page-link" href="./CR_board?pageNum=${startNum-1 }${search}">앞으로</a>
					    		</li>					   		
					   		</c:otherwise>
					   	</c:choose>
					    
					    <c:forEach begin="${startNum }" end="${endNum }" var="page">
					    <li class="page-item"><a class="page-link" href="./CR_board?pageNum=${page }${search}">${page }</a></li>
					   	</c:forEach>
					   	
					   	<c:choose>
					   		<c:when test="${endNum >= pageCount }">
					   			<li class="page-item disabled">
					      			<a class="page-link">뒤로</a>
					    		</li>					   		
					   		</c:when>
					   		<c:otherwise>
					   			<li class="page-item">
					      			<a class="page-link" href="./CR_board?pageNum=${endNum+1 }${search}">뒤로</a>
					    		</li>					   		
					   		</c:otherwise>
					   	</c:choose>
					    
					  </ul>
					</nav>
				</div>
				<div class="col-3 mt-5">
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<c:if test="${!empty sessionUser}">
					<a href="./CR_writeBoard" class="btn btn-primary ">글쓰기</a>
					</c:if>
				</div>
				</div>
			
			
			</div>
         
         
         
         </div>
		</div>
		
<script>
	const url = window.location.href;
	const inputUrl = document.querySelector("#inputUrl");
	inputUrl.value = url.substring(url.indexOf(/bseven/)+8);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>