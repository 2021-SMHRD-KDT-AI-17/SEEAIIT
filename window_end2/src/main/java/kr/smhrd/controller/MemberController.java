package kr.smhrd.controller;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.smhrd.entity.Attendance;
import kr.smhrd.entity.KakaoUserInfo;
import kr.smhrd.entity.Member;
import kr.smhrd.entity.Message;
import kr.smhrd.mapper.MemberMapper;
import kr.smhrd.mapper.MessageMapper;


//Handler Mapping이 Controller를 찾기위해 @(Annotation)으로 Controller라고 명시해야 함
// servlet-context.xml 파일에 어떤 패키지에서 Controller를 찾을건지 명시
@Controller
public class MemberController {
	
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberMapper memberMapper;
	
	@Autowired
	private MessageMapper messageMapper;
	
	
	// login.jsp로 이동하는 메소드
	@RequestMapping("/")
	public String main() {
		return "login";
	}
	
	@RequestMapping("/goMain")
	public String goMain() {
		return "Main";
	}
	@RequestMapping("/goJoin")
	public String goJoin() {
		return "Join";
	}
	
	   @RequestMapping("/chatf")
	    public String getChatPage() {
	        return "chat_frame"; // chat.html 페이지로 이동
	    }
	
	// 회원가입 /memberInsert
	@RequestMapping("/memberInsert")
	public String memberInsert(Member member, Model model) {
		//System.out.println(member.toString());
		memberMapper.memberInsert(member);
		model.addAttribute("id", member.getId());
		return "login";
	}
	
	// 로그인 /login
	@RequestMapping("/login")
	public String memberSelect(Member member, HttpSession session) {
	    //System.out.println(member.toString());
	    Member loginMember = memberMapper.memberSelect(member);
	    if (loginMember.getRank_num() == 1) {
	          loginMember.setName("👩‍🎓"+loginMember.getName());
	       }
	    session.setAttribute("loginMember", loginMember);
	    // 로그인한 사람의 메세지 가져오기 
	    List<Message> m_list = messageMapper.messageList(member.getId());
	    session.setAttribute("m_list", m_list);
	    return "LoginSuccess";
	}
	
	// 회원정보수정하는 페이지로 이동 /showUpdate
	@RequestMapping("/showUpdate")
	public String showUpdate() {
		return "UpdateMember";
	}
	
	// 회원정보수정 /memberUpdate
	@RequestMapping("/memberUpdate")
	public String memberUpdate(Member member, HttpSession session) {
		memberMapper.memberUpdate(member);
		session.setAttribute("loginMember", member);
		return "Main";
	}
	
	// 로그아웃 /memberLogout
	@RequestMapping("/memberLogout")
	public String memberLogout(HttpSession session) {
		//session.removeAttribute("loginMember");
		session.invalidate();
		return "login";
	}
	
	// 회원정보 페이지로 이동 + 전체회원정보 가져오기
	@RequestMapping("/goUserList")
	public String goShowMember(Model model, HttpSession session) {
		List<Member> list = memberMapper.goShowMember();
		List<Attendance> att_list1 = memberMapper.selectAtt1();
		List<Attendance> att_list2 = memberMapper.selectAtt2();
		model.addAttribute("list", list);
		model.addAttribute("att_list1", att_list1);
		model.addAttribute("att_list2", att_list2);
		
		return "ShowUser";
	}
	
	@RequestMapping("/deleteMember")
	public String deleteMember(@RequestParam("id") String id) { // /deleteMember?email=?
		memberMapper.deleteMember(id);
		return "redirect:/goShowMember";
	}
	
	@RequestMapping("/goTeacherMember")
	public String goTeacherMember(Model model) {
		List<Member> list = memberMapper.goTeacherMember();
		model.addAttribute("list", list);
		return "ShowTeacher";
	}
	
	@RequestMapping("/rankUpdate")
	public String rankUpdate(@RequestParam("id") String id) {
		memberMapper.rankUpdate(id);
		return "redirect:/goTeacherMember";
	}
	
	// 아침팝업 띄우기
	@RequestMapping("/goPopup1")
	public String goPopup1(HttpServletRequest request, Model model, Member member) {
		System.out.println("일단 넘어옴");
		Cookie[] cookies = request.getCookies();
	    String emailAttendanceCheck1 = null;
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ((member.getEmail()+"attendance_check1").equals(cookie.getName())) {
	                emailAttendanceCheck1 = cookie.getValue();
	                System.out.println("입실쿠키");
	            }
	        }
	    }

	    // 쿠키 값을 모델에 추가하여 JSP로 전달
	    model.addAttribute("emailAttendanceCheck1", emailAttendanceCheck1);

	    return "popup1"; // 뷰 이름 반환
	}
	
	// 저녁팝업 띄우기
	@RequestMapping("/goPopup2")
	public String goPopup2(HttpServletRequest request, Model model, Member member) {
		System.out.println("일단 넘어옴");
		Cookie[] cookies = request.getCookies();
	    String emailAttendanceCheck2 = null;
	    
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if ((member.getEmail()+"_attendance_check2").equals(cookie.getName())) {
	                emailAttendanceCheck2 = cookie.getValue();
	                System.out.println("퇴실쿠키");
	            }
	        }
	    }

	    // 쿠키 값을 모델에 추가하여 JSP로 전달
	    model.addAttribute("emailAttendanceCheck2", emailAttendanceCheck2);

	    return "popup2"; // 뷰 이름 반환
	}
	
	// 아침 팝업 시간데이터
	@RequestMapping("/morningPopup")
	public String morningPopup(HttpServletRequest request) {
		String name = request.getParameter("name");
		
		Attendance att = new Attendance(name);
		memberMapper.intime(att);
		return "selfClose";
	}
	
	// 저녁 팝업 시간데이터
	@RequestMapping("/eveningPopup")
	public String eveningPopup(HttpServletRequest request) {
		String name = request.getParameter("name");
		
		Attendance att = new Attendance(name);
		memberMapper.outtime(att);
		
		return "selfClose";
	}
	
	
    // 카카오 사용자 정보 가져오는 메서드
    private KakaoUserInfo getKakaoUserInfo(String accessToken) {
        // 카카오 API를 통해 accessToken을 이용하여 사용자 정보를 가져오는 로직을 구현합니다.
        // 예를 들어, RestTemplate 등을 사용하여 카카오 API에 요청하여 사용자 정보를 받아올 수 있습니다.
        // 이후 받아온 정보를 KakaoUserInfo 객체로 매핑하여 반환합니다.
        return new KakaoUserInfo(); // 예시로 빈 KakaoUserInfo 객체 반환
    }
    
    // 카카오 로그인 처리
    @RequestMapping("/kakaoLogin")
    public @ResponseBody String kakaoLogin(@RequestParam("accessToken") String accessToken) {
        // 카카오 사용자 정보 가져오기
        KakaoUserInfo userInfo = getKakaoUserInfo(accessToken);
        
        if (userInfo != null) {
            // 카카오 사용자 정보 가져오기 성공
            String kakaoEmail = userInfo.getEmail();
            
            // 가져온 이메일 주소를 기반으로 회원 가입 또는 로그인 처리
            Member member = findByEmail(kakaoEmail); // 직접 메서드 호출
            if (member != null) {
                // 이미 가입된 회원이라면 로그인 처리
                // 세션 등록 등 로그인 처리 로직을 수행
                return "카카오 로그인 성공";
            } else {
                // 가입되지 않은 회원이라면 회원 가입 처리
                // 회원 정보 저장 등 회원 가입 처리 로직을 수행
                return "카카오 회원 가입 성공";
            }
        } else {
            // 카카오 사용자 정보 가져오기 실패
            return "카카오 로그인 실패";
        }
    }
    
    private Member findByEmail(String email) {
        return memberMapper.findByEmail(email);
    }
    
}

