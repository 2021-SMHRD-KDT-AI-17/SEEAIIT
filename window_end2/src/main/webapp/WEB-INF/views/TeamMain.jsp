<%@page import="kr.smhrd.entity.Message"%>
<%@page import="java.util.List"%>
<%@page import="kr.smhrd.entity.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<% if (loginMember.getRank_num() != 2) { %>
<button style="width:260px; height:60px; font-size:23px; margin-top:210px;" onclick="window.location.href='goSendAdminMessage'" >
<img src="https://win98icons.alexmeub.com/icons/png/cd_audio_cd_a-4.png">
<p>건의 및 권한요청<p>
</button>
<%}else { %>
<button style="width:260px; height:60px; font-size:23px; margin-top:210px;" onclick="window.location.href='goMessage'" >
<img src="https://win98icons.alexmeub.com/icons/png/cd_audio_cd_a-4.png">
<p>건의사항 확인<p>
</button>
<%} %>
<br>
<button disabled style="width:260px; height:380px;margin-top:260px;">
    <img src="resources/assets/images/smhrd2.png" style="width:237px; height:360px;">
</button>
<div class="window tab-content" style="height: 600px; width: 987px; margin-left:130px;  margin-top:70px;">
    <div class="window-body" >
        <div class="sunken-panel" style="height: 580px; width: 970px;">
		<table>
			<thead style="width:100%;">
			<tr>
				<th style="width:5%; font-size:30px;">팀 번호</th>
				<th style="width:65%; font-size:30px;">팀 이름</th>
				<th style="width:15%; font-size:30px;">참가여부</th>
				<th style="width:15%; font-size:30px;">입장하기</th>
			</tr>
			</thead>
			<tbody>
				<c:forEach items="${t_list }" var="t" varStatus="s">
                     <tr>
                        <td style="font-size:20px;">${s.count }</td>
                        <td style="font-size:20px;">${t.team_name }</td>
                        <td><button style="margin-left:16%; font-size:20px; text-align: center;" onclick="location.href='participateTeam?team_number=${t.team_number}'">팀참가</button></td>
                        <td><button style="margin-left:16%; font-size:20px; text-align: center;" onclick="location.href='goTeamDetail?team_number=${t.team_number}'">입장</button></td>
                     </tr>
                  </c:forEach>
                  </tbody>
		</table>
		<div style="position: absolute; bottom: 0; left: 95%; transform: translateX(-50%);">
		<button style="height:30px; font-size:15px;" onclick="location.href='goMakeTeam'">팀 생성</button>
		</div>
		</div>
		</div>
		</div>
</div>
</div>
</body>
</html>