package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Qboard;
import kr.smhrd.entity.QboardComment;

public interface QboardMapper {

   public List<Qboard> qbaordList();

   public int insertQboard(Qboard qboard);

   public void qboardCount(int qb_idx);

   public Qboard qboardContent(int qb_idx);

   public List<QboardComment> selectQboardComment(int num);

   public void qboardCommentJoin(QboardComment qboardComment);

   public List<Qboard> selectQboard(String select1);

   public void qboardUpdate(Qboard qboard);

   public void deleteQboard(int qb_idx);

   public void deleteQboardComment(int qb_idx);

   
   

}