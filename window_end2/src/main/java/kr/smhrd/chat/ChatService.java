package kr.smhrd.chat;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class ChatService {
//    private final ObjectMapper objectMapper;
//    private final List<ChatMessageDTO> chatHistory = new ArrayList<>(); // 채팅 기록을 메모리에 저장합니다.
//    private final String CHAT_HISTORY_FILE_PATH = "C:\\Users\\smhrd\\Desktop\\teamspace\\window120\\src\\main\\webapp\\resources\\assets\\chathis.json";
   
    public void init() {
//        loadChatHistoryFromFile(); // 애플리케이션 시작 시 파일에서 채팅 기록을 로드합니다.
    	loadChatHistoryFromDatabase();
    }
    
	/*
	 * public List<ChatMessageDTO> getChatHistory() {
	 * log.debug("Retrieving chat history"); loadChatHistoryFromDatabase(); return
	 * chatHistory; }
	 */

    public List<ChatMessageDTO> getChatHistory() {
        log.debug("Retrieving chat history from database");
        return loadChatHistoryFromDatabase();
    }
    
    // 채팅 기록 파일에서 기록을 로드합니다.
//    private void loadChatHistoryFromFile() {
//        log.debug("Loading chat history from file");
//        File file = new File(CHAT_HISTORY_FILE_PATH);
//        if (file.exists()) {
//            try {
//                chatHistory.addAll(objectMapper.readValue(file, new TypeReference<List<ChatMessageDTO>>() {}));
//            } catch (IOException e) {
//                log.error("Failed to load chat history from file: {}", e.getMessage(), e);
//            }
//        }
//    }

    
    
    
	
	  // 새로운 채팅 메시지를 저장하고 파일에 저장합니다. 
//    public void saveMessage(ChatMessageDTO message) { 
//    	log.debug("Saving chat message: {}", message); if
//	  (!isJoinLeaveMessage(message.getType())) { // JOIN 또는 LEAVE 메시지인 경우 저장하지 않음
//	  message.setType(ChatMessageDTO.MessageType.HIS); // 채팅 메시지의 타입을 HIS로 변경
//	  chatHistory.add(message); // 메모리에 채팅 기록을 추가합니다. 
//	  saveChatHistoryToFile(); //파일에 채팅 기록을 저장합니다. 
//	  } 
//    }
	 

    // 채팅 기록을 파일에 저장합니다.
//    private void saveChatHistoryToFile() {
//        log.debug("Saving chat history to file");
//        try {
//            objectMapper.writeValue(new File(CHAT_HISTORY_FILE_PATH), chatHistory);
//        } catch (IOException e) {
//            log.error("Failed to save chat history to file: {}", e.getMessage(), e);
//        }
//    }

    // JOIN 또는 LEAVE 메시지인지 확인합니다.
    private boolean isJoinLeaveMessage(ChatMessageDTO.MessageType messageType) {
        return messageType == ChatMessageDTO.MessageType.JOIN || 
               messageType == ChatMessageDTO.MessageType.LEAVE||
               messageType == ChatMessageDTO.MessageType.HIS;
    }
    
    
    
//    =================================================================================
//  =============================================================================================
    @Autowired
    private JdbcTemplate jdbcTemplate;
  
    public void saveMessage(ChatMessageDTO message) {
        if (!isJoinLeaveMessage(message.getType())) {
            saveChatMessageToDatabase(message);
        }
    }
    
    
    private void saveChatMessageToDatabase(ChatMessageDTO message) {
        String sql = "INSERT INTO chat_message (sender, content, timestamp) VALUES (?, ?, ?)";
        jdbcTemplate.update(sql, message.getSender(), message.getContent(), message.getTimestamp());
    }
    
    
    
    
    
  public ChatService(JdbcTemplate jdbcTemplate) {
//    this.objectMapper = new ObjectMapper();
	this.jdbcTemplate = jdbcTemplate;
  }

  
  
  
  public List<ChatMessageDTO> loadChatHistoryFromDatabase() {
      String sql = "SELECT sender, content, timestamp FROM chat_message "; // 채팅 기록을 조회하는 SQL 쿼리
      List<ChatMessageDTO> chatHistoryFromDatabase = jdbcTemplate.query(sql, (rs, rowNum) -> {
          ChatMessageDTO chatMessage = new ChatMessageDTO();
          chatMessage.setSender(rs.getString("sender"));
          chatMessage.setContent(rs.getString("content"));
          chatMessage.setTimestamp(rs.getString("timestamp"));
          chatMessage.setType(ChatMessageDTO.MessageType.HIS);
          return chatMessage;
      });
      
//      chatHistory.addAll(chatHistoryFromDatabase); // 채팅 기록을 가져와서 메모리에 추가
//      
      return chatHistoryFromDatabase; // 데이터베이스에서 가져온 채팅 기록 반환
  }
 


    


}