package com.ja.bseven.board.mapper;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.ja.bseven.vo.cr.CR_BoardVo;
import com.ja.bseven.vo.cr.CR_ReplyVo;
import com.ja.bseven.vo.cr.CR_boardContentImageVo;
import com.ja.bseven.vo.cr.CR_boardLikeVO;

public interface BoardSQLMapperCr {
	
	public int getBoardNo();
	public void insertBoard(CR_BoardVo boardVo);
	public void insertBoardImage(CR_boardContentImageVo image);
	
	public ArrayList<CR_BoardVo> getBoardList(
			@Param("pageNum") int pageNum,
			@Param("searchOption") String searchOption,
			@Param("searchWord") String searchWord);
	public ArrayList<CR_boardContentImageVo> getBoardImageList(int board_no);
	public int getBoardCount();
	public void updateBoardView(int board_no);
	
	public CR_BoardVo getBoard(int board_no);
	
	public void updateBoard(CR_BoardVo boardVo);
	public void deleteBoard(int board_no);
	
	public void insertBoardReply(CR_ReplyVo replyVo);
	public ArrayList<CR_ReplyVo> getBoardReplyList(int board_no);
	public void deleteReply(int reply_no);
	
	public void insertLike(CR_boardLikeVO likeVo);
	public void deleteLike(CR_boardLikeVO likeVo);
	public int getLike(CR_boardLikeVO likeVo);
	public int getLikeCount(int board_no);
}
