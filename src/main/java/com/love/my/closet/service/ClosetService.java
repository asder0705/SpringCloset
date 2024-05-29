package com.love.my.closet.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.love.my.closet.dao.IClosetDAO;
import com.love.my.closet.vo.ClosetVO;
import com.love.my.member.vo.MemberVO;

@Service
public class ClosetService {

	@Autowired
	IClosetDAO dao;

	// 옷장 조회
	public List<ClosetVO> getClosetList(MemberVO vo) {
		return dao.getClosetList(vo);
	}

	// 셀렉트 박스 첫번째
	public List<ClosetVO> onechoice() {
		return dao.onechoice();
	}

	// 셀렉트 박스 두번째
	public List<ClosetVO> twochoice(ClosetVO vo) {
		return dao.twochoice(vo);
	}

	// 색
	public List<ClosetVO> threechoice() {
		return dao.threechoice();
	}

	// 최종 선택 결과값
	public List<ClosetVO> getlist(ClosetVO vo) {
		return dao.getlist(vo);
	}

	// 옷 추가하기
	public void closetplus(ClosetVO vo) throws Exception {
		int result = dao.closetplus(vo);
		if (result == 0) {
			throw new Exception();
		}
	}


	// 옷 삭제하기
	public void deleteCloset(ClosetVO vo) throws Exception {
		int result = dao.deleteCloset(vo);
		if (result == 0) {
			throw new Exception();
		}
	}
	// 옷 찾은거 추가하기
	public void closetfind(ClosetVO vo) throws Exception {
		if(vo.getImgPath() != null) {
			String result = fileDown(vo.getImgPath());
			vo.setImgPath(result);
		}
		// 상품등록
		dao.prodInsert(vo);
		System.out.println(vo);
		// 상품 디테일 등록
		dao.prodDetail(vo);
		// 내 옷장등록
		int result = dao.closetplus(vo);
		if (result == 0) {
			throw new Exception();
		}
	}

	private static String CURR_IMATE_PATH = "c:\\tools\\spring_dev\\img";

	public String fileDown(String imageUrl) {
		try {
			// 외부 이미지 다운로드
			URL url = new URL(imageUrl);
			URLConnection connection = url.openConnection();
			BufferedInputStream in = new BufferedInputStream(connection.getInputStream());
			String fileName = UUID.randomUUID().toString() + ".jpg"; // 확장자가 jpg인 경우
			String path = CURR_IMATE_PATH;
			FileOutputStream out = new FileOutputStream(path + "\\" + fileName);
			// 파일 저장
			byte[] buffer = new byte[1024];
			int bytesRead;
			while ((bytesRead = in.read(buffer, 0, buffer.length)) != -1) {
				out.write(buffer, 0, bytesRead);
			}
			out.close();
			in.close();
			return fileName;
		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}

	}
}
