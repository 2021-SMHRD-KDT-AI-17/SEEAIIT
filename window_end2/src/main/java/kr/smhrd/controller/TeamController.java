package kr.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.entity.Member;
import kr.smhrd.entity.Team;
import kr.smhrd.mapper.TeamMapper;
import lombok.NonNull;

@Controller
public class TeamController {
	
	@Autowired
	private TeamMapper teamMapper;
	
	
	// 팀 메인으로 가기
	@RequestMapping("/goTeamMain")
	public String teamMake(Model model) {
		
		List<Team> t_list = teamMapper.selectTeam();
		model.addAttribute("t_list", t_list);
		
		return "TeamMain";
	}
	
	// 팀생성 하러가기
	@RequestMapping("/goMakeTeam")
	public String goMakeTeam() {
		return "TeamMake";
	}
	
	// 팀생성
	@RequestMapping("/teamMake")
	public String teamMake(HttpServletRequest request) {
		
		String team_name = request.getParameter("team_name");
		String team_Git = request.getParameter("team_Git");
		String team_explanation = request.getParameter("team_explanation");
		
		Team team = new Team(team_name, team_Git, team_explanation);
		teamMapper.teamMake(team);
		
		
		return "redirect:/goTeamMain";
	}
	
	// 팀 Detail 이동
	@RequestMapping("/goTeamDetail")
	public String goTeamDetail(@RequestParam("team_number") int team_number, Model model) {
		Team team = teamMapper.selectTeamDetail(team_number);
		List<Member> teamU_list = teamMapper.selectTeamMember(team_number);
		
		model.addAttribute("team", team);
		model.addAttribute("teamU_list", teamU_list);
		
		return "TeamDetail";
	}
	
	// 팀참가
	@RequestMapping("/participateTeam")
	public String participateTeam(@RequestParam("team_number") int team_number, HttpSession session) {
		
		Member member = (Member) session.getAttribute("loginMember");
		member.setTeam_number(team_number);
		teamMapper.participateTeam(member);
		
		return "redirect:/goTeamMain";
	}
	
	// 팀정보 수정하러 가기
	@RequestMapping("/goTeamUpdate")
	public String goTeamUpdate(@RequestParam("team_number") int team_number, Model model) {
		
		Team team = teamMapper.selectTeamDetail(team_number);
		model.addAttribute("team", team);
		return "TeamUpdate";
	}
	
	// 팀정보 수정
	@RequestMapping("/teamUpdate")
	public String teamUpdate(@RequestParam("team_number") int team_number, HttpServletRequest request) {
		
		String team_name = request.getParameter("team_name");
		String team_Git = request.getParameter("team_Git");
		String team_URL = request.getParameter("team_URL");
		String team_explanation = request.getParameter("team_explanation");
		
		Team team = new Team(team_number, team_name, team_Git, team_URL, team_explanation);
		
		teamMapper.updateTeam(team);
		
		return "redirect:/goTeamMain";
	}

}
