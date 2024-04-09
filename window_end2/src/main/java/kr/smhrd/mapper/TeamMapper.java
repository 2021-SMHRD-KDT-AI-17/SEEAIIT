package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Member;
import kr.smhrd.entity.Team;

public interface TeamMapper {

	public void teamMake(Team team);

	public List<Team> selectTeam();

	public void participateTeam(Member member);

	public Team selectTeamDetail(int team_number);

	public List<Member> selectTeamMember(int team_number);

	public void updateTeam(Team team);



	

}
