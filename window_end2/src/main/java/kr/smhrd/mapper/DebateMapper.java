package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Debate;
import kr.smhrd.entity.DebateComment;

public interface DebateMapper {

   public List<Debate> debateList();

   public int insertDebate(Debate debate);

   public void debateCount(int d_idx);

   public Debate debateContent(int d_idx);

   public List<DebateComment> selectDebateComment(int d_idx);

   public void debateCommentJoin(DebateComment debateComment);

   public List<Debate> selectDebate(String select2);

   public void debateUpdate(Debate debate);

   public void deleteDebate(int d_idx);

   public void deleteDebateComment(int d_idx);




}