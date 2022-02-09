<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<title>Insert title here</title>
</head>
<body>
	<div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
            <!-- nav bar -->

                    <jsp:include page="../commons/global_nav.jsp"></jsp:include>
            <!-- 본문 -->
            <div class="row bg-light p-3" style="border-bottom: 1px solid rgb(167, 165, 165)">
                <div class="col-3" style="margin-left: 20px;">
                    ${boardData.member_nick }
                </div>
                <div class="col text-center">
                    <fmt:formatDate value="${boardData.boardVo.board_date }" pattern="yyyy-MM-DD hh:mm"/> 
                </div>
                <div class="col-3 text-end">
                    조회수 ${boardData.boardVo.board_viewCount }
                </div>
            </div>
            <div class="row mt-2">
                <div class="col">
                    <c:if test="${sessionUser.member_no == boardData.boardVo.member_no }">
	                    <a href="./updateBoard?board_no=${boardData.boardVo.board_no }" class="btn btn-primary">수정</a>
	                    <a href="./deleteBoardProcess?board_no=${boardData.boardVo.board_no }" class="btn btn-primary">삭제</a>
	                </c:if>
                </div>
                <div class="col text-end">
                    추천: ${boardData.board_like }
                </div>
            </div>
            <div class="row px-3">
                <div class="col">
                    ${boardData.boardVo.board_content }
                </div>
            </div>
            <div class="row px-3 mt-3">
                <div class="col">
                    <c:forEach items="${boardData.imageList }" var="image">
                        <img class="img-fluid" src="/uploadFolder2/${image.bci_uri }">
                    </c:forEach>
                </div>
            </div>
            <div class="row text-center">
                <div class="col">
                    <c:if test="${!empty sessionUser }">
		                <c:choose>
                            <c:when test="${like == 0 }">
                                <a href="./doLike?board_no=${boardData.boardVo.board_no }"><i class="bi bi-emoji-heart-eyes fs-1 text-danger"></i></a><br>
                            </c:when>
                            <c:otherwise>
                                <a href="./doLike?board_no=${boardData.boardVo.board_no }"><i class="bi bi-emoji-heart-eyes-fill fs-1 text-danger"></i></a><br>
                            </c:otherwise>
                        </c:choose>
		            </c:if>
                </div>
            </div>
            
            <!-- 리플 상단 -->
            <div class="row" style="border-bottom: 1px solid antiquewhite;">
                <div class="col">
                    <i class="bi bi-chat"></i>댓글(${replyCount })
                </div>
            </div>
            <!-- 리플내용 -->
            <c:forEach items="${replyList }" var="replyDate">
            <div class="row mt-2">
                <div class="col">
                    ${replyDate.memberData.member_nickname }
                    <span style="font-size: x-small;">(<fmt:formatDate value="${replyDate.reply.reply_date }" pattern="yy-MM-dd hh:mm"/>)</span>
                </div>
                <div class="col p-0">
                    
                </div>
                <div class="col text-end">
                    <c:if test="${sessionUser.member_no == replyDate.memberData.member_no }">
                        <a href="./updateR?board_no=${boardData.boardVo.board_no }" class="btn btn-primary">수정</a>
                        <a href="./deleteReplyProcess?board_no=${boardData.boardVo.board_no }&reply_no=${replyDate.reply.reply_no }" class="btn btn-primary">삭제</a>
                    </c:if>
                </div>
            </div>
            <div class="row mt-2 pb-3" style="border-bottom: 1px solid antiquewhite;">
                <div class="col">
                    ${replyDate.reply.reply_content }
                </div>
            </div>
            </c:forEach>
            <c:if test="${!empty sessionUser }">
                <form action="./insertBoardReply" method="post">
                    <div class="row p-3 mt-3" style="background-color: aliceblue;"">
                        <div class="col d-grid">
                            <textarea name="reply_content"></textarea>
                        </div>
                        <div class="col-1"  style="align-self: flex-end;">
                            <input type="hidden" name="board_no" value="${boardData.boardVo.board_no }">
                            <input  type="submit" value="리플달기">
                        </div>
                    </div>
                </form>
            </c:if>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>