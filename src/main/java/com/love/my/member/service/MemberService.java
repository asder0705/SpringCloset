package com.love.my.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.love.my.member.dao.IMemberDAO;
import com.love.my.member.vo.MemberVO;

@Service
public class MemberService {

	@Autowired
	IMemberDAO dao;

	// 회원가입
	public void registMember(MemberVO vo) throws Exception {
		int result = dao.registMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	// 회원조회
	public MemberVO loginMember(MemberVO vo) {
		return dao.loginMember(vo);
	}

	// 수정하기
	public void updateMember(MemberVO vo) throws Exception {
		int result = dao.updateMember(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
}
