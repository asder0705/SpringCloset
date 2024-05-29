package com.love.my.closet.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.love.my.closet.vo.ClosetVO;
import com.love.my.member.vo.MemberVO;

@Mapper
public interface IClosetDAO {
	

	//게시글 조회
	public List<ClosetVO> getClosetList(MemberVO vo);
	//셀렉트 박스 첫번째
	public List<ClosetVO> onechoice();
	//셀렉트 박스 두번째
	public List<ClosetVO> twochoice(ClosetVO vo);
	//색
	public List<ClosetVO> threechoice();
	//최종 선택 결과값
	public List<ClosetVO> getlist(ClosetVO vo);
	//옷 추가하기
	public int closetplus(ClosetVO vo);	
	//옷 삭제하기
	public int deleteCloset(ClosetVO vo);	
	//상품
	public int prodInsert(ClosetVO vo);
	//디테일
	public int prodDetail(ClosetVO vo);
	//옷 찾은거 추가하기
	public int closetfind(ClosetVO vo);	
	
	
}
