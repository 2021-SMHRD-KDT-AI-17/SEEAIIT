<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
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
/* 이미지와 텍스트를 감싸는 요소에 대한 스타일 */

</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="window" style="height: 650px; width: 1280px;">
	<div class="window tab-content" role="tabpanel" style="height: 630px; width: 1290px; top: 48.5%">
		<div class="window-body" style="position: fixed;">
			<div class="sunken-panel" style="height: 610px; width: 1270px;">
				<table style="width: 100%;" class="interactive">
					<thead style="width: 100%;">
						<tr>
							<th style="width: 5%; text-align: center; font-size: 25px">번호</th>
							<th style="width: 40%; text-align: center; font-size: 25px">원본 제목</th>
							<th style="width: 40%; text-align: center; font-size: 25px">번역 제목</th>
							<th style="width: 15%; text-align: center; font-size: 25px">링크</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${insite_list }" var="i_list" varStatus="s">
							<tr style="margin-bottom:5px;">
								<td style="font-size:13.5px; font-weight: bold; text-align: center;">${s.count }</td>
								<td style="font-size:13.5px; font-weight: bold; text-align: left;">${i_list.sentence }</td>
								<td style="font-size:13.5px; font-weight: bold; text-align: left;">${i_list.translate }</td>
								<td style="font-size:13.5px; font-weight: bold; text-align: center;"><a target="_blank" href="${i_list.link}/">이동</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	</div>
</body>
</html>