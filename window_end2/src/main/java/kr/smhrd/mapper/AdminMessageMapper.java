package kr.smhrd.mapper;

import java.util.List;

import kr.smhrd.entity.AdminMessage;

public interface AdminMessageMapper {

	public void sendMessage(AdminMessage adminMessage);

	public List<AdminMessage> selectMessage();

	public AdminMessage selectMessageDetail(int message_idx);

}
