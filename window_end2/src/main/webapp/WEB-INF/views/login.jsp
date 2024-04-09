<%@page import="kr.smhrd.entity.Message"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="kr.smhrd.entity.Member"%>
<%@page import="java.util.ArrayList"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<link rel="stylesheet" href="https://unpkg.com/98.css">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.window {
    width: 300px;
    height: auto;
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);

}

.title-bar {
    padding: 5px;
    border-bottom: 1px solid #ccc;
}

.title-bar-text {
    font-weight: bold;
}

.window-body {
    padding: 10px;
}

.field-row-stacked {
    margin-bottom: 10px;
}

.button {
    padding: 5px 10px;
    color: white;
    border: none;
    border-radius: 3px;
    cursor: pointer;
}

</style>
</head>
<body bgcolor="#008080"> 
	<img alt="" src="resources/assets/images/pngwing(1).png" style =" width: 7%; height: auto; position: absolute; bottom: 10; right: 0;">
<form id="loginForm" action="login" method="post">
    <div class="window" style="width: 300px " >
        <div class="title-bar">
            <div class="title-bar-text">로그인</div>
            <div class="title-bar-controls">
                <button aria-label="Minimize"></button>
                <button aria-label="Maximize"></button>
                <button aria-label="Close"></button>
            </div>
        </div>
        <div class="window-body">
        <img alt="" src="resources/assets/images/windows.png" style="width: 250px">
            <div class="field-row-stacked" style="width: 250px">
                <label for="text22">아이디</label> <input type="text" placeholder="아이디를 입력하세요" name="id" id="inputID" />
            </div>
            <div class="field-row-stacked" style="width: 250px">
                <label for="text23">비밀번호</label> <input type="password" placeholder="비밀번호를 입력하세요" name="pw" id="inputPW" />
            </div>
            <div class="field-row-stacked" style="width: 250px">
            <button type="button" onclick="loginC()">로그인</button>
            <div id="resultIdCheck" style="color : red"></div>
        
            <button type="button" onclick="kakaoLogin();">카카오로그인</button>
            <button id="joinButton">회원가입</button>
            </div>
        </div>
    </div>
</form>

</body>
</html>
<script>
    // loginC 함수를 직접 호출하도록 수정
    document.getElementById("joinButton").addEventListener("click", function(event) {
        // 기본 동작인 페이지 이동을 막음
        event.preventDefault();
        // 버튼을 클릭했을 때 수행할 동작을 여기에 작성
        window.location.href = "goJoin"; // 회원가입 페이지로 이동
    });

    // loginC 함수를 직접 호출하도록 수정
    document.getElementById("loginForm").addEventListener("submit", function(event) {
        // 폼 제출 방지를 해제하고 직접 로그인 함수를 호출
        event.preventDefault();
        loginC();
    });
</script>
	<!-- Scripts -->
	<script type="text/javascript">
 		function checkE(){
			var inputE = $('#inputE').val()
			
			$.ajax( /* JSON(JavaScript Object Notation) */
				{
					// 어디로 요청할건지
					url : 'emailCheck',
					// 요청데이터 형태 -> JSON
					data : {'inputE' : inputE},
					// 요청방식
					type : 'get',
					// 요청 응답 성공했을 때 / 실패했을 때 
					success : function(data){
						if(data == 1){
							$('#resultCheck').text('사용 가능한 아이디')
						}else{
							$('#resultCheck').text('사용 불가능한 아이디')
						}
					},
					error : function(){
						alert("통신실패!")
					}
				}		
			)
		} 
	//---------------------------------------------------------------------
function loginC(){
    var inputID = $('#inputID').val();
    var inputPW = $('#inputPW').val();
    
    $.ajax({
        url : 'LoginCheck',
        data : {'inputID': inputID, 'inputPW': inputPW},
        type : 'post',
        success : function(data){
            if(data == 1){
                $('#resultIdCheck').text('죄송합니다. 등록되지 않은 아이디입니다.');
            } else if(data == 2){
            	$('#loginForm').submit();
            } else if(data == 3){
                $('#resultIdCheck').text('죄송합니다. 비밀번호가 틀렸습니다.');
            }
        },
        error : function(){
            alert("통신실패!");
        }
    })
}
	//--------------------------------------------------------------------
	</script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('581ce066b314ae990938d9f233ad6a4a'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
        success: function(response) {
            // 카카오 로그인 성공 시, 받은 accessToken을 서버로 전송
            var accessToken = response.access_token;
            $.ajax({
                url: 'kakaoLogin',
                data: {'accessToken': accessToken},
                type: 'post',
                success: function(data) {
                    // 카카오 로그인 성공 시 수행할 로직
                    alert(data);
                },
                error: function() {
                    alert("카카오 로그인 실패!");
                }
            });
        },
        fail: function(error) {
            console.log(error);
            alert("카카오 로그인 실패!");
        }
    });
}
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>
  	<script src="resources/assets/js/jquery.min.js"></script>
	<script src="resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="resources/assets/js/skel.min.js"></script>
	<script src="resources/assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="resources/assets/js/main.js"></script>