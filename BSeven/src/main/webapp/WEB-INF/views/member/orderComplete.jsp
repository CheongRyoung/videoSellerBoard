<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>


<script type="text/javascript">

if(confirm("구매가 완료되었습니다. \n 강의실로 이동하겠습니까?")){
	document.location.href="./myCoursePage";
} else {
	document.location.href="./myPage";
}

</script>
</body>
</html>