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
</head>
<body>
    <div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
          <!-- nav 영역 -->  
          <jsp:include page="../commons/global_nav.jsp"></jsp:include>

          <!-- 회원가입 form -->
          <form action="./joinMemberProcess" method="post">
            <div class="row">
              <div class="col"></div>
              <div class="col-6">
                <div class="row mt-lg-5" style="max-width: 600px;">
                  <div class="col">
                    <div class="container-fluid">
                      <div class="row text-center mt-5">
                        <div class="col">
                          <h1>회원가입을 환영합니다</h1>
                        </div>
                      </div>
                      <div class="row mt-5">
                        <div class="col">
                          <span class="fs-6">아이디</span> 
                          <input type="text" class="form-control" placeholder="아이디를 입력하세요" name="member_id">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">비밀번호</span> 
                          <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="member_pw">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">닉네임</span> 
                          <input type="text" class="form-control" placeholder="닉네임을 입력하세요" name="member_nickname">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">이메일</span> 
                          <input type="text" class="form-control" placeholder="이메일를 입력하세요" name="member_email">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">생일</span> 
                          <input type="date" class="form-control" placeholder="생일을 입력하세요" name="member_birth">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">성별</span> 
                          <input type="radio" name="member_gender" value="M"> 남
                          <input type="radio" name="member_gender" value="F"> 여
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">핸드폰 번호</span> 
                          <input type="text" class="form-control" placeholder="핸드폰 번호를 입력하세요" name="member_phone">
                        </div>
                      </div>
                      <div class="row my-3">
                        <div class="col">
                          <input type="submit" class="btn btn-success container-fluid" value="가입하기">
                        </div>
                      </div>       
                    </div>
                  </div>
                </div>
              </div>
              <div class="col"></div>
            </div>

          </form>

          <!-- footer -->
          <jsp:include page="../commons/global_footer.jsp"></jsp:include>
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