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
public class Qboard {
	public int qb_idx;
	@NonNull
	public String qb_title;
	@NonNull
	public String qb_content;
	@NonNull
	public String qb_file;
	public String qb_dt;
	public int qb_views;
	@NonNull
	public String user_id;
	public Qboard(int qb_idx, @NonNull String qb_title, @NonNull String qb_content, @NonNull String qb_file,
			@NonNull String user_id) {
		super();
		this.qb_idx = qb_idx;
		this.qb_title = qb_title;
		this.qb_content = qb_content;
		this.qb_file = qb_file;
		this.user_id = user_id;
	}
	
}
