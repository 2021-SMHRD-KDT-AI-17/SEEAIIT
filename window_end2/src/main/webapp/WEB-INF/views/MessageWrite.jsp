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
	<form action="SendAdminMessage" method="post">
		<table class="interactive" id="list" style="height: 100%; width: 100%;">
			<thead style="font-size: 30px;">
			<tr>
				<th style="width:20%">작성자</th>
				<td><input style="width:100%; height: 80%; font-size:20px;" type="text" readlonly value="${loginMember.id }" readonly name="user_id"></td>
			</tr>
			<tr>
				<th style="font-size: 30px;">카테고리</th>
				<td>
				<div class="field-row">
				 <input id="radio10" type="radio" name="catagory" value="건의사항" checked="checked">
				 <label style="font-size:20px;" for="radio10">건의사항</label>
				 <input id="radio11" type="radio" name="catagory" value="권한요청">
				 <label style="font-size:20px;" for="radio11">권한요청</label>
				 </div>
				</td>
			</tr>
			
			<tr>
				<th>제목</th>
				<td><input style="width: 100%; height:80%; margin-bottom:7px; font-size:20px;" type="text" name="message_title"></td>
			</tr>
			<tr>
				<th style="font-size: 30px;" colspan="2">내용</th>
			</tr>
			</thead>
			<tbody style="width: 100%; height: 500px; font-size: 20px;">

			<tr>
				<td colspan="2"><textarea style="margin-top:7px; width:100%; height: 100%; font-size:20px;" rows="6" name="message"></textarea></td>
			</tr>
			
			<tr>
			<td colspan="2">
			<div style="text-align: right; padding: 8px; height: 1%;">
				<button type="button" style="font-size:15px;" onclick="goBack()">뒤로가기</button>
				<input style="font-size:15px;" type="submit" value="전송">
			</div>
			</td>
			</tr>
		</tbody>
		</table>
	</form>
<script>
    function goBack() {
        window.history.back();
    }
</script>

</body>
</html>