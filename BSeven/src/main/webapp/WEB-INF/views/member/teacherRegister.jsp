<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
          
          <!-- 강의 카테고리 -->
          <jsp:include page="../commons/global_category.jsp"></jsp:include>

          <!-- 강사등록 form -->
          <form action="./teacherRegisterProcess" method="post">
            <div class="row">
              <div class="col"></div>
              <div class="col-6">
                <div class="row my-5" style="max-width: 600px;">
                  <div class="col">
                    <div class="container-fluid">
                      <div class="row text-center mt-5">
                        <div class="col">
                          <h1>강사 등록을 환영합니다.</h1>
                        </div>
                      </div>
                      <div class="row mt-5">
                        <div class="col">
                          <span class="fs-6">닉네임:</span> 
                          <span>${sessionUser.member_nickname }</span>
                        </div>
                      </div>
                      <div class="row mt-3">
                        <div class="col">
                          <div class="row">
                            <div class="col">
                              <span class="fs-6">강사소개</span> 
                            </div>
                          </div>
                          <div class="row">
                            <div class="col d-grid">
                              <textarea rows="" cols="" placeholder="강사님을 소개해보세요" name="introduction"></textarea>
                            </div>
                          </div>
                        </div>
                      </div>
                      
                      <div class="row mt-3">
                        <div class="col">
                          <input type="submit" class="btn btn-success container-fluid" value="등록하기">
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
  if(document.querySelector("#inputUrl") != null) {
	  const inputUrl = document.querySelector("#inputUrl");
	  inputUrl.value = url.substring(url.indexOf(/bseven/)+8);
  }
</script>
<script type="text/javascript" src="/bseven/resources/js/category.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
</body>
</html>