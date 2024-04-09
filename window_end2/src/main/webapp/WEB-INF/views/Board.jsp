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
<title>탭 목록</title>
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

.window-body > * {
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
button {
    display: flex; /* 요소를 플렉스박스로 설정하여 내부 요소들을 수평으로 배치합니다. */
    align-items: center; /* 내부 요소들을 수직으로 중앙 정렬합니다. */
}

button img {
    margin-right: 10px; /* 이미지와 텍스트 사이의 간격을 조정합니다. */
}

</style>
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
<button style="width:260px; height:60px; font-size:23px; margin-top:160px;" onclick="window.location.href='goTeamMain'">
<img alt="" src="https://win98icons.alexmeub.com/icons/png/computer_explorer-4.png">
<p>팀원모집<p>
</button>
<br>
<% if (loginMember.getRank_num() != 2) { %>
<button style="width:260px; height:60px; font-size:23px; margin-top:210px;" onclick="window.location.href='goSendAdminMessage'" >
<img src="https://win98icons.alexmeub.com/icons/png/cd_audio_cd_a-4.png">
<p>건의 및 권한요청<p>
</button>
<%}else { %>
<button style="width:260px; height:60px; font-size:23px; margin-top:210px;" onclick="window.location.href='goMessage'" >
<img src="https://win98icons.alexmeub.com/icons/png/cd_audio_cd_a-4.png">
<p>건의사항 확인<p>
</button>
<%} %>
<br>
<button disabled style="width:260px; height:380px;margin-top:260px;">
    <img src="resources/assets/images/smhrd2.png" style="width:237px; height:360px;">
</button>

  <menu role="tablist" class="multirows" style="height: 35px; width: 980px;  margin-left:280px;">
   <li role="tab" aria-selected="true" class="tab-item">
    <img alt="" src="https://win98icons.alexmeub.com/icons/png/chm-2.png">
    <a href="#Question-tab" onclick="showTab('Question-tab')" style="font-size : 18px; margin-top : 10px;">질문 게시판</a>
   </li>
    <li role="tab" aria-selected="false" class="tab-item">
    <img alt="" src="https://win98icons.alexmeub.com/icons/png/address_book_pad_users.png">
    <a href="#debate-tab" onclick="window.location.href='goDebateBoard'" style="font-size : 18px; margin-top : 10px;">토론 게시판</a></li>
    <li role="tab" aria-selected="false" class="tab-item">
    <img alt="" src="https://win98icons.alexmeub.com/icons/png/directory_open_file_mydocs-4.png">
    <a href="#data-tab" onclick="window.location.href='goDataBoard'" style="font-size : 18px; margin-top : 10px;">수업자료 게시판</a></li>
  </menu>
  
<div class="window tab-content" role="tabpanel" id="Question-tab" style="height: 600px; width: 987px; margin-left:130px;  margin-top:40px;">
    <div class="window-body" >
        <div class="sunken-panel" style="height: 580px; width: 970px;">
            <table class="interactive">
                <thead>
                    <tr>
                        <th style="width: 7%; font-size:20px">번호</th>
                        <th style="width: 60%; font-size:20px">제목</th>
                        <th style="width: 20%; font-size:20px">작성자</th>
                        <th style="width: 15%; font-size:20px">작성일</th>
                        <th style="width: 10%; font-size:20px">조회수</th>
                    </tr>
                </thead>
                <tbody style="font-size:20px">   
                <!-- 페이징 구현 -->
               <c:choose>
               <c:when test="${q_size<15 }">
                  <c:forEach items="${q_list }" var="q" begin="0" end="${q_size }" step="1" varStatus="s">
                     <tr>
                        <td>${s.count }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                  </c:forEach>
               </c:when>
               <c:when test="${q_size>=15 and q_size<30 }">
               <c:choose>
                  <c:when test="${page1 eq '1' }">
                  <c:forEach items="${q_list }" var="q" begin="0" end="14" step="1" varStatus="s">
                     <tr>
                        <td>${s.count }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                  </c:forEach>
               </c:when>
               <c:when test="${page1 eq '2' }">
                     <c:forEach items="${q_list }" var="q" begin="15" end="${q_size }" step="1" varStatus="s">
                     <tr>
                        <td>${s.count+15 }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                     </c:forEach>
                  </c:when>
                  </c:choose>
               </c:when>
               
               <c:when test="${q_size>=30 and q_size<45 }">
                     <c:choose>
                     <c:when test="${page1 eq '1' }">
                     <c:forEach items="${q_list }" var="q" begin="0" end="14" step="1" varStatus="s">
                     <tr>
                        <td>${s.count }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                     </c:forEach>
                     </c:when>
                     <c:when test="${page1 eq '2' }">
                     <c:forEach items="${q_list }" var="q" begin="15" end="29" step="1" varStatus="s">
                     <tr>
                        <td>${s.count+15 }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                     </c:forEach>
                     </c:when>
                     <c:when test="${page1 eq '3' }">
                     <c:forEach items="${q_list }" var="q" begin="30" end="${q_size }" step="1" varStatus="s">
                     <tr>
                        <td>${s.count+30 }</td>
                        <td><a href="QboardContent?qb_idx=${q.qb_idx }">${q.qb_title }</a></td>
                        <td>${q.user_id }</td>
                        <td>${q.qb_dt }</td>
                        <td>${q.qb_views }</td>
                     </tr>
                     </c:forEach>
                     </c:when>
                     </c:choose>
               </c:when>
            </c:choose>
               </tbody>
            </table>
            <div style="position: absolute; bottom: 0; left: 50%; transform: translateX(-50%);">
            <c:choose>
               <c:when test="${q_size<15 }">
                  <br>
                  <p id="page1" style="text-align: center; font-size:20px;">페이지 : <a href="goBoardMain">[1]</a><span></p> 
                  <br>
                  <br>
               </c:when>
               <c:when test="${q_size>=15 and q_size<30 }">
                  <br>
                  <p id="page1" style="text-align: center; font-size:20px;">페이지 : <a href="goBoardMain">[1]</a><span></span><a href="goQboardMain2">[2]</a><span></p>
                  <br>
                  <br>
               </c:when>
               <c:when test="${q_size>=30}">
                  <br>
                  <p id="page1" style="text-align: center; font-size:20px;"">페이지 : <a href="goBoardMain">[1]</a><span></span><a href="goQboardMain2">[2]</a><span></span><a href="goQboardMain3">[3]</a></p>
                  <br>
                  <br>
               </c:when>
            </c:choose>
            </div>
            <div style="position: absolute; bottom: 0; left: 91%; transform: translateX(-50%);">
            <br>
            <span><button id="writer" onclick="window.location.href='goQboardWrite'" style="height:30px;">게시글작성</button></span>
            <br>
            </div>
      <!-- <img alt="" src="resources/assets/images/smhrd1.png" style="bottom: 0; position: absolute; top: 100%; width: 100%; left: 50%; transform: translateX(-50%);"> -->
        <form action="selectQboard" method="post" >
        <div style="position: absolute; bottom: 0; left: 50%; transform: translateX(-50%); ">
        <input type="text" placeholder="검색어를 입력하세요." style="padding-left: 40px; height:25px;" name="select">
        <img src="https://win98icons.alexmeub.com/icons/png/search_file-2.png" style="position: absolute; top: 50%; left: 10px; transform: translateY(-50%);">
       <input type="submit" style="height:25px;" value="검색">
        </div>
        </form>
        </div>
    </div>
</div>

  <!-- 다른 탭 패널은 간결함을 위해 생략 -->
  
</div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function() {
     // 모든 탭의 aria-selected 속성을 false로 변경
     var tabs = document.querySelectorAll('[role="tab"]');
     tabs.forEach(function(tab) {
       tab.setAttribute('aria-selected', 'false');
     });

     // 질문 게시판 탭의 aria-selected 속성을 true로 변경
     var QuestionTab = document.querySelector('[href="#Question-tab"]');
     QuestionTab.parentNode.setAttribute('aria-selected', 'true');

     // 질문 게시판 탭 컨텐츠를 활성화
     var QuestionTabContent = document.getElementById('Question-tab');
     QuestionTabContent.classList.add('active');
   });
</script>
   <script src="resources/assets/js/jquery-3.7.1.min.js"></script>
<!--     <script src="resources/assets/js/jquery.min.js"></script>
   <script src="resources/assets/js/jquery.scrolly.min.js"></script>
   <script src="resources/assets/js/jquery.scrollex.min.js"></script>
   <script src="resources/assets/js/skel.min.js"></script>
   <script src="resources/assets/js/util.js"></script>
   <script src="resources/assets/js/main.js"></script> -->

</body>
</html>