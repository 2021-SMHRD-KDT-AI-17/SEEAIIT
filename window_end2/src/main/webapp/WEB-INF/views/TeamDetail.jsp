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
		<table style="width:100%;">
		<thead style="width:100%;">
		<tr>
			<th colspan="4" style="width:100%; font-size:30px; text-align: center;">팀원 명단</th>
			</tr>
			<tr>
			<th style="font-size:20px;">이름</th>
			<th style="font-size:20px;">전화번호</th>
			<th style="font-size:20px;">이메일</th>
		</tr>
		<tbody>
		<c:forEach items="${teamU_list }" var="list" varStatus="s">
               <tr>
                  <td style="font-size:30px;">${list.name }</td>
                  <td style="font-size:30px;">${list.tel }</td>
                  <td style="font-size:30px;">${list.email }</td>
               </tr>
        </c:forEach>
        </tbody>
	</table>
	
	<table style="width:100%;">
	<thead style="width:100%;">
	<tr>
	<th colspan="2" style="width:100%; font-size:30px; text-align: center;">팀 정보</th>
	</tr>
		<tr>
			<th style="width:20%; font-size:20px;">양식 다운로드</th>
			<td style="font-size:20px;"><a href="resources/image/팀할일.xlsx" download>팀 할일 템플릿</td>
		</tr>
		<tr>
			<th style="width:20%; font-size:20px;">GitHub 주소</th>
			<td style="font-size:20px;"><a href="${team.team_Git }" target="_blank">Git주소 이동</a></td>
		</tr>
		<tr>
			<th style="width:20%; font-size:20px;">URL 주소</th>
			<td style="font-size:15px;"><a href="${team.team_URL }" target="_blank">${team.team_URL }</a></td>
		</tr>
		<tr>
			<th colspan="2" style="font-size:20px;">팀설명</th>
			
		</tr>
		</thead>
		<tbody>
		<tr>
		<td style="font-size:20px;">${team.team_explanation }</td>
		</tr>
		</tbody>
	</table>
	
	
<div style="position: absolute; bottom: 0; left: 95%; transform: translateX(-50%);">
	<c:if test="${loginMember.team_number eq team.team_number}">
	<button style="height:30px; font-size:12px;" onclick="location.href='goTeamUpdate?team_number=${team.team_number}'">정보수정</button>
	</c:if>
	<button type="button" style="height:30px; font-size:12px;" onclick="goBack()">뒤로가기</button>
</div>


<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>