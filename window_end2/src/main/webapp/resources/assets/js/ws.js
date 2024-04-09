'use strict';

// 필요한 요소들을 변수로 선언
var usernamePage = document.querySelector('#username-page');
var chatPage = document.querySelector('#chat-page');
var usernameForm = document.querySelector('#usernameForm');
var messageForm = document.querySelector('#messageForm');
var messageInput = document.querySelector('#message');
var messageArea = document.querySelector('#messageArea');
var connectingElement = document.querySelector('.connecting');

var stompClient = null; // STOMP 클라이언트 객체
var username = null; // 사용자 이름 변수

var colors = [
    '#2196F3', '#32c787', '#00BCD4', '#ff5652',
    '#ffc107', '#ff85af', '#FF9800', '#39bbb0'
];

/*// 페이지 로딩 시 실행될 함수
window.onload = function() {
    connect(); // WebSocket 연결 시도
};*/

// 페이지 로드 완료 시 실행될 함수
document.addEventListener('DOMContentLoaded', function() {
    connect(); // WebSocket 연결 시도
});


// WebSocket 연결 시도하는 함수
function connect() {
    var sessionNameInput = document.querySelector('#sessionName');
    username = sessionNameInput.value.trim(); // 사용자 이름을 입력받음

    if (username) { // 사용자 이름이 입력되어 있을 경우에만 실행
        var socket = new SockJS('controller/chatf/ws'); // SockJS를 통한 WebSocket 연결
        stompClient = Stomp.over(socket); // STOMP 클라이언트 생성
        stompClient.connect({}, onConnected, onError); // 서버와 연결 시도
        console.log('WebSocket 연결 시도: ' + username); // 콘솔에 연결 시도 메시지 출력
    } else {
        console.log('사용자 이름이 없습니다.'); // 사용자 이름이 입력되지 않았을 때 콘솔에 메시지 출력
    }
}


// 서버와의 연결이 성공했을 때 실행될 콜백 함수
function onConnected() {
    // Public Topic을 구독하여 메시지 수신 대기
    stompClient.subscribe('/topic/public', function(payload) {
        onMessageReceived(payload);
    });
    
    // 개별 사용자 큐에 대한 구독하여 히스토리 메시지 수신 대기
    stompClient.subscribe('/user/queue/history', function(payload) {
        onMessageReceived(payload);
    });

   // 서버로부터 채팅 히스토리 요청 메시지 전송
    stompClient.send("/app/chat.getHistory", {}, JSON.stringify({ sender: username, type: 'HIS' }));
    

}
// 서버와의 연결이 실패했을 때 실행될 콜백 함수
function onError(error) {
    // 연결 실패 메시지 출력
    if (!connectingElement) {
        connectingElement = document.querySelector('.connecting');
    }
    
    if (connectingElement) {
        connectingElement.textContent = 'Could not connect to WebSocket server. Please refresh this page to try again!';
        connectingElement.style.color = 'red';
    } else {
        console.error('Connecting element not found');
    }
}

/*//사용자가 페이지를 벗어나도 이벤트가 발생하도록 하려면 visibilitychange 이벤트를 사용
document.addEventListener("visibilitychange", function() {
    if (document.visibilityState === 'hidden') {
    stompClient.send("/app/chat.removeUser", {}, JSON.stringify({ sender: username, type: 'LEAVE' }));
    }
});
*/

function addUser_frame(){
    // 서버에 사용자 입장 메시지 전송
    stompClient.send("/app/chat.addUser", {}, JSON.stringify({ sender: username, type: 'JOIN' }));
}


 //사용자가 페이지를 닫거나 어플리케이션을 종료할 때 beforeunload 이벤트를 이용하여 removeUserFromChat() 함수를 호출
window.addEventListener('beforeunload', function(event) {
     stompClient.send("/app/chat.removeUser", {}, JSON.stringify({ sender: username, type: 'LEAVE' }));
});





// 메시지를 전송하는 함수
function sendMessage(event) {
    var messageInput = document.querySelector('#message'); // 메시지 입력란 요소 가져오기
    var messageContent = messageInput.value.trim(); // 메시지 내용 가져오기

    if (messageContent && stompClient) { // 메시지 내용이 있고 STOMP 클라이언트가 존재할 경우에만 실행
        var currentTime = new Date(); // 현재 시간 가져오기

        var chatMessage = {
            sender: username,
            content: messageInput.value,
            timestamp: formatDateForServer(currentTime), // 서버에 전송할 시간 형식으로 변환
            type: 'CHAT'
        };

        // 채팅 메시지 전송
        stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
        messageInput.value = ''; // 메시지 입력란 비우기
    }
    event.preventDefault(); // 이벤트 기본 동작 방지
}



// 메시지 수신 시 실행될 함수
function onMessageReceived(payload) {
    try {
        var message = JSON.parse(payload.body);
        
        // 받은 메시지의 타입에 따라 처리
        if (message && message.type === 'JOIN') { 
            displayChatMessage(message); // 채팅창에 메시지 출력
        } else if (message && message.type === 'LEAVE') { 
            displayChatMessage(message); // 채팅창에 메시지 출력
        } else if (message && message.type === 'CHAT') {
            displayChatMessage(message); // 채팅창에 메시지 출력
        } else if (Array.isArray(message)) { // 배열 형식의 메시지인 경우 (채팅 히스토리)
            message.forEach(function(chat) { // 각 채팅 메시지에 대해 출력 함수 호출
                displayChatMessage(chat);
            });
            // messageArea가 null이 아닌 경우에만 스크롤 처리
            if (messageArea) {
                messageArea.scrollTop = messageArea.scrollHeight; // 채팅창 맨 아래로 스크롤
            }
        } else {
            console.error("Received message is not a valid chat message:", message); // 유효하지 않은 메시지인 경우 에러 메시지 출력
        }
scrollToBottom() 
         
    } catch (error) {
        console.error("An error occurred while processing the received message:", error); // 메시지 처리 중 에러 발생 시 에러 메시지 출력
    }
    
}



// 채팅 메시지를 화면에 출력하는 함수
function displayChatMessage(chat) {
    var messageElement = document.createElement('div');
    var senderElement = document.createElement('p');
    var textElement = document.createElement('p');
    var timeElement = document.createElement('span');

    timeElement.textContent = formatTime(chat.timestamp); // 시간 형식 변환
    textElement.innerHTML = chat.content.replace(/\n/g, "<br>"); // 줄바꿈 처리

    // 보낸 메시지인지, 받은 메시지인지에 따라 클래스 추가
    if (chat.sender === username && (chat.type === 'CHAT' || chat.type === 'HIS')) {
         messageElement.classList.add('chat-box-body-send');
         senderElement.classList.add('sender');
        senderElement.textContent = chat.sender;
         messageElement.appendChild(senderElement);
          messageElement.appendChild(textElement);
          messageElement.appendChild(timeElement);
    } else if(chat.sender !== username && (chat.type === 'CHAT' || chat.type === 'HIS')){
         messageElement.classList.add('chat-box-body-receive');
         senderElement.classList.add('sender');
        senderElement.textContent = chat.sender;
         messageElement.appendChild(senderElement);
          messageElement.appendChild(textElement);
          messageElement.appendChild(timeElement);
    }
    
    if(chat.type === "JOIN"){
       messageElement.appendChild(textElement);
       messageElement.classList.add('chat-box-body-sys');
    }
    if(chat.type === "LEAVE"){
        messageElement.appendChild(textElement);
        messageElement.classList.add('chat-box-body-leave');
    }
    

    document.querySelector('.chat-box-body').appendChild(messageElement); // 채팅창에 메시지 추가

    var chatBoxBody = document.querySelector('.chat-box-body');
    chatBoxBody.scrollTop = chatBoxBody.scrollHeight; // 채팅창 맨 아래로 스크롤
    scrollToBottom() 
}




// 채팅창의 스크롤을 항상 하단으로 이동하는 함수
function scrollToBottom() {
    var chatBoxBody = document.querySelector('.chat-box-body');
    chatBoxBody.scrollTop = chatBoxBody.scrollHeight; // 채팅창 맨 아래로 스크롤
}

// 사용자 이름을 해싱하여 색상을 반환하는 함수
function getAvatarColor(messageSender) {
    var hash = 0;
    for (var i = 0; i < messageSender.length; i++) {
        hash = 31 * hash + messageSender.charCodeAt(i);
    }
    var index = Math.abs(hash % colors.length);
    return colors[index];
}


function formatTime(timestamp) {
    var date = new Date(timestamp); // timestamp를 Date 객체로 변환

    var today = new Date();
    var yesterday = new Date(today);
    yesterday.setDate(yesterday.getDate() - 1);

    var isToday = date.toDateString() === today.toDateString();
    var isYesterday = date.toDateString() === yesterday.toDateString();

    var formattedTime = '';
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var ampm = hours >= 12 ? '오후' : '오전';
    hours = hours % 12;
    hours = hours ? hours : 12;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    if (isToday) {
        formattedTime = ampm + ' ' + hours + '시 ' + minutes + '분 ' + seconds + '초';
    } else if (isYesterday) {
        formattedTime = '어제 ' + ampm + ' ' + hours + '시 ' + minutes + '분 ' + seconds + '초';
    } else {
        var year = date.getFullYear();
        var month = date.getMonth() + 1;
        var day = date.getDate();
        month = month < 10 ? '0' + month : month;
        day = day < 10 ? '0' + day : day;
        formattedTime = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
    }

    return formattedTime;
}

// 서버에 전송할 시간 형식으로 포맷하는 함수
function formatDateForServer(date) {
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var day = date.getDate();
    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();

    // 한 자리 숫자인 경우 앞에 0을 붙여 두 자리로 만듦
    month = month < 10 ? '0' + month : month;
    day = day < 10 ? '0' + day : day;
    hours = hours < 10 ? '0' + hours : hours;
    minutes = minutes < 10 ? '0' + minutes : minutes;
    seconds = seconds < 10 ? '0' + seconds : seconds;

    var formattedDate = year + '-' + month + '-' + day + ' ' + hours + ':' + minutes + ':' + seconds;
    return formattedDate;
}

// 타임스탬프를 적절한 형식으로 변환하는 함수
function formatTimestamp(timestamp) {
    var today = new Date();
    var messageDate = new Date(timestamp);
    
    var formattedTime = '';
    
    // 오늘 전송된 메시지인 경우 시간만 표시
    if (today.toDateString() === messageDate.toDateString()) {
        var hours = messageDate.getHours();
        var minutes = messageDate.getMinutes();
        formattedTime = hours + '시 ' + minutes + '분';
    } else {
        formattedTime = messageDate.toLocaleString(); // 다른 날짜는 기본 형식으로 표시
    }
    
    return formattedTime;
}