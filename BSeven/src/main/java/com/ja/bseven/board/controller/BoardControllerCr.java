package com.ja.bseven.board.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.ja.bseven.board.service.BoardServiceCr;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.cr.CR_BoardVo;
import com.ja.bseven.vo.cr.CR_ReplyVo;
import com.ja.bseven.vo.cr.CR_boardContentImageVo;
import com.ja.bseven.vo.cr.CR_boardLikeVO;

@Controller
@RequestMapping("/boardCr/*")
public class BoardControllerCr {
	
	@Autowired
	private BoardServiceCr boardServiceCr;
	
	@RequestMapping("/CR_board")
	public String boardHome(
			Model model, 
			@RequestParam(value = "pageNum", defaultValue = "1" ) int pageNum,
			String searchOption,
			String searchWord) {

		
		ArrayList<HashMap<String, Object>> boardData = boardServiceCr.getBoardList(pageNum, searchOption, searchWord);
		
		int boardCount = boardServiceCr.getBoardCount();
		
		int pageCount = (int) Math.ceil(boardCount/9.0);

		int startNum = ((pageNum-1)/2 * 2) + 1;
		int endNum = startNum + 1;
		
		String search = "&searchOption=" + searchOption + "&searchWord=" + searchWord;
		
		
		
		
		if( endNum > pageCount) {
			endNum = pageCount;
		}
		
		String page = "boardCr/CR_board";
		model.addAttribute("boardData", boardData);
		model.addAttribute("startNum", startNum);
		model.addAttribute("endNum", endNum);
		model.addAttribute("pageCount", pageCount);
		model.addAttribute("search", search);
		model.addAttribute("page", page);

		
		return "/boardCr/CR_board";
	}
	
	@RequestMapping("/CR_writeBoard")
	public String boardWrite() {
		
		return "/boardCr/CR_writeBoard";
	}
	
	@RequestMapping("/CR_boardWriteProcess")
	public String boardWriteProcess(CR_BoardVo boardVo, MultipartFile[] uploadFiles, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		
		ArrayList<CR_boardContentImageVo> imageList = new ArrayList<CR_boardContentImageVo>();
		
		boardVo.setMember_no(memberVo.getMember_no());
		System.out.println("insert boardVo_member_no: " + boardVo.getMember_no());
		
		String uploadFolder = "C:/uploadFolder2/";
		
		// 날짜별 폴더 생성
		Date today = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
		String folderPath = sdf.format(today);
		File todayFolder = new File(uploadFolder+folderPath);
		
		if(!todayFolder.exists()) {
			todayFolder.mkdirs();
		}
		
		if(uploadFiles != null) {
			for(MultipartFile file : uploadFiles) {
				if(file.isEmpty()) {
					continue;
				}
				UUID uuid = UUID.randomUUID();
				String fileName = uuid.toString();
				long time = System.currentTimeMillis();
				fileName += "_" + time;
				
				String original = file.getOriginalFilename();
				String ext = original.substring(original.lastIndexOf("."));
				fileName += ext;
				try {
					
					file.transferTo(new File(uploadFolder+folderPath+fileName));
				} catch (Exception e) {
					e.printStackTrace();
				}
				CR_boardContentImageVo imageVo = new CR_boardContentImageVo();
				imageVo.setBci_uri(folderPath+fileName);
				imageVo.setBci_originalName(original);
				imageList.add(imageVo);
				
			}
		}
		
		boardServiceCr.writeNewBoard(boardVo, imageList);
		
		return "redirect: ./CR_board";
	}
	
	// board detail view
	@RequestMapping("/detailBoard")
	public String detailBoard(Model model, int board_no, HttpSession session) {
		HashMap<String, Object> boardData = boardServiceCr.getBoard(board_no);
		model.addAttribute("boardData", boardData);
		
		ArrayList<HashMap<String, Object>> replyList = boardServiceCr.getReplyList(board_no);
		model.addAttribute("replyList", replyList);
		model.addAttribute("replyCount", replyList.size());
		
		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
		
		if (memberVo != null) {
			CR_boardLikeVO likeVo = new CR_boardLikeVO();
			likeVo.setBoard_no(board_no);
			likeVo.setMember_no(memberVo.getMember_no());
			int like = boardServiceCr.getboardLike(likeVo);
			model.addAttribute("like", like);
		}
		boardServiceCr.updateBoardView(board_no);
		
		return "/boardCr/detailBoard";
	}
	
	// 수정 board 불러오기
	@RequestMapping("/updateBoard")
	public String updateBoard(Model model, int board_no) {
		System.out.println("board를 받았다" + board_no);
		
		HashMap<String, Object> boardData = boardServiceCr.getBoard(board_no);
		
		CR_BoardVo boardVo = (CR_BoardVo) boardData.get("boardVo");
		model.addAttribute("boardVo", boardVo);
		//가져와야대
		
		return "/boardCr/updateBoard";
	}
	
	// board 수정 데이터베이스에 등록
	@RequestMapping("/updateBoardProcess")
	public String updateBoardProcess(CR_BoardVo boardVo) {
		boardServiceCr.updateBoard(boardVo);
		return "redirect: ./CR_board";
	}
	
	// board 삭제
	@RequestMapping("/deleteBoardProcess")
	public String deleteBoardProcess(int board_no){
		boardServiceCr.deleteBoard(board_no);
		
		return "redirect: ./CR_board";
	}
	
	@RequestMapping("/insertBoardReply")
	public String insertBoardReply(CR_ReplyVo replyVo, HttpSession session) {
		MemberVo memberVo = (MemberVo) session.getAttribute("sessionUser");
		replyVo.setMember_no(memberVo.getMember_no());
		boardServiceCr.insertBoardReply(replyVo);
		return "redirect: ./detailBoard?board_no="+replyVo.getBoard_no();
	}
	
	@RequestMapping("/deleteReplyProcess")
	public String deleteReplyProcess(int reply_no, int board_no) {
		boardServiceCr.deleteReply(reply_no);
		
		return "redirect: ./detailBoard?board_no="+board_no;
	}
	
	@RequestMapping("/doLike")
	public String doLike(int board_no, HttpSession session) {
		CR_boardLikeVO likeVo = new CR_boardLikeVO();
		likeVo.setBoard_no(board_no);
		System.out.println(likeVo.getBoard_no());
		MemberVo memberVo =  (MemberVo) session.getAttribute("sessionUser");
		likeVo.setMember_no(memberVo.getMember_no());
		System.out.println(likeVo.getMember_no());
		boardServiceCr.doLike(likeVo);
		return "redirect: ./detailBoard?board_no="+board_no;
	}
}
