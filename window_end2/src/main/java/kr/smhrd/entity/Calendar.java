package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class Calendar {
	
	
	 private String title;
	 private String start;
	 private String end;
	 private String backgroundColor;
	 private boolean allday;
	
	public Calendar() {
	    // 기본 생성자 내용
	}

}


