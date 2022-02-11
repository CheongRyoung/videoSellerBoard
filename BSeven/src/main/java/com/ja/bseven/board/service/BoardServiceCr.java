package com.ja.bseven.board.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ja.bseven.board.mapper.BoardSQLMapperCr;
import com.ja.bseven.member.mapper.MemberSQLMapper;
import com.ja.bseven.vo.MemberVo;
import com.ja.bseven.vo.cr.CR_BoardVo;
import com.ja.bseven.vo.cr.CR_ReplyVo;
import com.ja.bseven.vo.cr.CR_boardContentImageVo;
import com.ja.bseven.vo.cr.CR_boardLikeVO;

@Service
public class BoardServiceCr {
	
	@Autowired
	private BoardSQLMapperCr boardSQLMapperCr;
	
	@Autowired
	private MemberSQLMapper memberSQLMapper;
	
	public void writeNewBoard(CR_BoardVo boardVo, ArrayList<CR_boardContentImageVo> imageList) {
		
		int board_no = boardSQLMapperCr.getBoardNo();
		System.out.println("get board_no: " + board_no);
		boardVo.setBoard_no(board_no);
		boardSQLMapperCr.insertBoard(boardVo);
		
		for(CR_boardContentImageVo image : imageList) {
			image.setBoard_no(board_no);
			boardSQLMapperCr.insertBoardImage(image);
		}
	}
	
	public int getBoardCount() {
		return boardSQLMapperCr.getBoardCount();
	}
	
	public ArrayList<HashMap<String, Object>> getBoardList(int pageNum, String searchOption, String searchWord) {
		
		
		ArrayList<HashMap<String, Object>> boardData = new ArrayList<HashMap<String,Object>>();
		ArrayList<CR_BoardVo> boardList = boardSQLMapperCr.getBoardList(pageNum, searchOption, searchWord);
		
		for(CR_BoardVo board : boardList) {
			
			HashMap<String, Object> boardInfo = new HashMap<String, Object>();
			
			// 작성자명 가져오기
			int member_no = board.getMember_no();
			MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
			String member_nick = memberVo.getMember_nickname();
			
			// 보드의 이미지 가져오기
			int board_no = board.getBoard_no();
			ArrayList<CR_boardContentImageVo> imageList = boardSQLMapperCr.getBoardImageList(board_no);
			
			int like = boardSQLMapperCr.getLikeCount(board_no);
			boardInfo.put("like", like);
			// 보드 몇 분전 나타내기
			long board_date = board.getBoard_date().getTime();
			long today = System.currentTimeMillis();
			long ago = today-board_date;
			String agoTime = "";
			
			if( ago >= 1000*60*60*24) {
				agoTime = (ago/(1000*60*60*24)) + " day";
			} else if(ago >= 1000*60*60 ) {
				agoTime = (ago/(1000*60*60)) + " hours";
			} else {
				agoTime = (ago/(1000*60)) + " mins";
			}
			
			boardInfo.put("agoTime", agoTime);
			if( imageList.size() != 0) {
				boardInfo.put("fistImage", imageList.get(0));
				boardInfo.put("imageList", imageList);
			}
			boardInfo.put("member_nick", member_nick);
			boardInfo.put("board", board);
			
			boardData.add(boardInfo);
		}
		
		return boardData;
	}
	
	//  board 정보 가져오기
	public HashMap<String, Object> getBoard(int board_no) {
		
		HashMap<String, Object> boardData = new HashMap<String, Object>();
		
		CR_BoardVo boardVo = boardSQLMapperCr.getBoard(board_no);
		
		int member_no = boardVo.getMember_no();
		MemberVo memberVo = memberSQLMapper.getMemberByNo(member_no);
		String member_nick = memberVo.getMember_nickname();
		
		ArrayList<CR_boardContentImageVo> imageList =  boardSQLMapperCr.getBoardImageList(board_no);
		int board_like = boardSQLMapperCr.getLikeCount(board_no);
		
		
		boardData.put("board_like", board_like);
		boardData.put("boardVo", boardVo);
		boardData.put("member_nick", member_nick);
		boardData.put("imageList", imageList);

		
		return boardData;
	}
	// 보드 update
	public void updateBoard(CR_BoardVo boardVo) {
		boardSQLMapperCr.updateBoard(boardVo);
	}
	// 보드 delete
	public void deleteBoard(int board_no) {
		boardSQLMapperCr.deleteBoard(board_no);
	}
	
	public void insertBoardReply(CR_ReplyVo replyVo) {
		boardSQLMapperCr.insertBoardReply(replyVo);
	}
	
	public ArrayList<HashMap<String, Object>> getReplyList(int board_no){
		
		ArrayList<CR_ReplyVo> replyList =  boardSQLMapperCr.getBoardReplyList(board_no);
		
		ArrayList<HashMap<String, Object>> replyDataList =  new ArrayList<HashMap<String,Object>>();
		
		for(CR_ReplyVo reply: replyList) {
			
			HashMap<String, Object> replyData = new HashMap<String, Object>();
			int replyMember = reply.getMember_no();
			MemberVo replyMemberVo = memberSQLMapper.getMemberByNo(replyMember);
			
			replyData.put("reply", reply);
			replyData.put("memberData", replyMemberVo);
			replyDataList.add(replyData);
		}
		return replyDataList;
	}
	
	public void deleteReply(int reply_no) {
		boardSQLMapperCr.deleteReply(reply_no);
	}
	
	public void doLike(CR_boardLikeVO likeVo) {
		int like = boardSQLMapperCr.getLike(likeVo);
		System.out.println("like : " + like);
		if( like > 0) {
			boardSQLMapperCr.deleteLike(likeVo);
		} else {
			boardSQLMapperCr.insertLike(likeVo);
		}
		
	}
	
	public int getboardLike(CR_boardLikeVO likeVo) {
		return boardSQLMapperCr.getLike(likeVo);
	}
	
	public void updateBoardView(int board_no) {
		boardSQLMapperCr.updateBoardView(board_no);
	}
}
