<%@page import="kr.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://unpkg.com/98.css">
<style>
.tab-content {
	display: none;
}

.tab-content.active {
	display: block;
}

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
.tab-item {
	display: flex; /* 요소를 플렉스박스로 설정하여 내부 요소들을 수평으로 배치합니다. */
	align-items: center; /* 내부 요소들을 수직으로 중앙 정렬합니다. */
}

/* 이미지에 대한 스타일 */
.tab-item img {
	margin-right: 10px; /* 이미지와 텍스트 사이에 간격을 조정합니다. */
	margin-left: 10px;
	width: 30px;
}
</style>
<script type="text/javascript"
	src="https://oapi.map.naver.com/openapi/v3/maps.js?ncpClientId=s1amhqz5qc"></script>
<script type="text/javascript">
	
</script>
<title>Insert title here</title>
</head>

<body>

	<%
	Member loginMember = (Member) session.getAttribute("loginMember");
	%>

	<div class="window" style="height: 650px; width: 1280px;">
		<menu role="tablist" class="multirows" style="height: 35px;">
			<li role="tab" aria-selected="true" class="tab-item"><img alt=""
				src="https://win98icons.alexmeub.com/icons/png/chm-2.png"> <a
				href="#announce-tab" onclick="handleTabClick('announce-tab')"
				style="font-size: 18px; margin-top: 10px;">공지사항</a></li>
			<li role="tab" aria-selected="false" class="tab-item"><img
				alt=""
				src="https://win98icons.alexmeub.com/icons/png/address_book_pad_users.png">
				<a href="#event-tab" onclick="handleTabClick('event-tab')"
				style="font-size: 18px; margin-top: 10px;">진행중인 이벤트</a></li>
			<li role="tab" aria-selected="false" class="tab-item"><img
				alt=""
				src="https://win98icons.alexmeub.com/icons/png/directory_open_file_mydocs-4.png">
				<a href="#map-tab" onclick="handleTabClick('map-tab')"
				style="font-size: 18px; margin-top: 10px;">찾아오시는 길</a></li>
		</menu>

		<div class="window tab-content" role="tabpanel" id="announce-tab"
			style="height: 630px; width: 1290px; top: 48.5%">
			<div class="window-body" style="position: fixed;">
				<div class="sunken-panel" style="height: 610px; width: 1270px;">
					<table class="interactive">
						<thead>
							<tr>
								<th style="width: 7%; font-size: 30px">번호</th>
								<th style="width: 60%; font-size: 30px">제목</th>
								<th style="width: 20%; font-size: 30px">작성자</th>
								<th style="width: 15%; font-size: 30px">작성일</th>
							</tr>
						</thead>
						<tbody style="font-size: 30px">
							<c:forEach items="${a_list}" var="a" varStatus="s">
								<tr>
									<td>${s.count }</td>
									<td><a href="annDetail?ann_idx=${a.ann_idx }">${a.ann_title }</a></td>
									<td>${a.teacher_id }</td>
									<td>${a.ann_dt}</td>
								</tr>
							</c:forEach>
							<tr>
							</tr>
						</tbody>
					</table>
					<div style="position: absolute; top: 460px;left: 95%; transform: translateX(-50%);">
						<c:if test="${loginMember.rank_num eq '1' }">
							<button onclick="location.href='goAnnouncementWrite'">공지작성</button>
						</c:if>
					</div>
					<div style="position: absolute; bottom: 0; width: 100%">
					<img style="width: 100%;" alt="" src="resources/assets/images/smhrd1.png">
					</div>
				</div>
				</div>
				</div>
				<div class="window tab-content" role="tabpanel" id="event-tab"
					style="height: 630px; width: 1290px; top: 48.5%">
					<div class="window-body" style="position: fixed;">
						<div class="sunken-panel" style="height: 610px; width: 1270px;">
							<table class="interactive" style="width: 100%; height: 100%;">
								<thead>
									<tr>
										<th colspan="4"
											style="width: 100%; font-size: 30px; text-align: center;">Event🎀</th>
									</tr>
								</thead>
								<tbody style="font-size: 30px; height: 420px;">
									<tr>
										<td style="height: 100px; width: 25%; padding: 10px;">
											<button style="width: 100%; height: 100%; padding: 5px;">
												<img src="resources/assets/images/smhrd3.png"
													style="width: 100%; height: 350px;">
												<p style="font-size: 15px; text-align: center;">지인추천
													EVENT!</p>
												<p style="font-size: 13px; text-align: center;">자신의 주변에
													비지원자중 스마트인재개발원을</p>
												<p style="font-size: 13px; text-align: center;">추천하여 1명당
													20만원을 받아가세요!</p>
											</button>
										</td>

										<td style="height: 100px; width: 25%; padding: 10px;">
											<button style="width: 100%; height: 100%; padding: 5px;">
												<img src="resources/assets/images/java.png"
													style="width: 100%; height: 350px;">
												<p style="font-size: 15px; text-align: center;">커피쿠폰
													EVENT!</p>
												<p style="font-size: 13px; text-align: center;">강의 시간에
													열심히 질문 및 대답하고</p>
												<p style="font-size: 13px; text-align: center;">강사님들에게
													커피쿠폰 받아가세요!</p>
											</button>
										</td>

										<td style="height: 100px; width: 25%; padding: 10px;">
											<button style="width: 100%; height: 100%; padding: 5px;">
												<img src="resources/assets/images/smhrd4.png"
													style="width: 100%; height: 350px;">
												<p style="font-size: 15px; text-align: center;">SMARTIER
													서포터즈 8기 모집!</p>
												<p style="font-size: 13px; text-align: center;">블로그에 내
													포트폴리오를 펼쳐보세요</p>
												<p style="font-size: 13px; text-align: center;">수료증 및
													활동비 10만원까지 지급!</p>
											</button>
										</td>

										<td style="height: 100px; width: 25%; padding: 10px;">
											<button style="width: 100%; height: 100%; padding: 5px;">
												<img src="resources/assets/images/event.png"
													style="width: 100%; height: 350px;">
												<p style="font-size: 15px; text-align: center;">출석체크
													EVENT!</p>
												<p style="font-size: 13px; text-align: center;">성실히 수업에
													참여하고</p>
												<p style="font-size: 13px; text-align: center;">담요, 피자,
													회식비까지 받아갈 기회!</p>
											</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<div class="window tab-content" role="tabpanel" id="map-tab"
					style="height: 630px; width: 1290px; top: 48.5%">
					<div class="window-body" style="position: fixed;">
						<div class="sunken-panel" style="height: 610px; width: 1270px;">
							<table class="interactive">
								<thead>
									<tr>
										<th style="width: 7%; font-size: 30px; text-align: center;">지도
											정보</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div id="map" style="width: 1235px; height: 400px;"></div>
											<div>
												<p style="font-size: 20px; font-weight: bold;">광주광역시 동구
													예술길 31-15 광주아트센터 3~5, 7층</p>
											</div>
										</td>
									</tr>
									<tr>
										<td>
											<div>
												<p style="font-size: 20px; font-weight: bold; color: green;">버스정류장</p>
												<p style="font-size: 15px; font-weight: bold;">전남여고,
													국립아시아문화전당, 예술의거리 입구, 문화전당역 지하철 역 국립아시아문화전당역(1호선, 4번출구)</p>
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
				<script>
					document.addEventListener("DOMContentLoaded", function() {
						// announce-tab 탭의 aria-selected 속성을 true로 변경하고 컨텐츠를 활성화
						var announceTab = document
								.querySelector('[href="#announce-tab"]');
						announceTab.parentNode.setAttribute('aria-selected',
								'true');
						var announceTabContent = document
								.getElementById('announce-tab');
						announceTabContent.classList.add('active');
					});

					// 각 탭 클릭 이벤트를 처리하는 함수
					function handleTabClick(tabId) {
						// 모든 탭의 aria-selected 속성을 false로 변경
						var tabs = document.querySelectorAll('[role="tab"]');
						tabs.forEach(function(tab) {
							tab.setAttribute('aria-selected', 'false');
						});

						// 클릭된 탭의 aria-selected 속성을 true로 변경
						var clickedTab = document.querySelector('[href="#'
								+ tabId + '"]');
						clickedTab.parentNode.setAttribute('aria-selected',
								'true');

						// 모든 탭 컨텐츠 비활성화
						var tabContents = document
								.querySelectorAll('.tab-content');
						tabContents.forEach(function(content) {
							content.classList.remove('active');
						});

						// 클릭된 탭 컨텐츠 활성화
						var selectedTabContent = document.getElementById(tabId);
						selectedTabContent.classList.add('active');

						map.relayout();
					}
				</script>

				<script src="resources/assets/js/jquery-3.7.1.min.js"></script>

				<!-- -----카카오 지도 api------ -->
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=90892c4f96668d21dce7786d5b129583"></script>

				<script>
					var mapOptions = {
						center : new naver.maps.LatLng(35.1497911, 126.9199378),
						zoom : 18
					};
					var marker = new naver.maps.Marker({
						position : new naver.maps.LatLng(35.1497911,
								126.9199378),
						map : map
					});

					var map = new naver.maps.Map('map', mapOptions);
				</script>
</body>
</html>