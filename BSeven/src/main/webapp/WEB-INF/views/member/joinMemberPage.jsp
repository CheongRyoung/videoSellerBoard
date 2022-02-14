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
    <script type="text/javascript">
    	function checkJoinMember(){
    		const checkIDResult = document.getElementById("checkIDResult");
    		const idBox = document.getElementById("idBox");
    		const passwordBox = document.getElementById("passwordBox");
    		const nickBox = document.getElementById("nickBox");
    		const emailBox = document.getElementById("emailBox");
    		const phoneBox = document.getElementById("phoneBox");
    		const fm = document.getElementById("fm");
    		
    		if (checkIDResult.innerText == '중복된 아이디입니다.') {
    			alert("중복된 아이디입니다.");
    			idBox.focus();
    			return;
    		}
    		
    		let regExpID = /^[a-z]+[a-z0-9]{5,19}$/g;
    		
    		if (!regExpID.test(idBox.value)) {
    			alert("아이디는 영문자와 숫자 6~20자 입니다.");
    			idBox.focus();
    			return;
    		}
    		
    		let regExpPW = /^(?=.*\d)(?=.*[a-zA-Z])[0-9a-zA-Z]{8,16}$/;
    		
    		if (!regExpPW.test(passwordBox.value)) {
    			alert("비밀번호는 8 ~ 16자 영문, 숫자 조합 입니다.")
    			passwordBox.focus();
    			return;
    		}
    		
    		let regExpNI = /[^a-z|A-Z|0-9|ㄱ-ㅎ|가-힣]/g
    		
    		if (!regExpNI.test(nickBox.value)) {
    			alert("닉네임에서 특수문자를 제외해주세요.")
    			nickBox.focus();
    			return;
    		}
    		
    		let regExpEM = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		
    		if (!regExpEM.test(emailBox.value)) {
    			alert("이메일 형식이 맞지 않습니다.")
    			emailBox.focus();
    			return;
    		}
    		
    		let regExpPH = /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/;
    		
    		if (!regExpPH.test(phoneBox.value)) {
    			alert("핸드폰 형식이 맞지 않습니다. '-'를 제외하고 입력해주세요")
    			phoneBox.focus();
    			return;
    		}
    		
    		fm.submit();
    		
    	}
    	
    	function idcheck() {
    		const idBox = document.getElementById("idBox");
    		let member_id = idBox.value;
    		
    		var xhr = new XMLHttpRequest();
    		
    		xhr.onreadystatechange = function() {
    			if(xhr.readyState==4&&xhr.status==200){
    				const checkIDResult = document.getElementById("checkIDResult");
    				let data = JSON.parse(xhr.responseText);
    				if(data.result == 'empty') {
    					checkIDResult.innerText = "사용가능한 아이디입니다.";
    					checkIDResult.setAttribute("style", "color: green;");
    				} else {
    					checkIDResult.innerText = "중복된 아이디입니다.";
    					checkIDResult.setAttribute("style", "color: red;");
    				}
    			}
    		}
    		xhr.open("get", "./idcheck?member_id=" + member_id ,true);
    		xhr.send();
    	}
    
    
    </script>
</head>
<body>
    <div style="max-width: 1200px; margin: 0 auto;">
        <div class="container-fluid">
          <!-- nav 영역 -->  
          <jsp:include page="../commons/global_nav.jsp"></jsp:include>

          <!-- 회원가입 form -->
          <form action="./joinMemberProcess" method="post" id="fm">
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
                          <input type="text" id="idBox" class="form-control" placeholder="아이디는 영문자와 숫자 6~20자입니다." name="member_id" onblur="idcheck()">
                        </div>
                      </div>
                      <div class="row">
                      	<div class="col">
                      		<span id="checkIDResult">중복 확인 중입니다....</span>
                      	</div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6" >비밀번호</span> 
                          <input type="password" class="form-control" placeholder="비밀번호를 입력하세요" name="member_pw" id="passwordBox">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">닉네임</span> 
                          <input type="text" class="form-control" placeholder="닉네임을 입력하세요" name="member_nickname" id="nickBox">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">이메일</span> 
                          <input type="email" class="form-control" placeholder="이메일를 입력하세요" name="member_email"  id="emailBox">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">생일</span> 
                          <input type="date" class="form-control" placeholder="생일을 입력하세요" name="member_birth"  id="birthBox">
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">성별</span> 
                          <input type="radio" name="member_gender" value="M" checked> 남
                          <input type="radio" name="member_gender" value="F"> 여
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <span class="fs-6">핸드폰 번호</span> 
                          <input type="tel" id="phoneBox" class="form-control" placeholder="'-' 제외한 핸드폰 번호를 입력하세요 " name="member_phone" maxlength="11">
                        </div>
                      </div>
                      <div class="row my-3">
                        <div class="col">
                          <button type="button" class="btn btn-success container-fluid" onclick="checkJoinMember()">가입하기</button>
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