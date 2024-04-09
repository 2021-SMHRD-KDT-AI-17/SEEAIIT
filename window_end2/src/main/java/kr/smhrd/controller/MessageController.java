package kr.smhrd.controller;

import java.lang.reflect.Parameter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.entity.Member;
import kr.smhrd.entity.Message;
import kr.smhrd.mapper.MessageMapper;

@Controller
public class MessageController {
	
	@Autowired
	private MessageMapper messageMapper;
	
	// 메세지 보내기
	@RequestMapping("/messageSend")
	public String messageSend(Message message) { // sendE, receiveE, message
		//System.out.println(message.toString());
		messageMapper.messageSend(message);
		
		return "Main";
	}
	
	// 메세지 개별삭제
	@RequestMapping("/deleteMessage")
	public String deleteMessage(@RequestParam("num") int num, HttpSession session) { // /deleteMessage?num=28
		messageMapper.deleteMessage(num);
		Member member = (Member)session.getAttribute("loginMember");
		List<Message> m_list = messageMapper.messageList(member.getEmail());
		session.setAttribute("m_list", m_list);
		return "Main";
	}
	
	// 메세지 전체삭제
	@RequestMapping("/deleteAllMessage")
	public String deleteAllMessage(@RequestParam("email") String email, HttpSession session) {
		messageMapper.deleteAllMessage(email);
		Member member = (Member)session.getAttribute("loginMember");
		List<Message> m_list = messageMapper.messageList(member.getEmail());
		session.setAttribute("m_list", m_list);
//		session.removeAttribute("m_list");
		return "Main";
	}
}
