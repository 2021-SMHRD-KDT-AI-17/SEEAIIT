package kr.smhrd.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.smhrd.entity.Announcement;
import kr.smhrd.entity.Board;
import kr.smhrd.mapper.AnnouncementMapper;

@Controller
public class AnnouncementController {
   
   @Autowired
   private AnnouncementMapper announcementMapper;
   
   
   // 공지사항 들어가기
   @RequestMapping("/goAnnouncement")
   public String goAnnouncement(Model model) {
      List<Announcement> a_list =  announcementMapper.annList();
      
      model.addAttribute("a_list", a_list);
      return "announcement";
   }
   
   // 공지사항 작성하러 가기
   @RequestMapping("/goAnnouncementWrite")
   public String goAnnouncementWrite() {
      
      return "announcement_write";
   }
   
   // 공지사항 작성하기
   @RequestMapping("/announcementInsert")
      public String announcementInsert(Announcement announcement, HttpServletRequest request) {
         
            String title = request.getParameter("title");
            String teacher_id = request.getParameter("writer");
            String content = request.getParameter("content");
            
            announcement = new Announcement(title, teacher_id, content);
            
            
            System.out.println(announcement.toString());
         
            int cnt = announcementMapper.insertAnnouncement(announcement);
         
         if(cnt >0) {
            System.out.println("업로드 성공!");
         }else {
            System.out.println("업로드 실패...");
         }
         
         return "redirect:/goAnnouncement";
      }
   
   // 공지사항 세부내용 보기
   @RequestMapping("/annDetail")
      public String annDetail(@RequestParam("ann_idx") int ann_idx, Model model) {
      Announcement announcement = announcementMapper.announcementdetail(ann_idx);
      model.addAttribute("announcement", announcement);
      
      return "announcement_detail";
   }

}