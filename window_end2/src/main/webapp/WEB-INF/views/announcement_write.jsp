<%@page import="kr.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
<style type="text/css">
.window {
	width: 300px;
	height: auto;
	position: fixed;
	top: 45%;
	left: 50%;
	transform: translate(-50%, -50%);
}

.window-body {
	position: relative; /* 부모 컨테이너를 상대적으로 설정합니다. */
}

.window-body>* {
	position: absolute; /* 자식 요소를 절대적으로 설정합니다. */
	/* 위치를 제어하기 위해 위, 왼쪽, 오른쪽 또는 아래와 같은 다른 위치 속성을 지정할 수도 있습니다. */
}
</style>
<title>Insert title here</title>
</head>
<body>

	<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	%>
	<form action="announcementInsert" method="post">
		<div class="window" style="height: 650px; width: 1280px;">
			<div class="window tab-content" role="tabpanel"
				style="height: 660px; width: 1290px; top: 48.5%">
				<div class="window-body" style="position: fixed;">
					<div class="sunken-panel" style="height: 650px; width: 1270px;">
						<table style="width: 100%;" class="interactive">
							<thead style="width: 100%; font-size: 30px; text-align: center;">
								<th colspan="2">공지사항</th>
								<tr>
									<th style="width: 20%;">제목</th>
									<th><input style="width: 100%; height: 80%; margin-bottom:3px; font-size:20px;" type="text" name="title"></th>
								</tr>
								<tr>
									<th style="width: 20%;">작성자</th>
									<th><input style="width: 100%; height: 80%; margin-bottom:3px; font-size:20px;" readonly type="text" name="writer"
										value="<%=loginMember.getId()%>"></th>
								</tr>
								<tr>
									<th colspan="2">내용</th>
								</tr>
							</thead>
							<tbody style="width: 100%; font-size: 20px;">
							<tr>
							<td colspan="2"><textarea rows="10" style="width:100%; height: 400px; font-size:20px;" name="content"></textarea></td>
							</tr>
							<td colspan="2">
			<div style="text-align: right; padding: 8px; height: 1%;">
				<button type="button" style="font-size:15px;" onclick="goBack()">뒤로가기</button>
				<input style="font-size:15px;" type="submit" value="작성하기">
			</div>
			</td>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</form>
	<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>