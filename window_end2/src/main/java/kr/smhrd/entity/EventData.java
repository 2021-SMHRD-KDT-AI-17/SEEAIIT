package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@Getter
@Setter
@ToString
@RequiredArgsConstructor
public class EventData {
	
	@NonNull private String title;
	@NonNull private String start;
	@NonNull private String end;
	 private String backgroundColor;
	 private boolean allday;
	 
		public EventData() {
		    // 기본 생성자 내용
		}
}
