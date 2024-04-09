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
public class Team {

	
	private int team_number;
	@NonNull private String team_name;
	@NonNull private String team_Git;
	private String team_URL;
	@NonNull private String team_explanation;
	
}
