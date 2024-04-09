<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
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
	<form id="joinForm" action="memberInsert" method="post">
		<div class="window" style="width: 300px">
			<div class="title-bar">
				<div class="title-bar-text">회원가입</div>
				<div class="title-bar-controls">
					<button aria-label="Minimize"></button>
					<button aria-label="Maximize"></button>
					<button aria-label="Close"></button>
				</div>
			</div>
			<div class="window-body">
				<div class="field-row-stacked" style="width: 200px">
					<label for="text22">아이디</label><input type="text"
						placeholder="아이디를 입력하세요" name="id" id="inputE">
					</li>
					<button type="button" onclick="checkE()">아이디 중복체크</button>
				</div>
				<div>
					<span id="resultCheck" style="color: red"></span>
				</div>
				<div class="field-row-stacked" style="width: 200px">
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">비밀번호</label> <input type="password"
							placeholder="비밀번호를 입력하세요" name="pw" id="inputPW" />
					</div>
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">비밀번호 확인</label> <input type="password"
							placeholder="비밀번호를 입력하세요" name="pwConfirm" id="inputPWConfirm" />
						<div id="passwordMatchMsg" style="color: red;"></div>
					</div>
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">이름</label><input type="text"
							placeholder="이름을 입력하세요" name="name">
					</div>
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">이메일</label><input type="text"
							placeholder="이메일을 입력하세요" name="email">
					</div>
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">전화번호</label><input type="text"
							placeholder="전화번호를 입력하세요" name="tel">
					</div>
					<div class="field-row-stacked" style="width: 200px">
						<label for="text23">생년월일</label><input type="date" name="birthday">
					</div>

					<button id="joinButton">회원가입</button>
				</div>
			</div>
	</form>

</body>
</script>
<!-- Scripts -->
<script type="text/javascript">
	function checkE() {
		var inputE = $('#inputE').val()

		$.ajax( /* JSON(JavaScript Object Notation) */
		{
			// 어디로 요청할건지
			url : 'emailCheck',
			// 요청데이터 형태 -> JSON
			data : {
				'inputE' : inputE
			},
			// 요청방식
			type : 'get',
			// 요청 응답 성공했을 때 / 실패했을 때 
			success : function(data) {
				if (data == 1) {
					$('#resultCheck').text('사용 가능한 아이디입니다.')
				} else {
					$('#resultCheck').text('사용 불가능한 아이디입니다.')
				}
			},
			error : function() {
				alert("통신실패!")
			}
		})
	}
</script>
<script>
    function checkPasswordMatch() {
        var password = document.getElementById("inputPW").value;
        var confirmPassword = document.getElementById("inputPWConfirm").value;

        if (password != confirmPassword) {
            document.getElementById("passwordMatchMsg").innerHTML = "비밀번호가 일치하지 않습니다.";
        } else {
            document.getElementById("passwordMatchMsg").innerHTML = "";
        }
    }

    // 비밀번호와 비밀번호 확인 값이 변경될 때마다 확인 함수 호출
    document.getElementById("inputPW").addEventListener("input", checkPasswordMatch);
    document.getElementById("inputPWConfirm").addEventListener("input", checkPasswordMatch);
</script>
<script src="resources/assets/js/jquery.min.js"></script>
<script src="resources/assets/js/jquery.scrolly.min.js"></script>
<script src="resources/assets/js/jquery.scrollex.min.js"></script>
<script src="resources/assets/js/skel.min.js"></script>
<script src="resources/assets/js/util.js"></script>
<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
<script src="resources/assets/js/main.js"></script>
</html>