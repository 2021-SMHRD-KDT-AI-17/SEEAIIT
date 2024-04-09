package kr.smhrd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.smhrd.entity.Member;
import kr.smhrd.mapper.MemberMapper;

// 비동기 방식만 가능
// 데이터, 객체 리턴
// 페이지 이동 불가능
@org.springframework.web.bind.annotation.RestController
public class RestController {
	
	@Autowired
	private MemberMapper memberMapper;
	
	// Email 중복체크 /emailCheck
	@RequestMapping("/emailCheck")
	public @ResponseBody int emailCheck(@RequestParam("inputE") String inputE) {
		Member member = memberMapper.emailCheck(inputE);

		if (member == null) {
			// 사용가능
			return 1;
		} else {
			// 사용불가능
			return 0;
		}

	}
	// 아이디 중복체크 /IDCheck
	@RequestMapping("/LoginCheck")
	public @ResponseBody int LoginCheck(@RequestParam("inputID") String inputID,  @RequestParam("inputPW") String inputPW) {
		Member member = memberMapper.LoginCheck(inputID);
		
		
		
		if (member == null) {
			// 사용가능
			return 1;
		} else {
			if (member.getPw().equals(inputPW)) {
				return 2;
			}else {
				return 3;
			}
		}

	}

}
