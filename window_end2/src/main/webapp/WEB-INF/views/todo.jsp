<%@page import="kr.smhrd.entity.Member"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>투두리스트</title>
<link rel="stylesheet" href="https://unpkg.com/98.css">

<!-- CSS -->
<style>
.window {
	width: 300px;
	height: auto;
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
<body>
	<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	%>
	<!-- HTML 코드 -->
	<div class="window" style="height: 500px; width: 470px;">
		<div class="window-body" style="height: 500px; width: 470px;">
			<div class="sunken-panel" style="height: 490px">
					<section class="todo-cmp">
						<header class="todo-cmp__header">
							<h2 style="text-align: center;" id="todaysDay"></h2>
							<p style="text-align: center; font-weight: bold;" id="todaysDate"></p>
						</header>
						<form id="todoForm" action="addTodoItem" method="post">
							<input type="hidden" name="date"
								value="<%=java.time.LocalDate.now()%>" readonly> <input
								type="hidden" name="email" value="<%=loginMember.getEmail()%>"
								readonly>
							<%-- <input type="text" name="date" value="<%=java.time.LocalDate.now()%>" readonly><br> <!-- 오늘의 날짜를 자동으로 입력 --> --%>
							<div class="field-row-stacked" style="width: 400px;">
								<input style="text-align: center; margin-left:10%;" type="text" id="todoContent" name="content">
							</div>
							<br>
							<button style="margin-left:80%;" type="button" id="addTodoBtn" value="등록하기">Add</button>

						</form>
						<%
						// 현재 날짜 가져오기
						java.time.LocalDate currentDate = java.time.LocalDate.now();
						// currentDate를 JSP 변수로 설정
						request.setAttribute("currentDate", currentDate);
						%>
						<h4 style="text-align: center;">투두 리스트</h4>
						<div class="sunken-panel" style="height: 200px; width: 450px;">
							<table style="width: 100%" class="interactive">
								<thead style="width: 100%">
									<tr>
										<th>날짜</th>
										<th>내용</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${t_list}" var="todo">
										<%-- 현재 투두 아이템의 로그인 아이디가 현재 로그인한 멤버의 이메일과 일치하는 경우에만 출력 --%>
										<c:if test="${todo.loginId eq loginMember.id}">
											<tr>
												<td>${todo.date}</td>
												<td><label for="todo-${todo.id}"> <input
														id="todo-${todo.id}" type="checkbox" name="completed"
														value="true"
														onchange="updateTodoItem('${todo.id}', this.checked)"
														${todo.completed ? 'checked' : ''}> <label
														for="todo-${todo.id}"><span>${todo.content}</span></label>
												</label></td>
												<td><span class="deleteTodo"
													style="cursor: pointer; text-decoration: underline;">삭제</span></td>
											</tr>
										</c:if>
									</c:forEach>
								</tbody>
							</table>
						</div>

					</section>
				</div>
			</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script>
		// updateTodoItem 함수 정의
		// updateTodoItem 함수 정의
		function updateTodoItem(todoId, completed) {
			// AJAX를 사용하여 서버로 요청을 보냄
			$.ajax({
				url : "updateTodoItem",
				type : "POST",
				data : {
					id : todoId,
					completed : completed
				},
				success : function(response) {
					console.log("Todo item updated successfully.");
					updateTodoItemUI(todoId, completed); // 변경된 항목의 체크 여부를 업데이트
				},
				error : function(xhr, status, error) {
					console.error("Error occurred while updating todo item:",
							error);
				}
			});
		}

		// 변경된 항목의 체크 여부를 업데이트하는 함수
		function updateTodoItemUI(todoId, completed) {
			// 변경된 항목의 체크 여부를 업데이트
			var checkbox = $('#todo-' + todoId);
			var span = checkbox.next('span');
			span.css('color', completed ? '#ccc' : '#497081');
			span.find('input').prop('checked', completed);
		}

		// 등록 버튼 클릭 시
		$('#addTodoBtn').click(function() {
			var content = $('#todoContent').val(); // 입력된 내용 가져오기
			if (content.trim() !== '') { // 내용이 비어있지 않은 경우에만 실행
				$('#todoForm').submit(); // 양식 제출
			} else {
				alert('할 일을 입력하세요.'); // 내용이 비어있는 경우 알림 표시
			}
		});

		// 오늘의 날짜와 요일을 표시하는 함수
		function showTodaysDate() {
			const days = [ 'Sunday', 'Monday', 'Tuesday', 'Wednesday',
					'Thursday', 'Friday', 'Saturday' ];
			const months = [ 'January', 'February', 'March', 'April', 'May',
					'June', 'July', 'August', 'September', 'October',
					'November', 'December' ];

			const today = new Date();
			const dayOfWeek = days[today.getDay()];
			const month = months[today.getMonth()];
			const dayOfMonth = today.getDate();
			const year = today.getFullYear();

			document.getElementById('todaysDay').textContent = dayOfWeek;
			document.getElementById('todaysDate').textContent = month + ' '
					+ dayOfMonth + ', ' + year;
		}

		// 페이지가 로드될 때 오늘의 날짜를 표시
		window.onload = showTodaysDate;

		$('.deleteTodo').click(
				function() {
					var todoId = $(this).closest('tr').find(
							'input[type="checkbox"]').attr('id').split('-')[1];

					// AJAX를 사용하여 서버로 삭제 요청을 보냄
					$.ajax({
						url : "deleteTodoItem",
						type : "POST",
						data : {
							id : todoId
						},
						success : function(response) {
							console.log("Todo item deleted successfully.");
							// 투두 리스트 업데이트
							$('#todo-' + todoId).closest('tr').remove();
						},
						error : function(xhr, status, error) {
							console.error(
									"Error occurred while deleting todo item:",
									error);
						}
					});
				});
	</script>
</body>
</html>