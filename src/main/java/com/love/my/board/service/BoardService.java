package com.love.my.board.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.love.my.board.dao.IBoardDAO;
import com.love.my.board.vo.BoardVO;
import com.love.my.board.vo.ReplyVO;

@Service
public class BoardService {

	@Autowired
	IBoardDAO dao;

	// 게시글조회
	public List<BoardVO> getBoardList() {
		return dao.getBoardList();
	}

	// 게시글 등록
	public void writeBoard(BoardVO vo) throws Exception {
		int result = dao.writeBoard(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	public BoardVO getBoard(int boardNo) throws Exception {
		BoardVO result = dao.getBoard(boardNo);
		if (result == null) {
			throw new Exception();
		}
		return result;
	}

	// 게시글 수정
	public void updateBoard(BoardVO vo) throws Exception {
		int result = dao.updateBoard(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
	//게시글 삭제
	public void deleteBoard(int boardNo) throws Exception {
		int result = dao.deleteBoard(boardNo);
		if (result == 0) {
			throw new Exception();
		}
	}
	//댓글 등록
		 public void writeReply(ReplyVO vo) throws Exception {
			 int result = dao.writeReply(vo);
			 if(result ==0) {
				 throw new Exception();
			 }
}
		 //댓글 조회
		 public ReplyVO getReply(String replyNo) throws Exception {
			 ReplyVO result = dao.getReply(replyNo);
			 if(result == null)throw new Exception();
			 return result;
		 }
		 
		 //댓글리스트 조회
		 public List<ReplyVO>getReplyList(int boardNo){
			 List<ReplyVO> result=dao.getReplyList(boardNo);
			 return result;
		 }
}
