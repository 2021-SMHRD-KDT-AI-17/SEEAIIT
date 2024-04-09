package kr.smhrd.mapper;

import java.util.List;
import java.util.Map;

import kr.smhrd.entity.Todo;

public interface TodoMapper {



	void deleteTodoItem(Long id);
	
    List<Todo> getAllTodoItems();

	void addTodoItem(Todo todo);

	void updateTodoItem(Map<String, Object> params);

}
