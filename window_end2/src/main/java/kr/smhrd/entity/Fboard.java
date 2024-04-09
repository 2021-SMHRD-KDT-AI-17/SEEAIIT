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
public class Fboard {
	public int fb_idx;
	@NonNull
	public String fb_title;
	@NonNull
	public String fb_content;
	@NonNull
	public String fb_file;
	public String fb_dt;
	public int fb_views;
	@NonNull
	public String user_id;
	public Fboard(int fb_idx, @NonNull String fb_title, @NonNull String fb_content, @NonNull String fb_file,
			@NonNull String user_id) {
		super();
		this.fb_idx = fb_idx;
		this.fb_title = fb_title;
		this.fb_content = fb_content;
		this.fb_file = fb_file;
		this.user_id = user_id;
	}
	
}
