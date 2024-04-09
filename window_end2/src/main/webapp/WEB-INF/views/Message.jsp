<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
<title>Insert title here</title>
</head>
<body>
<div class="sunken-panel" id="board" style="height: 100%; width: 100%;">
<table class="interactive" id="list" style="height: 100%; width: 100%;">
			<thead style="font-size: 30px;">
				<tr>
					<td style="width: 20%;">보낸사람</td>
					<td style="width: 20%;">카테고리</td>
					<td style="width: 20%;">제목</td>
					<td style="width: 20%;">보낸시간</td>
				</tr>
			</thead>
			<tbody style="width: 100%; height: 500px; font-size: 20px;">
		
		<c:forEach items="${mes_list }" var="list" varStatus="s">
            <tr>
               <td>${list.user_id }</td>
               <td>${list.catagory }</td>
               <td><a href="goMessageDetail?message_idx=${list.message_idx }">${list.message_title }</a></td>
               <td>${list.message_dt }</td>
            </tr>
        </c:forEach>
	</table>
	</div>
	<div style="text-align: right; padding: 8px; height: 1%;">
		<button type="button" style="font-size: 15px;" onclick="goBack()">뒤로가기</button>
	</div>

	<script>
		function goBack() {
			window.history.back();
		}
		</script>
		</body>
		</html>
	