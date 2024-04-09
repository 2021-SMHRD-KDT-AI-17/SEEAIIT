package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@RequiredArgsConstructor
public class Message {
	
	private int num;
	@NonNull
	private String sendE;
	@NonNull
	private String receiveE;
	@NonNull
	private String message;
	private String m_date;
	
}
