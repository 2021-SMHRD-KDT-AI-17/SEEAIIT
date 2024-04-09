<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Forty by HTML5 UP</title>
<meta charset="utf-8" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
</head>
<body>
	<div class="sunken-panel" id="board" style="height: 100%; width: 100%;">
		<form action="FboardUpdate?fb_idx=${fboard.fb_idx }" method="post"
			enctype="multipart/form-data">
			<table class="interactive" id="list"
				style="height: 100%; width: 100%;">
				<thead style="font-size: 30px;">
					<tr>
						<th>제목</th>
						<th><input
							style="width: 100%; height: 80%; padding: 0; border: none; font-size: 20px;"
							type="text" name="fb_title" value="${fboard.fb_title }">
						</th>
					</tr>

					<tr>
						<th style="width: 20%">작성자</th>
						<th><input style="width: 100%; height: 80%; font-size: 20px;"
							type="text" name="user_id" readonly value="${fboard.user_id }">
						</th>
					</tr>
					<tr>
						<th style="width: 20%">파일</th>
						<th><input type="file" style="float: left;" name="fb_file" value="${fboard.fb_file }"></th>
					</tr>
					<tr>
						<th colspan="2">내용</th>
					</tr>
				</thead>
				<tbody style="width: 100%; height: 500px; font-size: 20px;">
				<tr>
					<td colspan="2"><textarea rows="10" style="width:100%; height: 100%; font-size:20px;"
							name="fb_content">${fboard.fb_content } </textarea></td>
				</tr>
				<tr>
					<td colspan="2">
					<div style="text-align: right; padding: 8px; height: 1%;">
					<input type="submit" value="UPDATE" class="button fit">
					</div>
				</tr>
				</tbody>

			</table>
			


		</form>
	</div>
	<!-- Scripts -->
	<script src="resources/assets/js/jquery.min.js"></script>
	<script src="resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="resources/assets/js/skel.min.js"></script>
	<script src="resources/assets/js/util.js"></script>
	<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
	<script src="resources/assets/js/main.js"></script>
</body>
</html>