package com.love.my.member.web;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.love.my.closet.service.ClosetService;
import com.love.my.closet.vo.ClosetVO;
import com.love.my.member.service.MemberService;
import com.love.my.member.vo.MemberVO;

@Controller
public class MemberController {

	@Autowired
	MemberService memberService;
	
	@Autowired
	ClosetService closetService;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	
	@ModelAttribute("cgroup")
	public List<ClosetVO> cgroupList(){
		return closetService.threechoice();
	}
	
	@RequestMapping("/registView")
	public String registView() {
		return "member/registView";
	}
	@RequestMapping("/loginView")
	public String loginView() {
		return "member/loginView";
	}
	@RequestMapping("/closetView")
	public String closetView(Model model, ClosetVO vo,HttpSession session){		
		
		MemberVO memvo = (MemberVO) session.getAttribute("login");
		List<ClosetVO> ClosetList = closetService.getClosetList(memvo);	
		model.addAttribute("closetList",ClosetList);
		
		return "closet/closetView";
	}

	@RequestMapping("/closetupView")
	public String closetupView(Model model) {
		List<ClosetVO> comList = closetService.onechoice();
		model.addAttribute("comList", comList);
		return "closet/closetupView";
	}
	@RequestMapping("/closetfindView")
	public String closetfindView(Model model) {
		List<ClosetVO> comList = closetService.onechoice();
		model.addAttribute("comList", comList);
		return "closet/closetfindView";
	}
	
	
	
	@RequestMapping("/registDo")
	public String registDo(HttpServletRequest request
			,MemberVO member, RedirectAttributes re) {
		member.setMemPw(passwordEncoder.encode(request.getParameter("memPw")));
		System.out.println(member);
		try {
			memberService.registMember(member);
		} catch (Exception e) {
			e.printStackTrace();
			return "errorView";
		}
		//RedirectAttributes 리다이렉트시 전송하고싶은 데이터를 포함시켜서 디라이렉트 요청을 할 수 있음.
		re.addFlashAttribute("msg", "회원가입이 정상적으로 처리되었습니다.");
		return "redirect:/";
	}
	
	@RequestMapping("/loginDo")
	public String loginDo(MemberVO vo,HttpSession session
			,boolean remember,RedirectAttributes re
			,HttpServletResponse resp) {
	MemberVO login = memberService.loginMember(vo);
		if(login == null) {
			re.addFlashAttribute("msg", "아이디/비번을 확인해주세여");
			return "redirect:/loginView";
		}
		//첫번쨰 매개변수 (사용자 입력 아직 암호화가 안된)두번째 매개변수(암호화가 된 비밀번호)
		boolean match = passwordEncoder.matches(vo.getMemPw(),login.getMemPw());
		if(!match) {
			re.addFlashAttribute("msg","비번확인");
			return "redirect:/loginView";
		
		
		}
		session.setAttribute("login",login);
		System.out.println(login);
		
		return "redirect:/closetView" ;
}
	@RequestMapping("/logoutDo")
	public String logoutDo (HttpSession session, RedirectAttributes re) {
		//세션종료
		session.invalidate();
		re.addFlashAttribute("msg","로그아웃됨");
		return "redirect:/";
	}
	@RequestMapping("/mypageView")
	public String mypageView(HttpSession session, Model model) {
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "member/mypageView";
	}
	
	@RequestMapping(value="/closetDel",method=RequestMethod.POST)
	public String closetDel(ClosetVO vo) throws Exception {
		System.out.println(vo);
		closetService.deleteCloset(vo);		
		
		System.out.println("???");
		return "redirect:/closetView";
	}
	@RequestMapping("/updateDo")
	public String updateDo (MemberVO vo,HttpSession session, Model model) {
		try {
			memberService.updateMember(vo);
			session.setAttribute("login", vo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("msg","수정되었습니다!");
		return "member/mypageView";
	}
	@RequestMapping("/codyView")
	public String codyView(HttpSession session, Model model,ClosetVO vo) {
		
		// 화면 가기전에 나의 옷 정보 가지고 오기 
		// 화면에 전달 		
		MemberVO memvo = (MemberVO) session.getAttribute("login");
		List<ClosetVO> ClosetList = closetService.getClosetList(memvo);	
		model.addAttribute("closetList",ClosetList);
		
		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		return "closet/codyView";
	}

	@RequestMapping("/plusFind")
	public String plusFind(ClosetVO vo,HttpSession session) throws Exception {

		if(session.getAttribute("login") == null) {
			return "redirect:/loginView";
		}
		System.out.println(vo);	
		MemberVO login = (MemberVO) session.getAttribute("login");
		vo.setMemId(login.getMemId());
		closetService.closetfind(vo);
		Map<String,Object>map = new HashMap<String, Object>();
		map.put("message","success");
		
		
		return "redirect:/closetView";
	}

}


