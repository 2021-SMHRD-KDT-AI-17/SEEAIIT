package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class Todo {
	
	private Long id;
    private String date;
    private String content;
    private boolean completed;
    private String loginId;
    
	public Todo() {
	    // 기본 생성자 내용
	}

}
