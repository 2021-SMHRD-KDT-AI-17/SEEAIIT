package kr.smhrd.chat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChatMessageDTO {
    private String sender; // 발신자
    private String content; // 내용
    private String timestamp; // 타임스탬프
    private MessageType type; // 메시지 타입
    // 생성자, getter 및 setter 메서드는 필요에 따라 추가할 수 있습니다.

    
    public enum MessageType{
        JOIN, CHAT, LEAVE,HIS;
    }


 
    
}