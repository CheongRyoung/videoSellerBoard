package com.ja.bseven.board.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ja.bseven.board.service.BoardService;

@ResponseBody
@Controller
@RequestMapping("/board/*")
public class RestBoardController {

	@Autowired
	private BoardService boardService;
	
	@RequestMapping("refreshMain")
	public HashMap<String, Object> refreshMain(String category_name, String searchWord, int pageNum) {
		HashMap<String, Object> data = new HashMap<String, Object>();

		ArrayList<HashMap<String, Object>> courseDataList = boardService.getCourseList(category_name, searchWord, pageNum);
		
		if(category_name != null ) {
			data.put("result", "main");
		} else {
			data.put("result", "category" + category_name);
		}

		data.put("courseDataList", courseDataList);
		return data;
	}

}
