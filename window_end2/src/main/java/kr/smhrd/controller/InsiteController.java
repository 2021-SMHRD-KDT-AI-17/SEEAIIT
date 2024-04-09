package kr.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.smhrd.entity.Insite;
import kr.smhrd.mapper.InsiteMapper;

@Controller
public class InsiteController {
	
	@Autowired
	private InsiteMapper insiteMapper;
	
	// 인사이트 메인 이동
	@RequestMapping("/goInsite")
	public String goInsite(Model model) {
		
		List<Insite> insite_list =  insiteMapper.selectInsite();
		model.addAttribute("insite_list", insite_list);
		
		return "Insite";
	}

}
