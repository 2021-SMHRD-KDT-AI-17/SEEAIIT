<%@page import="kr.smhrd.entity.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>

    <link rel="stylesheet" href="resources/assets/css/st.css">
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" crossorigin="anonymous" />
       <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta charset="UTF-8">
<title>Insert title here</title>
   <style>

        body {
            height: 100%; /* 예시로 높이를 1000px로 설정 */
            margin: 0;
            padding: 0;
        }
        .element-with-top-margin {
            position: absolute;
            top: 0; /* 여백 없애기 */
            bottom: 0;
            left: 0; /* 좌측 정렬 */
            /* 필요한 다른 스타일 속성들 */
        }

/* 이모티콘 컨테이너를 감춥니다 */
.emoji-container {
    display: none;
    position: absolute;
    bottom: 50px; /* 버튼 아래에 위치하도록 조정하세요 */
    right: 10px; /* 버튼 오른쪽에 위치하도록 조정하세요 */
    background-color: #fff; /* 배경색을 원하는 색상으로 지정하세요 */
    border: 1px solid #ccc; /* 테두리 스타일을 원하는 스타일로 지정하세요 */
    border-radius: 5px; /* 모서리를 둥글게 만들어줍니다 */
    padding: 10px; /* 내부 여백을 조정하세요 */
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* 그림자를 추가하세요 */
}

/* 이모티콘 컨테이너를 활성화시키는 클래스 */
.emoji-container.active {
    display: block;
    /* 이모티콘 컨테이너가 보일 때의 스타일을 추가하세요 */
}

.emoji-container span {
    cursor: pointer;
}

.close-btn-container {
    text-align: right;
    margin: 0px;
    padding: 0px;
}


.emoji-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: flex-start;
    max-width: 368px;
    padding: 10px;
}


.emoji-list span {
    width: 30px; /* 각 이모티콘의 너비를 픽셀 단위로 설정합니다. */
    height: 30px; /* 각 이모티콘의 높이를 픽셀 단위로 설정합니다. */
    margin-right: 5px;
    margin-bottom: 5px;
    font-size: 20px; /* 이모티콘의 폰트 크기를 조정합니다. */
    justify-content: center;
    align-items: center;
}

/* 한 행에 10개의 이모티콘만 표시 */
.emoji-list span:nth-child(10n+1) {
    margin-right: 5px; /* 첫 번째 이모티콘의 오른쪽 마진을 설정합니다. */
}

.emoji-list span:nth-child(10n+10) {
    margin-right: 0; /* 열 번째 이모티콘의 오른쪽 마진을 제거하여 각 행을 정렬합니다. */
}


.category-btn {
    border: 2px solid #000; /* 테두리 스타일 및 색상 설정 */
    border-radius: 5px; /* 테두리의 모서리를 둥글게 만듭니다. */
    padding: 2px !important;
    margin: 5px !important;
}

#addExtra{

    margin-top: 8px;

}

#sendMessage{
    margin-top: 30px;
    margin-right: 15px;
    margin-left: 5px;
}


.category-btn.active {
    border: 2px solid #000; /* 테두리 스타일 및 색상 설정 */
    border-radius: 5px; /* 테두리의 모서리를 둥글게 만듭니다. */
    padding: 5px;
}
.chat-box-footer {
    position: relative;
    bottom:0;
}

.emoji-container {
    position: absolute;
    bottom: 100%; /* footer box 위에 위치하도록 설정 */
    right: 0;
    margin-right: 13px;
    /* 나머지 스타일 */
}



    </style>
</head>
<body>

 <% Member loginMember = (Member) session.getAttribute("loginMember"); %>
      <% System.out.print("닉네임 : "+loginMember.getName());  %>
      <!-- 채팅영역 -->
    <script src="resources/assets/js/ws.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" crossorigin="anonymous"></script>
    
      <input type="hidden" id="sessionName" value="<%= loginMember.getName() %>">
     
     

    <div class="chat-box" style="overflow-y:auto;">
    
	<div style="background-color: black; margin:0;">
            <h3 style="text-align: center; color: white; margin:0;"">
            ===================================================== </h3>
            <h3 style="text-align: center; color: white; margin:0;"">
            SMHRD Talk</h3>
            <h3 style="text-align: center; color: white; margin:0;"">
            =====================================================</h3>
<!--             <p><i class="fa fa-times"></i></p> -->
</div>

        <div class="chat-box-body" style="overflow-y:auto;">
            <!-- 메시지 영역 -->
        </div> <!-- 메세지 영역 끝 -->

        <div class="chat-box-footer">
            <div class="emoji-container">
                <div class="close-btn-container">
                    <button class="close-btn" onclick="close_emoji_box()">X</button>
                </div>
                <div class="emoji-content">

            <!-- 표정이모티콘 목록 -->
            <div class="emoji-list" id="smiley-emojis">
                <span>😊</span> <span>😉</span> <span>😎</span> <span>😂</span> <span>🤣</span>
                <span>😍</span> <span>😘</span> <span>😜</span> <span>😅</span> <span>😕</span>
                <span>😇</span> <span>😐</span> <span>😏</span> <span>😲</span> <span>🧐</span>
                <span>🙃</span> <span>🤓</span> <span>🤭</span> <span>🤯</span> <span>😳</span>
                <span>😒</span> <span>😔</span> <span>😴</span> <span>🤫</span> <span>😬</span>
                <span>🤤</span> <span>😭</span> <span>😩</span> <span>😵</span> <span>😕</span>
                <span>😰</span> <span>😡</span> <span>😠</span> <span>😪</span> <span>🤔</span>
                <span>😷</span> <span>🤒</span> <span>🤕</span> <span>😑</span> <span>😶</span>
            </div>

            <div class="emoji-list" id="animal-emojis" style="display: none;">
                <span>💩</span><span>👻</span> <span>💀</span><span>👽</span> <span>🤖</span> <span>💩</span> <span>💖</span> <span>💘</span> <span>💝</span> <span>💞</span> <span>💣</span> <span>💥</span> <span>💦</span>
                <span>💧</span><span>💨</span> <span>💫</span> <span>💬</span> <span>🗨</span> <span>🗯</span> <span>💭</span> <span>💤</span> <span>👀</span> <span>🧠</span>
                <span>🐵</span> <span>🐶</span> <span>🐱</span> <span>🐭</span> <span>🐹</span> <span>🐰</span> <span>🦊</span> <span>🐻</span> <span>🐼</span> <span>🐨</span>
                <span>🐯</span> <span>🦁</span> <span>🐮</span> <span>🐷</span> <span>🐽</span> <span>🐸</span> <span>🐙</span>
            </div>
            <div class="emoji-list" id="nature-emojis" style="display: none;">
                <span>🌲</span> <span>🌳</span> <span>🌴</span> <span>🌵</span> <span>🌾</span>
                <span>🌿</span> <span>🍀</span> <span>🍁</span> <span>🍂</span> <span>🍃</span>
                <span>🍄</span> <span>🌰</span> <span>🌱</span> <span>🌼</span> <span>🌷</span>
                <span>🌹</span> <span>🌺</span> <span>🌻</span> <span>🌸</span> <span>💐</span>
            </div>
            <div class="emoji-list" id="food-emojis" style="display: none;">
                <span>🍎</span> <span>🍏</span> <span>🍐</span> <span>🍊</span> <span>🍋</span>
                <span>🍌</span> <span>🍉</span> <span>🍇</span> <span>🍓</span> <span>🍈</span>
                <span>🍒</span> <span>🍑</span> <span>🥭</span> <span>🍍</span> <span>🥥</span>
                <span>🥝</span> <span>🍅</span> <span>🍆</span> <span>🥑</span> <span>🥦</span>
            </div>
            <div class="emoji-list" id="car-emojis" style="display: none;">
                <span>🚗</span> <span>🚕</span> <span>🚙</span> <span>🚌</span> <span>🚎</span>
                <span>🏎️</span> <span>🚓</span> <span>🚑</span> <span>🚒</span> <span>🚐</span>
                <span>🚚</span> <span>🚛</span> <span>🚜</span> <span>🛴</span> <span>🚲</span>
                <span>🛵</span> <span>🏍️</span> <span>🛺</span> <span>🚂</span> <span>🚆</span>
            </div>
            <div class="emoji-list" id="sports-emojis" style="display: none;">
                <span>⚽</span> <span>🏀</span> <span>🏈</span> <span>⚾</span> <span>🥎</span>
                <span>🎾</span> <span>🏐</span> <span>🏉</span> <span>🎱</span> <span>🪀</span>
                <span>🏓</span> <span>🏸</span> <span>🏒</span> <span>🏑</span> <span>🥍</span>
                <span>🏏</span> <span>🥅</span> <span>⛳</span> <span>🪁</span> <span>🏹</span>
            </div>
            
            <div class="emoji-list" id="festival-emojis" style="display: none;">
                <span>🎉</span> <span>🎊</span> <span>🎈</span> <span>🎆</span> <span>🎇</span>
                <span>🧨</span> <span>✨</span> <span>🎄</span> <span>🎁</span> <span>🔔</span>
                <span>🕯️</span> <span>🕎</span> <span>🎍</span> <span>🎋</span> <span>🎏</span>
                <span>🎑</span> <span>🧧</span> <span>🎎</span> <span>🎐</span> <span>🏮</span>
            </div>
        </div>
        <div class="emoji-categories">
            <button class="category-btn active" data-category="smiley">표정</button>
            <button class="category-btn" data-category="animal">동물</button>
            <button class="category-btn" data-category="nature">자연</button>
            <button class="category-btn" data-category="food">음식</button>
            <button class="category-btn" data-category="car">자동차</button>
            <button class="category-btn" data-category="sports">스포츠</button>
            <button class="category-btn" data-category="festival">축제</button>
        </div>


            </div>
            <button id="addExtra" style="color:white;"><i class="fa fa-plus"></i></button>
            <textarea id="message" class="message-input" placeholder="Enter Your Message"></textarea>
            <i style="color:white;" id="sendMessage" class="send far fa-paper-plane"></i>
            
        </div>
        
<!-- 이모티콘 컨테이너 -->

    </div>

<!--     <div class="chat-button"><span></span></div>
    <button id="button_inside_iframe" display: none;>Click me</button>
 -->
    <script>


    function adduser(){
    	
    	addUser_frame();
    }
    


    
    document.addEventListener('DOMContentLoaded', function() {
        var categoryButtons = document.querySelectorAll('.emoji-categories .category-btn');

        categoryButtons.forEach(function(button) {
            button.addEventListener('click', function() { // 수정
                // 활성화된 카테고리 버튼 클래스를 변경합니다.
                categoryButtons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                this.classList.add('active');

                // 클릭한 카테고리의 데이터 속성 값을 가져옵니다.
                var category = this.getAttribute('data-category');
                var emojiLists = document.querySelectorAll('.emoji-list');

                // 모든 이모티콘 목록을 숨깁니다.
                emojiLists.forEach(function(list) {
                    list.style.display = 'none';
                });

                // 선택한 카테고리의 이모티콘 목록을 보여줍니다.
                var selectedList = document.getElementById(category + '-emojis');
                if (selectedList) {
                    selectedList.style.display = 'flex';
                }
            });
        });
    });
    document.addEventListener('DOMContentLoaded', function() {
        var categoryButtons = document.querySelectorAll('.emoji-categories .category-btn');

        categoryButtons.forEach(function(button) {
            button.addEventListener('click', function() {
                // 활성화된 카테고리 버튼 클래스를 변경합니다.
                categoryButtons.forEach(function(btn) {
                    btn.classList.remove('active');
                });
                this.classList.add('active');

                // 클릭한 카테고리의 데이터 속성 값을 가져옵니다.
                var category = this.getAttribute('data-category');
                var emojiLists = document.querySelectorAll('.emoji-list');
                
                // 모든 이모티콘 목록을 숨깁니다.
                emojiLists.forEach(function(list) {
                    list.style.display = 'none';
                });

                // 선택한 카테고리의 이모티콘 목록을 보여줍니다.
                var selectedList = document.getElementById(category + '-emojis');
                if (selectedList) {
                    selectedList.style.display = 'flex';
                }
            });
        });
    });



            // x버튼을 누르면 이모지컨테이너를 닫습니다.
            function close_emoji_box(){
                document.querySelector('.emoji-container').classList.remove('active');
            }


    document.getElementById('addExtra').addEventListener('click', function(event) {
        // 이모티콘 컨테이너를 찾아옵니다.
        var emojiContainer = document.querySelector('.emoji-container');
        // 이모티콘 컨테이너가 이미 활성화되었는지 확인합니다.
        var isActive = emojiContainer.classList.contains('active');
        // 이모티콘 컨테이너가 활성화되어 있으면 비활성화하고, 아니면 활성화합니다.
        if (isActive) {
            emojiContainer.classList.remove('active');
        } else {
            emojiContainer.classList.add('active');
        }
        // 클릭 이벤트 전파를 막습니다. 이렇게 하면 이모티콘 컨테이너 외부 클릭 시에도 토글 기능이 작동합니다.
        event.stopPropagation();
    });

    document.addEventListener('click', function(event) {
        var emojiContainer = document.querySelector('.emoji-container');
        var chatBox = document.querySelector('.chat-box');
        // 이모티콘 컨테이너 내부를 클릭했을 때 이벤트를 무시합니다.
        if (event.target.closest('.emoji-container')) {
            return;
        }
        // 이벤트가 이모티콘 컨테이너나 채팅창 내부가 아니라면 이모티콘 컨테이너를 숨깁니다.
        emojiContainer.classList.remove('active');
    });

       // 모든 이모티콘 요소를 선택합니다.
    var emojis = document.querySelectorAll('.emoji-container span');

    // 각 이모티콘에 대해 클릭 이벤트를 추가합니다.
    emojis.forEach(function(emoji) {
        emoji.addEventListener('click', function() {
            // 텍스트 영역을 선택합니다.
            var textarea = document.getElementById('message');

            // 현재 텍스트 영역의 커서 위치를 가져옵니다.
            var cursorPosition = textarea.selectionStart;

            // 텍스트 영역의 내용을 가져옵니다.
            var text = textarea.value;

            // 이모티콘을 클릭된 위치에 추가합니다.
            var newText = text.substring(0, cursorPosition) + emoji.textContent + text.substring(cursorPosition);

            // 텍스트 영역에 새로운 내용을 설정합니다.
            textarea.value = newText;

            // 텍스트 영역의 커서 위치를 조정합니다.
            textarea.selectionStart = cursorPosition + emoji.textContent.length;
            textarea.selectionEnd = cursorPosition + emoji.textContent.length;

            // 텍스트 영역에 포커스를 설정합니다.
            textarea.focus();
        });
    });



           

        
        // 쉬프트+엔터 키 조합을 처리하는 함수
document.getElementById("message").addEventListener("keydown", function(event) {
    if (event.key === "Enter" && event.shiftKey) {
        event.preventDefault(); // 기본 엔터 행동 방지
        var messageInput = document.getElementById("message");
        var cursorPosition = messageInput.selectionStart;
        var messageText = messageInput.value;
        messageInput.value = messageText.substring(0, cursorPosition) + "\n" + messageText.substring(cursorPosition); // 줄바꿈 추가
    } else if (event.key === "Enter") {
        // 일반 엔터 키 누를 때 메시지 전송
        event.preventDefault();
        sendMessage(event);
    }
});

// sendMessage 버튼 클릭 시 메시지 전송
document.getElementById("sendMessage").addEventListener("click", function(event) {
    sendMessage(event);
    close_emoji_box()
});

// Enter 키 눌렀을 때도 메시지 전송
document.getElementById("message").addEventListener("keypress", function(event) {
    if (event.key === "Enter") {
        sendMessage(event);
        close_emoji_box()
    }
});


    </script>
	<script src="resources/assets/js/jquery.min.js"></script>
	<script src="resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="resources/assets/js/skel.min.js"></script>
	<script src="resources/assets/js/util.js"></script>
	<script src="resources/assets/js/main.js"></script>
</body>
</html>