package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Fboard;
import kr.smhrd.entity.FboardComment;

public interface FboardMapper {
   
   public List<Fboard> fboardList();
   
   public int insertFboard(Fboard fboard);
   
   public void fboardCount(int fb_idx);
   
   public Fboard fboardContent(int fb_idx);
   
   public List<FboardComment> selectFboardComment(int fb_idx);
   
   public void fboardCommentJoin(FboardComment fboardComment);

   public List<Fboard> selectFboard(String select3);

   public void fboardUpdate(Fboard fboard);

   public void deleteFboard(int fb_idx);

   public void deleteFboardComment(int fb_idx);

}