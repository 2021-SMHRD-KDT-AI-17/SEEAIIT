package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Comment;
import lombok.NonNull;

public interface BoardMapper {

   public int insertBoard(Board board);

   public List<Board> boardList();

   public Board boardContent(int num);

   public void deleteBoard(int num);

   public void boardCount(int num);

   public List<Board> selectBoard(String string);

   public int commentJoin(Comment comment);

   public List<Comment> selectComment(int number);

}