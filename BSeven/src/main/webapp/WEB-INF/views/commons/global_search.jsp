<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<form action="./CR_board" method="get">
	<div class="row mt-3"><!-- 검색 -->
		<div class="col">
			<select name="searchOption" class="form-select">
				<option value="title">제목</option>
				<option value="content">내용</option>
				<option value="nick">닉네임</option>
			</select>
		</div>
		<div class="col-8">
			<input name="searchWord" type="text" class="form-control" placeholder="검색할 단어를 입력하세요">
		</div>
		<div class="col d-grid">
			<input type="submit" value="검색" class="btn btn-primary">
		</div>
	</div>
</form>
