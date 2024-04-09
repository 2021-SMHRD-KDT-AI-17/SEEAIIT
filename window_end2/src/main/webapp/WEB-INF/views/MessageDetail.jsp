<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
			<thead style="font-size: 30px; width: 100%">
				<tr>
					<th style="width: 20%">작성자</th>
					<td>${message.user_id }</td>
				</tr>
				<tr>
					<th style="width: 20%">카테고리</th>
					<td>${message.catagory }</td>
				</tr>
				<tr>
					<th style="width: 20%">제목</th>
					<td>${message.message_title }</td>
				</tr>
				<tr>
					<th colspan="2">내용</th>
					
				</tr>
				<tr>
		</thead>
		<tbody style="height: 480px;">
		<tr>
		<td style="font-size:20px; height: 100%" colspan="2">${message.message }</td>
		</tr>
		</tbody>
	</table>
	
	</div>
	<div style="text-align: right; padding: 8px; height: 1%;">
				<button type="button" style="font-size:15px;" onclick="goBack()">뒤로가기</button>
			</div>
	<script>
    function goBack() {
        window.history.back();
    }
</script>
</body>
</html>