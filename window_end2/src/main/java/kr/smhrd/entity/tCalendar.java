package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
public class tCalendar {
	
	 private String title;
	 private String start;
	 private String end;
	 private String backgroundColor;
	 private boolean allday;
	
	public tCalendar() {
	    // 기본 생성자 내용
	}

}
