package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Announcement;

public interface AnnouncementMapper {

   public List<Announcement> annList();

   public int insertAnnouncement(Announcement announcement);

   public Announcement announcementdetail(int ann_idx);
   
   

}