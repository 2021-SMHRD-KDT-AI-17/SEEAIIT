<%@page import="kr.smhrd.entity.Message"%>
<%@page import="java.util.List"%>
<%@page import="kr.smhrd.entity.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
<style>
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

.window-body > * {
    position: absolute; /* 자식 요소를 절대적으로 설정합니다. */
    /* 위치를 제어하기 위해 위, 왼쪽, 오른쪽 또는 아래와 같은 다른 위치 속성을 지정할 수도 있습니다. */
}

button {
    display: flex; /* 요소를 플렉스박스로 설정하여 내부 요소들을 수평으로 배치합니다. */
    align-items: center; /* 내부 요소들을 수직으로 중앙 정렬합니다. */
}

button img {
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격을 조정합니다. */
}
</style>
<title>Insert title here</title>
</head>
<body>
<%
   Member loginMember = (Member) session.getAttribute("loginMember");
   %>
<div class="window" style="height: 730px; width: 1300px;">

<div class="window-body" style="height:80%">
<button style="width:260px; height:100px; font-size:25px; margin-top:31px;">
    <img src="https://win98icons.alexmeub.com/icons/png/users-2.png">
    <%=loginMember.getId()%><br>
    <%=loginMember.getName()%>
    <img src="resources/assets/images/logo.png" style="width:70px; height:60px; margin-left: 20px;">
</button>
<br>
<button style="width:260px; height:60px; font-size:23px; margin-top:160px;" onclick="window.location.href='goQboard'">
<img alt="" src="https://win98icons.alexmeub.com/icons/png/computer_explorer-4.png">
<p>게시판으로 이동<p>
</button>
<br>
<button style="width:260px; height:60px; font-size:23px; margin-top:210px;" onclick="window.location.href='goSendAdminMessage'" >
<img src="https://win98icons.alexmeub.com/icons/png/cd_audio_cd_a-4.png">
<p>건의 및 권한요청<p>
</button>
<br>
<button disabled style="width:260px; height:380px;margin-top:260px;">
    <img src="resources/assets/images/smhrd2.png" style="width:237px; height:360px;">
</button>
<div class="window tab-content" style="height: 600px; width: 987px; margin-left:130px;  margin-top:70px;">
    <div class="window-body" >
        <div class="sunken-panel" style="height: 580px; width: 970px;">
	<form action="teamUpdate?team_number=${team.team_number }" method="post">
		<table style="width:100%;">
		<thead style="width:100%;">
			<tr>
				<th style="width:20%; font-size:30px;">팀 이름</th>
				<td style="width:100%;"><input style="width: 99%; height:80%; margin-bottom:3px; font-size:20px;" type="text" name="team_name" value=${team.team_name }></td>
			</tr>
			<tr>
				<th style="width:20%; font-size:30px;">공유 GitHub 주소</th>
				<td style="width:100%;"><input style="width: 99%; height:80%; margin-bottom:3px; font-size:20px;" type="text" name="team_Git" value=${team.team_Git }></td>
			</tr>
			<tr>
				<th style="width:20%; font-size:30px;">공유 URL 주소</th>
				<td style="width:100%;"><input style="width: 99%; height:80%; margin-bottom:3px; font-size:20px;" type="text" name="team_URL" value=${team.team_URL }></td>
			</tr>
			<tr>
				<th style="width:20%; font-size:30px;">팀 소개</th>
				<td style="width:100%;"><input style="width: 99%; height:80%; margin-bottom:3px; font-size:20px;" type="text" name="team_explanation" value=${team.team_explanation }></td>
			</tr>
			</thead>
		</table>
<div style="position: absolute; bottom: 0; left:95%; transform: translateX(-50%);">
	<input style="width: 70px; height: 30px; font-size:12px; display: inline-block;" type="submit" value="수정하기">
	<button type="button" style="width: 70px; height: 30px; font-size:12px; display: inline-block;" onclick="goBack()">뒤로가기</button>
</div>
		
	</form>
	</div>
	</div>
	</div>
	<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>