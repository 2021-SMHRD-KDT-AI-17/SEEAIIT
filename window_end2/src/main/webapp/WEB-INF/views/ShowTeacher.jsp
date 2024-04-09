<%@page import="kr.smhrd.entity.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 1.request영역에 저장된 정보를 가져오시오. -->

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Forty by HTML5 UP</title>
<meta charset="UTF-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

.window-body>* {
	position: absolute; /* 자식 요소를 절대적으로 설정합니다. */
	/* 위치를 제어하기 위해 위, 왼쪽, 오른쪽 또는 아래와 같은 다른 위치 속성을 지정할 수도 있습니다. */
}
</style>

</head>
<style>
</style>
<body>

	<%
	List<Member> list = (List<Member>) request.getAttribute("list");
	%>
	<div class="window" style="height: 630px; width: 1280px;">
		<div class="window tab-content" role="tabpanel" id="announce-tab"
			style="height: 660px; width: 1290px; top: 48.5%">
			<div class="window-body" style="position: fixed;">
				<div class="sunken-panel" style="height: 650px; width: 1270px;">
					<table style="width: 100%;" class="interactive">
						<thead style="width: 100%; text-align: center; font-size: 30px;">
							<tr>
								<th>No</th>
								<th>아이디</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>승인</th>
								<th>거절</th>
							</tr>
						</thead>
						<tbody style="text-align:center; font-weight:bold; font-size: 15px; width:100%; height:650px;">
							<c:forEach items="${list }" var="m" varStatus="status">
								<tr>
									<td>${status.count }</td>
									<td>${m.id }</td>
									<td>${m.name }</td>
									<td>${m.tel }</td>
									<td><a href="rankUpdate?id=${m.id }">승인</a></td>
									<td><a href="" onclick="rejectRequest(this)">거절</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>

			<!-- ------------------------------------------------------------------------- -->
		</div>
		<!-- Scripts -->
		<script>
  document.querySelectorAll('table.interactive').forEach(element => {
    element.addEventListener('click', (event) => {
      const row = event.path.find(element => element.tagName === 'TR' && element.parentElement.tagName === 'TBODY');
      if (row) {
        row.classList.toggle('highlighted');
      }
    })
  });
</script>
		<script>
    function rejectRequest(element) {
        // 클릭된 요소의 부모인 <tr> 요소를 찾음
        var row = element.parentNode.parentNode;
        // 찾은 <tr> 요소를 완전히 제거
        row.parentNode.removeChild(row);
        // 이벤트의 기본 동작인 링크 이동을 막음
        event.preventDefault();
    }
</script>

		<script src="resources/assets/js/jquery.min.js"></script>
		<script src="resources/assets/js/jquery.scrolly.min.js"></script>
		<script src="resources/assets/js/jquery.scrollex.min.js"></script>
		<script src="resources/assets/js/skel.min.js"></script>
		<script src="resources/assets/js/util.js"></script>
		<script src="resources/assets/js/main.js"></script>
</body>
</html>

