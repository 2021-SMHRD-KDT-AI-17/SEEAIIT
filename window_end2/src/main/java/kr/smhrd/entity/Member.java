package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.ToString;

// @Data
@AllArgsConstructor
@NoArgsConstructor
@RequiredArgsConstructor
@Getter
@Setter
@ToString
public class Member {
	private int rank_num;
	@NonNull
	private String id;
	@NonNull
	private String pw;
	private String name;
	private String email;
	private String tel;
	private String birthday;
	private int point;
	private int team_number;
}
