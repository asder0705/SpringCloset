package com.love.my.closet.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.love.my.closet.service.ClosetService;
import com.love.my.closet.vo.ClosetVO;
import com.love.my.member.vo.MemberVO;

@RestController // rest api 전용 컨트롤러(객체가 자동으로 json 형태로 리턴)
public class CodeController {
	@Autowired
	private ClosetService closetService;
	
	
	@GetMapping("/onechoice")
	public List<ClosetVO> onechoice() {
		List<ClosetVO> comList = closetService.onechoice();
		return comList;
	}

	@GetMapping("/twochoice")
	public List<ClosetVO> twochoice(@RequestParam String pgroupName) {
		ClosetVO vo = new ClosetVO();
		vo.setPgroupName(pgroupName);
		List<ClosetVO> codList = closetService.twochoice(vo);
		return codList;
	}
	
	@PostMapping("/getlist")
	public List<ClosetVO> getlist(ClosetVO vo) {
		List<ClosetVO> getList = closetService.getlist(vo);
		return getList;
	
	}
	@RequestMapping("/plusDo")
	public ResponseEntity<?> plusDo(ClosetVO vo,HttpSession session) throws Exception {
	
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		closetService.closetplus(vo);
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("message","success");
		return new ResponseEntity<Map<String, Object>>(map,HttpStatus.OK);
	}
}


