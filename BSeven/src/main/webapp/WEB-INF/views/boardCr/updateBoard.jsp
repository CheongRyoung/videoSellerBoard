<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="./updateBoardProcess" method="post" enctype="multipart/form-data">
		작성자: ${sessionUser.member_nickname }<br>
		제목: <input type="text" name="board_title" value="${boardVo.board_title }"><br>
		내용: <br>
		<textarea rows="10" cols="40" name="board_content">${boardVo.board_content }</textarea><br>
		<input type="file" accept="image/*" multiple name="uploadFiles"><br>	
		<input type="submit" value="작성완료">
		<input type="hidden" value="${boardVo.board_no }" name="board_no">
	
	</form>

</body>
</html>