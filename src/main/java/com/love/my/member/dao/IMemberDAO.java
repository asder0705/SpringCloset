package com.love.my.member.dao;

import org.apache.ibatis.annotations.Mapper;

import com.love.my.member.vo.MemberVO;

@Mapper
public interface IMemberDAO {

		//회원가입
		public int registMember(MemberVO vo);
		//회원조회
		public MemberVO loginMember(MemberVO vo);
		//수정하기
		public int updateMember(MemberVO vo);
}
