package kr.smhrd.entity;

import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@RequiredArgsConstructor
public class AdminMessage {
	
	private int message_idx;
	@NonNull private String user_id;
	@NonNull private String catagory;
	@NonNull private String message_title;
	@NonNull private String message;
	private String message_dt;
	

}
