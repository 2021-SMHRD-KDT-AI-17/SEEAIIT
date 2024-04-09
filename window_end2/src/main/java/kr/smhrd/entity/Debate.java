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
public class Debate {
	public int d_idx;
	@NonNull
	public String d_title;
	@NonNull
	public String d_content;
	@NonNull
	public String d_file;
	public String d_dt;
	public int d_views;
	@NonNull
	public String user_id;
	public Debate(int d_idx, @NonNull String d_title, @NonNull String d_content, @NonNull String d_file,
			@NonNull String user_id) {
		super();
		this.d_idx = d_idx;
		this.d_title = d_title;
		this.d_content = d_content;
		this.d_file = d_file;
		this.user_id = user_id;
	}
	
}
