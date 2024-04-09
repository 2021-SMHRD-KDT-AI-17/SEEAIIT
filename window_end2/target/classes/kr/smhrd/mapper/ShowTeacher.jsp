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
.title-bar-text {
    font-weight: bold;
    font-size: 16px; /* 텍스트의 크기를 20px로 설정 */
}
th, td {
    font-size: 16px; /* th와 td의 텍스트 크기를 16px로 설정 */
     font-family: Gulim, Arial, sans-serif;
}


</style>

</head>
<style>
</style>
<body style="text-align: center;" bgcolor="#008080">

	<%
	List<Member> list = (List<Member>) request.getAttribute("list");
	%>
	<div class="window" style="width: 386px">
		<div class="title-bar">
			<div class="title-bar-text">강사권한요청 리스트</div>
			<div class="title-bar-controls">
				<button aria-label="Minimize"></button>
				<button aria-label="Maximize"></button>
				<button aria-label="Close" onclick="window.location.href='goMain'"></button>
			</div>
			</div>
			<div class="sunken-panel" style="height: 240px; width: 386px;">
				<table class="interactive">
					<thead>
						<tr>
							<th>No</th>
							<th>아이디</th>
							<th>이름</th>
							<th>전화번호</th>
							<th>승인</th>
							<th>거절</th>
						</tr>
					</thead>
					<tbody>
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

