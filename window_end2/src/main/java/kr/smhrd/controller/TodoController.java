package kr.smhrd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kr.smhrd.entity.Member;
import kr.smhrd.entity.Todo;
import kr.smhrd.mapper.TodoMapper;

@Controller
public class TodoController {

    @Autowired
    private TodoMapper todoMapper;

    @RequestMapping("/showTodoList")
    public String showTodoList(Model model) {
		List<Todo> t_list =todoMapper.getAllTodoItems();
		model.addAttribute("t_list",t_list);
		System.out.println(t_list);
        return "todo";
    }

    @RequestMapping("/addTodoItem")
    public String addTodoItem(@RequestParam("date") String date, @RequestParam("content") String content, HttpSession session) {
        // 세션에서 로그인 멤버 정보를 가져옴
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember != null) {
            Todo todo = new Todo();
            todo.setDate(date);
            todo.setContent(content);
            todo.setCompleted(false);
            // 투두 아이템 추가 시 로그인 멤버 정보를 사용
            todo.setLoginId(loginMember.getId());
            todoMapper.addTodoItem(todo);
            return "redirect:/showTodoList";
        } else {
            return "redirect:/login"; // 로그인되어 있지 않으면 로그인 페이지로 이동
        }
    }

    @RequestMapping("/updateTodoItem")
    public String updateTodoItem(@RequestParam Long id, @RequestParam(defaultValue = "false") boolean completed) {
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        params.put("completed", completed);
        todoMapper.updateTodoItem(params);
        return "redirect:/showTodoList";
    }

    @RequestMapping("/deleteTodoItem")
    public String deleteTodoItem(@RequestParam Long id) {
        todoMapper.deleteTodoItem(id);
        System.out.println("삭제하기~!@");
        return "redirect:/showTodoList";
    }
}