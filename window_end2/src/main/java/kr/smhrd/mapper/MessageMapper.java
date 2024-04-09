package kr.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.smhrd.entity.Message;
import lombok.NonNull;

@Mapper
public interface MessageMapper {

	public void messageSend(Message message);

	public List<Message> messageList(@NonNull String email);

	public void deleteMessage(int num);

	public void deleteAllMessage(String email);

	

}
