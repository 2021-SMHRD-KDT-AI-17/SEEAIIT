package kr.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Debate;
import kr.smhrd.entity.DebateComment;
import kr.smhrd.entity.Fboard;
import kr.smhrd.entity.FboardComment;
import kr.smhrd.entity.Qboard;
import kr.smhrd.entity.QboardComment;
import kr.smhrd.mapper.DebateMapper;
import kr.smhrd.mapper.FboardMapper;
import kr.smhrd.mapper.QboardMapper;

@Controller
public class BoardController {
   
   @Autowired
   private DebateMapper debateMapper;
   
   @Autowired
   private QboardMapper qboardMapper;
   
   @Autowired
   private FboardMapper fboardMapper;
   
   
   // 질문 게시판 가기
   @RequestMapping("/goQboard")
   public String goQboard(Model model) {
	   
	  String page1 = "1"; 
      List<Qboard> q_list = qboardMapper.qbaordList();
      model.addAttribute("q_list", q_list);
      model.addAttribute("q_size",q_list.size());
      model.addAttribute("page1", page1);

	  return "Board";
   }
   // 토론 게시판 가기
   @RequestMapping("/goDebateBoard")
   public String goDebateBoard(Model model) {
	   
      String page2 = "1"; 
      List<Debate> d_list = debateMapper.debateList();
      model.addAttribute("d_list", d_list);
      model.addAttribute("d_size",d_list.size());
      model.addAttribute("page2", page2);
		      
      return "Board2";
   }
   
   // 수업자료 게시판 가기
   @RequestMapping("/goDataBoard")
   public String goDataBoard(Model model) {
	   
      String page3 = "1";
      
      List<Fboard> f_list = fboardMapper.fboardList();
      model.addAttribute("f_list", f_list);
      model.addAttribute("f_size",f_list.size());
      model.addAttribute("page3", page3);
      return "Board3";
   }
   
   // 게시판 이동
   @RequestMapping("/goBoardMain")
   public String goBoardMain(Model model) {
      
      String page1 = "1"; 
      List<Qboard> q_list = qboardMapper.qbaordList();
      model.addAttribute("q_list", q_list);
      model.addAttribute("q_size",q_list.size());
      model.addAttribute("page1", page1);
      
      return "Board";
   }
   
    
     // 질문게시판 2페이지 이동
   @RequestMapping("/goQboardMain2")
   public String goQboardMain2(Model model) {
      String page1 = "2";
      List<Qboard> q_list = qboardMapper.qbaordList();
      model.addAttribute("q_list", q_list);
      model.addAttribute("q_size", q_list.size());
      model.addAttribute("page1", page1);
      
      return "Board";
   }
   
     // 질문게시판 3페이지 이동
   @RequestMapping("/goQboardMain3")
   public String goQboardMain3(Model model) {
      String page1 = "3";

      List<Qboard> q_list = qboardMapper.qbaordList();
      model.addAttribute("q_list", q_list);
      model.addAttribute("q_size", q_list.size());
      model.addAttribute("page1", page1);
      
      return "Board";
   }
   
   // 수업자료 게시판 2페이지 이동
   @RequestMapping("/goFboardMain2")
   public String goFboardMain2(Model model) {
	   
      String page3 = "2";
      List<Fboard> f_list = fboardMapper.fboardList();
      model.addAttribute("f_list", f_list);
      model.addAttribute("f_size", f_list.size());
      model.addAttribute("page3", page3);

      return "Board3";
   }
   
   // 수업자료 게시판 3페이지 이동
   @RequestMapping("/goFboardMain3")
   public String goFboardMain3(Model model) {

      String page3 = "3";
      List<Fboard> f_list = fboardMapper.fboardList();
      model.addAttribute("f_list", f_list);
      model.addAttribute("f_size", f_list.size());
      model.addAttribute("page3", page3);

      return "Board3";
   }
   
   // 토론 게시판 2페이지 이동
   @RequestMapping("/goDebateMain2")
   public String goDebateMain2(Model model) {
	   
      String page2 = "2";
      List<Debate> d_list = debateMapper.debateList();
      model.addAttribute("d_list", d_list);
      model.addAttribute("d_size", d_list.size());
      model.addAttribute("page2", page2);

      return "Board2";
   }
   
   // 토론 게시판 3페이지 이동
   @RequestMapping("/goDebateMain3")
   public String goDebateMain3(Model model) {
	   
      String page2 = "3";
      List<Debate> d_list = debateMapper.debateList();
      model.addAttribute("d_list", d_list);
      model.addAttribute("d_size", d_list.size());
      model.addAttribute("page2", page2);

      return "Board2";
   }
    
   
   // 토론 게시판 작성하러 가기
   @RequestMapping("/goDebateWrite")
   public String goDebateWrite() {
      return "DebateWrite";
   }
   
   // 질문 게시판 작성하러 가기
   @RequestMapping("/goQboardWrite")
   public String goQboardWrite() {
      return "QboardWrite";
   }
   
   // 수업자료 게시판 작성하러 가기
   @RequestMapping("/goFboardWrite")
   public String goFboardWrite() {
      return "FboardWrite";
   }
   
   // 토론 게시판 등록
   @RequestMapping("/DebateInsert")
      public String boardInsert(Debate debate, HttpServletRequest request) {
         String path = request.getRealPath("resources/image");
         int size = 1024 * 1024 * 100;
         String encoding = "UTF-8";
         DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
         
         try {
            MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
            String d_title = multi.getParameter("d_title");
            String d_content = multi.getParameter("d_content");
            String d_file="";
            if(multi.getFilesystemName("d_file") == null) {
               d_file = "";
            }else {
               d_file = multi.getFilesystemName("d_file");
            }
            String user_id = multi.getParameter("user_id");
            debate = new Debate(d_title, d_content, d_file, user_id);
            System.out.println(debate.toString());
         } catch (IOException e) {
            e.printStackTrace();
         }
         int cnt = debateMapper.insertDebate(debate);
         if(cnt >0) {
            System.out.println("업로드 성공!");
         }else {
            System.out.println("업로드 실패...");
         }
         return "redirect:/goDebateBoard";
      }
   
   // 질문 게시판 등록
      @RequestMapping("/QbaordInsert")
      public String QbaordInsert(Qboard qboard, HttpServletRequest request) {
            String path = request.getRealPath("resources/image");
            int size = 1024 * 1024 * 100;
            String encoding = "UTF-8";
            DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
            
            try {
               MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
               String qb_title = multi.getParameter("qb_title");
               String qb_content = multi.getParameter("qb_content");
               String qb_file="";
               if(multi.getFilesystemName("qb_file") == null) {
                  qb_file = "";
               }else {
                  qb_file = multi.getFilesystemName("qb_file");
               }
               String user_id = multi.getParameter("user_id");
               qboard = new Qboard(qb_title, qb_content, qb_file, user_id);
            } catch (IOException e) {
               e.printStackTrace();
            }
            int cnt = qboardMapper.insertQboard(qboard);
            if(cnt >0) {
               System.out.println("업로드 성공!");
            }else {
               System.out.println("업로드 실패...");
            }
            return "redirect:/goBoardMain";
         }
   // 수업자료 게시판 등록
   @RequestMapping("/FbaordInsert")
      public String FbaordInsert(Fboard fboard, HttpServletRequest request) {
            String path = request.getRealPath("resources/image");
            int size = 1024 * 1024 * 100;
            String encoding = "UTF-8";
            DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
            
            try {
               MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
               String fb_title = multi.getParameter("fb_title");
               String fb_content = multi.getParameter("fb_content");
               String fb_file="";
               if(multi.getFilesystemName("fb_file") == null) {
                  fb_file = "";
               }else {
                  fb_file = multi.getFilesystemName("fb_file");
               }
               String user_id = multi.getParameter("user_id");
               
               fboard = new Fboard(fb_title, fb_content, fb_file, user_id);
               System.out.println(fboard.toString());
            } catch (IOException e) {
               e.printStackTrace();
            }
            int cnt = fboardMapper.insertFboard(fboard);
            if(cnt >0) {
               System.out.println("업로드 성공!");
            }else {
               System.out.println("업로드 실패...");
            }
            return "redirect:/goDataBoard";
         }
   
   // 토론 게시판 Detail 보기
   @RequestMapping("/DebateContent")
   public String DebateContent(@RequestParam("d_idx") int d_idx, Model model, HttpSession session) {
      debateMapper.debateCount(d_idx);
      
      Debate debate = debateMapper.debateContent(d_idx);
      model.addAttribute("debate", debate);
      int num = debate.getD_idx();
      session.setAttribute("num", num);
      
      List<DebateComment> dc_list = debateMapper.selectDebateComment(num);
      session.setAttribute("dc_list", dc_list);
      return "DebateDetail";
   }
   
   // 질문 게시판 Detail 보기
   @RequestMapping("/QboardContent")
   public String QboardContent(@RequestParam("qb_idx") int qb_idx, Model model, HttpSession session) {
      qboardMapper.qboardCount(qb_idx);
      
      Qboard qboard = qboardMapper.qboardContent(qb_idx);
      model.addAttribute("qboard", qboard);
      int num = qboard.getQb_idx();
      session.setAttribute("num", num);
      
      List<QboardComment> qbc_list = qboardMapper.selectQboardComment(num);
      session.setAttribute("qbc_list", qbc_list);
      return "QboardDetail";
   }
      
      // 수업자료 게시판 Detail 보기
   @RequestMapping("/FboardContent")
   public String FboardContent(@RequestParam("fb_idx") int fb_idx, Model model, HttpSession session) {
      fboardMapper.fboardCount(fb_idx);
      
      Fboard fboard = fboardMapper.fboardContent(fb_idx);
      model.addAttribute("fboard", fboard);
      int num = fboard.getFb_idx();
      session.setAttribute("num", num);
      
      List<FboardComment> fbc_list = fboardMapper.selectFboardComment(num);
      session.setAttribute("fbc_list", fbc_list);
      return "FboardDetail";
   }
   
   // 토론 게시판 댓글작성
   @RequestMapping("/DebateCommentJoin")
   public String DebateCommentJoin(HttpServletRequest request, HttpSession session, Model model) {
	   
	   
	  String cmt_content = request.getParameter("comment");
	  String user_id = request.getParameter("writer");
	  int d_idx = (int) session.getAttribute("num");
	   
	  DebateComment debateComment = new DebateComment(d_idx, cmt_content, user_id);
      debateMapper.debateCommentJoin(debateComment);
      
      Debate debate = debateMapper.debateContent(d_idx);
      model.addAttribute(debate);
      List<DebateComment> dc_list = debateMapper.selectDebateComment(d_idx);
      session.setAttribute("dc_list", dc_list);
      
      return "DebateDetail";
   }
   
   // 질문 게시판 댓글작성
   @RequestMapping("/QboardCommentJoin")
   public String QboardCommentJoin(HttpServletRequest request, HttpSession session, Model model) {
	  
	   
	  String cmt_content = request.getParameter("comment");
	  String user_id = request.getParameter("writer");
      int qb_idx = (int) session.getAttribute("num");
      
      QboardComment qboardComment = new QboardComment(qb_idx, cmt_content, user_id);
      qboardMapper.qboardCommentJoin(qboardComment);
      
      Qboard qboard = qboardMapper.qboardContent(qb_idx);
      model.addAttribute(qboard);
      List<QboardComment> qbc_list = qboardMapper.selectQboardComment(qb_idx);
      session.setAttribute("qbc_list", qbc_list);
      
      return "QboardDetail";
   }
   
   // 수업자료 게시판 댓글작성
   @RequestMapping("/FboardCommentJoin")
   public String FboardCommentJoin(HttpServletRequest request, HttpSession session, Model model) {
	   
	  String cmt_content = request.getParameter("comment");
	  String user_id = request.getParameter("writer");
	  int fb_idx = (int) session.getAttribute("num");
	  
	  FboardComment fboardComment = new FboardComment(fb_idx, cmt_content, user_id); 
      fboardMapper.fboardCommentJoin(fboardComment);
      
      Fboard fboard = fboardMapper.fboardContent(fb_idx);
      model.addAttribute(fboard);
      List<FboardComment> fbc_list = fboardMapper.selectFboardComment(fb_idx);
      session.setAttribute("fbc_list", fbc_list);
      
      return "FboardContent";
   }
   
   	// 질문게시판 검색기능 
	@RequestMapping("/selectQboard")
	public String selectQboard(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select1 = "%" +request.getParameter("select")+"%";
		session.setAttribute("select1", select1);
		String page1 = "1";
		List<Qboard> q_list = qboardMapper.selectQboard(select1);
		model.addAttribute("q_list",q_list);
		model.addAttribute("page1", page1);
		model.addAttribute("q_size",q_list.size());
		
		return "QboardSelectMain";
	}
	
	// 질문게시판 검색기능 1페이지
	@RequestMapping("/selectQboard1")
	public String selectQboard1(HttpSession session, Model model)	{
		
		String select1 = (String) session.getAttribute("select1");
		String page1 = "1";
		List<Qboard> q_list = qboardMapper.selectQboard(select1);
		model.addAttribute("q_list",q_list);
		model.addAttribute("page1", page1);
		model.addAttribute("q_size",q_list.size());
		
		return "QboardSelectMain";
	}
	
	
	// 질문게시판 검색기능 2페이지
	@RequestMapping("/selectQboard2")
	public String selectQboard2(HttpSession session, Model model)	{
		
		String select1 = (String) session.getAttribute("select1");
		String page1 = "2";
		List<Qboard> q_list = qboardMapper.selectQboard(select1);
		model.addAttribute("q_list",q_list);
		model.addAttribute("page1", page1);
		model.addAttribute("q_size",q_list.size());
		
		return "QboardSelectMain";
	}
	
	// 질문게시판 검색기능 3페이지
	@RequestMapping("/selectQboard3")
	public String selectQboard3(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select1 = (String) session.getAttribute("select1");
		String page1 = "3";
		List<Qboard> q_list = qboardMapper.selectQboard(select1);
		model.addAttribute("q_list",q_list);
		model.addAttribute("page1", page1);
		model.addAttribute("q_size",q_list.size());
		
		return "QboardSelectMain";
	}
	
	// 토론게시판 검색기능 
	@RequestMapping("/selectDebate")
	public String selectDebate(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select2 = "%" +request.getParameter("select")+"%";
		session.setAttribute("select2", select2);
		String page2 = "1";
		List<Debate> d_list = debateMapper.selectDebate(select2);
		model.addAttribute("d_list",d_list);
		model.addAttribute("page2", page2);
		model.addAttribute("d_size",d_list.size());
		
		return "DebateSelectMain";
	}
	
	// 토론게시판 검색기능 1페이지
	@RequestMapping("/selectDebate1")
	public String selectDebate1(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select2 = (String) session.getAttribute("select2");
		String page2 = "1";
		List<Debate> d_list = debateMapper.selectDebate(select2);
		model.addAttribute("d_list",d_list);
		model.addAttribute("page2", page2);
		model.addAttribute("d_size",d_list.size());
		
		return "DebateSelectMain";
	}
	
	// 토론게시판 검색기능 2페이지
	@RequestMapping("/selectDebate2")
	public String selectDebate2(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select2 = (String) session.getAttribute("select2");
		String page2 = "2";
		List<Debate> d_list = debateMapper.selectDebate(select2);
		model.addAttribute("d_list",d_list);
		model.addAttribute("page2", page2);
		model.addAttribute("d_size",d_list.size());
		
		return "DebateSelectMain";
	}
	
	// 토론게시판 검색기능 3페이지
	@RequestMapping("/selectDebate3")
	public String selectDebate3(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select2 = (String) session.getAttribute("select2");
		String page2 = "3";
		List<Debate> d_list = debateMapper.selectDebate(select2);
		model.addAttribute("d_list",d_list);
		model.addAttribute("page2", page2);
		model.addAttribute("d_size",d_list.size());
		
		return "DebateSelectMain";
	}
	
	// 수업자료 게시판 검색기능 
	@RequestMapping("/selectFboard")
	public String selectFboard(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select3 = "%" +request.getParameter("select")+"%";
		session.setAttribute("select3", select3);
		String page3 = "1";
		List<Fboard> f_list = fboardMapper.selectFboard(select3);
		model.addAttribute("f_list",f_list);
		model.addAttribute("page3", page3);
		model.addAttribute("f_size",f_list.size());
		
		return "FboardSelectMain";
	}
	
	// 수업자료 게시판 검색기능 1페이지
	@RequestMapping("/selectFboard1")
	public String selectFboard1(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select3 = (String) session.getAttribute("select3");
		String page3 = "1";
		List<Fboard> f_list = fboardMapper.selectFboard(select3);
		model.addAttribute("f_list",f_list);
		model.addAttribute("page3", page3);
		model.addAttribute("f_size",f_list.size());
		
		return "FboardSelectMain";
	}
	
	// 수업자료 게시판 검색기능 2페이지
	@RequestMapping("/selectFboard2")
	public String selectFboard2(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select3 = (String) session.getAttribute("select3");
		String page3 = "2";
		List<Fboard> f_list = fboardMapper.selectFboard(select3);
		model.addAttribute("f_list",f_list);
		model.addAttribute("page3", page3);
		model.addAttribute("f_size",f_list.size());
		
		return "FboardSelectMain";
	}
	
	// 수업자료 게시판 검색기능 3페이지
	@RequestMapping("/selectFboard3")
	public String selectFboard3(HttpServletRequest request ,HttpSession session, Model model)	{
		
		String select3 = (String) session.getAttribute("select3");
		String page3 = "3";
		List<Fboard> f_list = fboardMapper.selectFboard(select3);
		model.addAttribute("f_list",f_list);
		model.addAttribute("page3", page3);
		model.addAttribute("f_size",f_list.size());
		
		return "FboardSelectMain";
	}
	
	// 질문게시판 수정하러 가기
	@RequestMapping("/goQboardUpdate")
	public String goQboardUpdate(@RequestParam("qb_idx") int qb_idx, Model model) {
		
		Qboard qboard = qboardMapper.qboardContent(qb_idx);
		
		model.addAttribute(qboard);
		
		return "QboardUpdate";
	}
	
	// 질문게시판 수정기능
	@RequestMapping("/QboardUpdate")
	public String QboardUpdate(@RequestParam("qb_idx") int qb_idx, HttpServletRequest request, Qboard qboard) {

		 String path = request.getRealPath("resources/image");
         int size = 1024 * 1024 * 100;
         String encoding = "UTF-8";
         DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
         
         try {
            MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
            String qb_title = multi.getParameter("qb_title");
            String user_id = multi.getParameter("user_id");
            String qb_file="";
            if(multi.getFilesystemName("qb_file") == null) {
            	qb_file = "";
            }else {
            	qb_file = multi.getFilesystemName("qb_file");
            }
            String qb_content = multi.getParameter("qb_content");
            qboard = new Qboard(qb_idx,qb_title, qb_content, qb_file, user_id);
         } catch (IOException e) {
            e.printStackTrace();
         }
         qboardMapper.qboardUpdate(qboard);
		return "redirect:/goQboard";
	}
	
	// 질문게시판 삭제 + 해당 개시판 댓글 삭제
	@RequestMapping("/QboardDelete")
	public String QboardDelete(@RequestParam("qb_idx") int qb_idx) {
		qboardMapper.deleteQboard(qb_idx);
		qboardMapper.deleteQboardComment(qb_idx);
		
		return "redirect:/goQboard";
	}
	
	
	// 토론게시판 수정하러 가기
	@RequestMapping("/goDebateUpdate")
	public String goDebateUpdate(@RequestParam("d_idx") int d_idx, Model model) {
		
		Debate debate = debateMapper.debateContent(d_idx);
		
		model.addAttribute(debate);
		
		return "DebateUpdate";
	}
	
	// 토론게시판 수정기능
	@RequestMapping("/DebateUpdate")
	public String DebateUpdate(@RequestParam("d_idx") int d_idx, HttpServletRequest request, Debate debate) {

		 String path = request.getRealPath("resources/image");
         int size = 1024 * 1024 * 100;
         String encoding = "UTF-8";
         DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
         
         try {
            MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
            String d_title = multi.getParameter("d_title");
            String user_id = multi.getParameter("user_id");
            String d_file="";
            if(multi.getFilesystemName("d_file") == null) {
            	d_file = "";
            }else {
            	d_file = multi.getFilesystemName("d_file");
            }
            String d_content = multi.getParameter("d_content");
            debate = new Debate(d_idx,d_title, d_content, d_file, user_id);
         } catch (IOException e) {
            e.printStackTrace();
         }
         debateMapper.debateUpdate(debate);
		return "redirect:/goDebateBoard";
	}
	
	// 토론게시판 삭제 + 해당 개시판 댓글 삭제
	@RequestMapping("/DebateDelete")
	public String DebateDelete(@RequestParam("d_idx") int d_idx) {
		debateMapper.deleteDebate(d_idx);
		debateMapper.deleteDebateComment(d_idx);
		
		return "redirect:/goDebateBoard";
	}
	
	// 수업자료게시판 수정하러 가기
	@RequestMapping("/goFboardUpdate")
	public String goFboardUpdate(@RequestParam("fb_idx") int fb_idx, Model model) {
		
		Fboard fboard = fboardMapper.fboardContent(fb_idx);
		
		model.addAttribute(fboard);
		
		return "FboardUpdate";
	}
	
	// 수업자료게시판 수정기능
	@RequestMapping("/FboardUpdate")
	public String FboardUpdate(@RequestParam("fb_idx") int fb_idx, HttpServletRequest request, Fboard fboard) {

		 String path = request.getRealPath("resources/image");
         int size = 1024 * 1024 * 100;
         String encoding = "UTF-8";
         DefaultFileRenamePolicy rename = new DefaultFileRenamePolicy();
         
         try {
            MultipartRequest multi = new MultipartRequest(request, path, size, encoding, rename);
            String fb_title = multi.getParameter("fb_title");
            String user_id = multi.getParameter("user_id");
            String fb_file="";
            if(multi.getFilesystemName("fb_file") == null) {
            	fb_file = "";
            }else {
            	fb_file = multi.getFilesystemName("fb_file");
            }
            String fb_content = multi.getParameter("fb_content");
            fboard = new Fboard(fb_idx,fb_title, fb_content, fb_file, user_id);
         } catch (IOException e) {
            e.printStackTrace();
         }
         fboardMapper.fboardUpdate(fboard);
		return "redirect:/goDataBoard";
	}
	
	// 수업자료게시판 삭제 + 해당 개시판 댓글 삭제
	@RequestMapping("/FboardDelete")
	public String FboardDelete(@RequestParam("fb_idx") int fb_idx) {
		fboardMapper.deleteFboard(fb_idx);
		fboardMapper.deleteFboardComment(fb_idx);
		
		return "redirect:/goDataBoard";
	}
	
	
	
	
   
   
}