package kr.smhrd.entity;

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
public class FboardComment {
	
	public int cmt_idx;
	@NonNull
	public int fb_idx;
	@NonNull
	public String cmt_content;
	public String cmt_dt;
	@NonNull
	public String user_id;

}