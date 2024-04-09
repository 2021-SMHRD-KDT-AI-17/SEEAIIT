package kr.smhrd.chat;

import java.io.IOException;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor(onConstructor_ = @Autowired)
@Component
public class ChatHandler extends TextWebSocketHandler {
    // 연결된 WebSocket 세션을 저장하기 위한 Set
    private final Set<WebSocketSession> sessions = new HashSet<>();
    
    private final ObjectMapper objectMapper; // ObjectMapper 주입
    private final ChatService chatService;
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session)  throws Exception {
        log.debug("WebSocket connection established");
        System.out.println("좀되라 ..ㅠㅠ");
        // 새로운 WebSocket 연결이 수립될 때 호출되는 메서드
        // 연결된 세션을 세션 목록에 추가합니다.
        sessions.add(session);
       
        try {
            // 전체 사용자의 채팅 기록을 가져옵니다.
            List<ChatMessageDTO> chatHistory = chatService.getChatHistory();
            if (chatHistory != null) {
                // 채팅 기록을 JSON 형식으로 변환하여 신규로 연결된 사용자에게 전송합니다.
                TextMessage historyMessage = new TextMessage(objectMapper.writeValueAsString(chatHistory));
                session.sendMessage(historyMessage);
            }
        } catch (IOException e) {
            log.error("Error sending chat history: {}", e.getMessage(), e);
        }
    }
    
    
    // afterConnectionClosed : 웹소켓이 연결이 종료되면 호출되는 함수
    // 웹소켓이 연결이 종료 = 세션 종료
    @Override
    public void afterConnectionClosed(
            WebSocketSession session, CloseStatus status) throws Exception {
        log.debug("WebSocket connection closed");
        System.out.printf("%s 연결 끊김\n", session.getId());
    }

}