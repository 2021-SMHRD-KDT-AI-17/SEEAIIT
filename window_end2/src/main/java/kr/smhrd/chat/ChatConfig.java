package kr.smhrd.chat;

import java.security.Principal;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class ChatConfig implements WebSocketMessageBrokerConfigurer {
   
    @Autowired
    private ChatService chatService; // ChatService 주입
    
    @Autowired
    private SimpMessagingTemplate messagingTemplate; // SimpMessagingTemplate 주입

    
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
       registry.addEndpoint("controller/chatf/ws").setAllowedOrigins("http://localhost:8099/").withSockJS();
        System.out.println("소켓연결");
    }


    // STOMP에서 사용하는 메시지 브로커 설정
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.setApplicationDestinationPrefixes("/app");
        registry.enableSimpleBroker("/queue","/topic");
        registry.setUserDestinationPrefix("/user");
    }

    
    @MessageMapping("/chat.sendMessage")
    public ChatMessageDTO sendMessage(@Payload ChatMessageDTO chatMessage) {
        // 받은 메시지를 브로드캐스트
        return chatMessage;
    }
    
    

    @MessageMapping("/chat.getHistory")
    public void sendChatHistory(Principal principal) {
        String username = principal.getName();
        List<ChatMessageDTO> chatHistory = chatService.getChatHistory();
        String destination = "/user/" + username + "/queue/history";
        messagingTemplate.convertAndSend(destination, chatHistory);
    }
    
    
    
    @Bean
    public DataSource dataSource() {
        DriverManagerDataSource dataSource = new DriverManagerDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://project-db-campus.smhrd.com:3307/campus_23K_AI17_p2_4");
        dataSource.setUsername("campus_23K_AI17_p2_4");
        dataSource.setPassword("smhrd4");
        return dataSource;
    }

    @Bean
    public JdbcTemplate jdbcTemplate(DataSource dataSource) {
        return new JdbcTemplate(dataSource);
    }
    
//    =============================================================================================

    
}
    
    
