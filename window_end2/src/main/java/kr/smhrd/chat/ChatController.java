package kr.smhrd.chat;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessageHeaderAccessor;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/*@CrossOrigin(origins = "ws://localhost:8087")*/
@Controller
public class ChatController {

   
    private final ChatService chatService;
   
    @Autowired
   /* private ChatHandler ChatHandler; */
    private final SimpMessagingTemplate messagingTemplate;



   
   
    @MessageMapping("/chat.addUser")
    public void addUser(@Payload ChatMessageDTO chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        // Add username in web socket session
        headerAccessor.getSessionAttributes().put("name", chatMessage.getSender());
        // Create a JOIN message
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a hh시 mm분 ss초");
        String currentTime = now.format(formatter);

        ChatMessageDTO joinMessage = new ChatMessageDTO();
        joinMessage.setSender("System");
        joinMessage.setContent(chatMessage.getSender() + "님이 접속하였습니다.");
        joinMessage.setTimestamp(currentTime);
        joinMessage.setType(ChatMessageDTO.MessageType.JOIN);

        messagingTemplate.convertAndSend("/topic/public", joinMessage); // 브로드캐스트 메시지 전송

    }
    
    

    @MessageMapping("/chat.removeUser")
    public void removeUser(@Payload ChatMessageDTO chatMessage, SimpMessageHeaderAccessor headerAccessor) {
        // Remove username from web socket session
        headerAccessor.getSessionAttributes().remove("name");

        // Create a LEAVE message
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("a hh시 mm분 ss초");
        String currentTime = now.format(formatter);

        ChatMessageDTO leaveMessage = new ChatMessageDTO();
        leaveMessage.setSender("System");
        leaveMessage.setContent(chatMessage.getSender() + "님이 퇴장하였습니다.");
        leaveMessage.setTimestamp(currentTime);
        leaveMessage.setType(ChatMessageDTO.MessageType.LEAVE);

        messagingTemplate.convertAndSend("/topic/public", leaveMessage); // 브로드캐스트 메시지 전송
    }


    
    
    
    
    @RequestMapping("chatRoom")
    public String chatRoom(Model model) {

        // 모델에 roomId와 roomName을 추가합니다.
        model.addAttribute("roomId", "1");
        model.addAttribute("roomName", "1");

        return "goMain";
    }
   
    
    
    
    @MessageMapping("/chat.sendMessage")
    public void sendMessage(@Payload ChatMessageDTO chatMessage) {
        // 받은 메시지를 브로드캐스트
        messagingTemplate.convertAndSend("/topic/public", chatMessage);

        // 저장하고자 하는 경우
        if (chatMessage.getType() == ChatMessageDTO.MessageType.CHAT) {
            chatService.saveMessage(chatMessage);
        }
    }



    public ChatController(ChatService chatService, SimpMessagingTemplate messagingTemplate) {
        this.chatService = chatService;
        this.messagingTemplate = messagingTemplate;
    }



   
    @MessageMapping("/chat.getHistory") // 클라이언트로부터 메시지를 받는 엔드포인트 
    @SendToUser("/queue/history")
    public List<ChatMessageDTO> endChatHistory() { 
     List<ChatMessageDTO> chatHistory =chatService.getChatHistory(); 
    System.out.println("sendChatHistory : " +chatHistory); 
    messagingTemplate.convertAndSend("/queue/history",chatHistory); 
    
    return chatHistory;
    }
    

}