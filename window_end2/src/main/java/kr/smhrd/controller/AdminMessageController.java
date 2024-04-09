package kr.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.entity.AdminMessage;
import kr.smhrd.mapper.AdminMessageMapper;

@Controller
public class AdminMessageController {
	
	@Autowired
	private AdminMessageMapper adminMessageMapper;
	
	// 메세지 작성하러 가기
	@RequestMapping("/goSendAdminMessage")
	public String goSendAdminMessage() {
		return "MessageWrite";
	}
	
	// 메세지 작성
	@RequestMapping("/SendAdminMessage")
	public String SendAdminMessage(HttpServletRequest request) {
		String user_id = request.getParameter("user_id");
		String catagory = request.getParameter("catagory");
		String message_title = request.getParameter("message_title");
		String message = request.getParameter("message");
		
		AdminMessage adminMessage = new AdminMessage(user_id, catagory,message_title, message);
		adminMessageMapper.sendMessage(adminMessage);
		
		return "MessageSuccess";
		
	}
	
	// 메세지 리스트 보러가기 (관리자 기능)
	@RequestMapping("/goMessage")
	public String goMessage(Model model) {
		List<AdminMessage> mes_list = adminMessageMapper.selectMessage();
		model.addAttribute("mes_list", mes_list);
		return "Message";
	}
	
	// 메세지 보러가기 (관리자기능)
	@RequestMapping("/goMessageDetail")
	public String goMessageDetail(@RequestParam("message_idx") int message_idx, Model model) {
		
		AdminMessage message = adminMessageMapper.selectMessageDetail(message_idx);
		model.addAttribute("message", message);
		
		return "MessageDetail";
	}

}
