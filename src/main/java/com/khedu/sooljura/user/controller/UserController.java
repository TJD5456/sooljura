package com.khedu.sooljura.user.controller;

import com.khedu.sooljura.user.model.service.UserService;
import com.khedu.sooljura.user.model.vo.AddrListData;
import com.khedu.sooljura.user.model.vo.User;
import com.khedu.sooljura.user.model.vo.UserAddr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

@Controller
@RequestMapping("/user/")
public class UserController {
	@Autowired
	@Qualifier("userService")
	private UserService service;

	// 로그인 페이지로 이동
	@GetMapping("loginFrm.do")
	public String loginFrm() {
		return "user/login";
	}
	
	//아이디 찾기 페이지 이동
	@GetMapping("idFindFrm.do")
	public String idFindFrm(Model model) {
		model.addAttribute("idOrPW", "1");
		return "user/idPwFind";
	}
	//아이디 찾기
	@PostMapping("idFind.do")
	public String idFind(String name, String phone, Model model, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("name : "+name + " | phone : " + phone);
		int isIdNull = service.intIdFind(name, phone); 
		
		if(isIdNull>0) {
			String id = service.idFind(name, phone);
			String idChk = id.substring(0, 2);
			for (int i = 2; i < id.length()-2; i++) {
				idChk +="*";
			}
			idChk +=id.substring(id.length()-2, id.length());
			
			model.addAttribute("res", "3");
			model.addAttribute("idFind", idChk);
			return "user/idPwFind";
		}else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "성함 혹은 전화번호가 일치하지 않습니다.");
			request.setAttribute("icon", "error");
			request.setAttribute("loc", "idFindFrm.do");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return "user/idPwFind";
		}
		
	}
	/*
	보류
	//비밀번호 찾기
	@GetMapping("pwFindFrm.do")
	public String pwFindFrm(Model model) {
		model.addAttribute("idOrPW", "2");
		return "user/idPwFind";
	}
	*/
	// 로그인
	@PostMapping("login.do")
	@ResponseBody
	public void login(User user, HttpSession session, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User login = service.login(user);

		if (login != null) {
			session.setAttribute("loginUser", login);
			session.setMaxInactiveInterval(60 * 60 * 2);

			// 아이디 저장 체크버튼
			Cookie cookie = new Cookie("saveId", user.getUserId());
			if ("chk".equals(request.getParameter("saveId"))) {
				cookie.setMaxAge(60 * 60 * 24 * 30);// 30일
			} else {
				cookie.setMaxAge(0);
			}
			response.addCookie(cookie);

			// 로그인 성공 = 0, 로그인 실패 = 1
			response.getWriter().print("0");
		} else {
			// 로그인 실패
			response.getWriter().print("1");
		}
	}

	// 회원가입 페이지로 이동
	@GetMapping("joinFrm.do")
	public String joinFrm() {
		return "user/join";
	}
	
	// 본인인증
	@PostMapping("idVerif.do")
	@ResponseBody
	public User idVerif(Model model, String impUid, String success, HttpServletRequest request,
			HttpServletResponse response) throws ParseException, ServletException, IOException{
		System.out.println("impUid : " + impUid);// 사용자 impUid == 사용자 정보 조회 요청에 필요
		System.out.println("success : " + success);// 인증 완료 여부

		// 이름/ 생년월일/ 전화번호 추출
		HashMap<String, String> map = service.chkInfo(impUid);

		// 생년월일 포맷이 바뀌진 않겠지만, substring쓰기 찝찝해서, simpleDateFormat으로 변환 후 연도만 추출함.
		String birthDay = map.get("birthDay");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date= sdf.parse(birthDay);

		// Calendar를 사용해 연도 추출
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);

		// 추출된 생년
		int birthYear = calendar.get(Calendar.YEAR);

		// 올해 년도
		int year = Calendar.getInstance().get(Calendar.YEAR);

		// 생년월일 을 통한 나이 계산
		int age = year - birthYear;

		// service에서 호출한 함수로부터 name값 & phone값 추출
		String name = map.get("name");
		String phone = map.get("phone");

		// User객체에 값 전달
		User user = new User();
		user.setAdultChk(1);
		user.setUserNm(name);
		user.setUserPhone(phone);

		if (age < 20) {
			// 만나이 20세 보다 적을때
			System.out.println("오긴하는데...");

			return null;
		}else {

			return user;
		}
	}

	// 회원가입
	@PostMapping("join.do")
	public void join(User user, String addrCd, String addr, String addrDetail, String addrRef,
			HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = service.join(user);

		/*
		 * 주소지 입력란 null이 아닐 시 회원가입을 진행한 후 user.userId 추출해서 DB에 들어간 user.userKey 조회 조회한
		 * userKey로 tbl_user_addr에 입력한 주소지 넣기
		 */

		if (result == 1) {
			// 회원가입 완료 후 주소지 DB에 넣기 1 - userId로 DB에 들어간 userKey 가져오기
			if (addrCd != null) {
				String userKey = service.findUserKey(user.getUserId());

				UserAddr userAddr = new UserAddr();
				userAddr.setUserKey(userKey);
				userAddr.setAddrNm(user.getUserNm());
				userAddr.setAddrCd(addrCd);
				userAddr.setAddr(addr);
				userAddr.setAddrDetail(addrDetail);
				userAddr.setAddrRef(addrRef);
				userAddr.setRcptNm(user.getUserNm());
				userAddr.setRcptPhone(user.getUserPhone());
				userAddr.setDefaultYn(1);

				int insertAddr = service.joinAddr(userAddr);

				// 주소 정상적으로 안들어갔을때
				if (insertAddr < 1) {
					request.setAttribute("title", "알림");
					request.setAttribute("msg", "주소입력 중 오류가 발생했습니다");
					request.setAttribute("icon", "error");
					request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
				}
			}

			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다");
			request.setAttribute("icon", "success");
			request.setAttribute("loc", "loginFrm.do");

			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		} else {
			request.setAttribute("title", "알림");
			request.setAttribute("msg", "회원가입 중 오류가 발생했습니다");
			request.setAttribute("icon", "error");

			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
		}
	}

	// 회원가입 - 아이디 체크
	@GetMapping("chkId.do")
	@ResponseBody
	public String chkId(String userId) {
		int result = service.chkId(userId);
		return String.valueOf(result);
	}

	// 회원가입 - 닉네임 체크
	@GetMapping("chkNickname.do")
	@ResponseBody
	public String chkNickname(String userNickNm) {
		int result = service.chkNickname(userNickNm);
		return String.valueOf(result);
	}

	// 약관동의 페이지로 이동
	@GetMapping("provisionFrm.do")
	public String provisionFrm() {
		return "user/provision";
	}

	// 주소지 관리 페이지로 이동 + 주소지 목록 보여주기
	@GetMapping("addrListFrm.do")
	public String addrListFrm(Model model, HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		String userKey = loginUser.getUserKey();

		AddrListData addrList = service.addrList(userKey);

		if (addrList == null || addrList.getAddrList() == null || addrList.getAddrList().isEmpty()) {
			model.addAttribute("addrList", Collections.emptyList());
		} else {
			model.addAttribute("addrList", addrList.getAddrList());
		}

		return "user/addrList";
	}

	// 주소지 추가 페이지
	@GetMapping("addAddrFrm.do")
	public String addAddrFrm() {
		return "user/addAddr";
	}

	// 주소지 추가
	@PostMapping("addAddr.do")
	@ResponseBody
	public String addAddr(UserAddr userAddr) {
		int result = service.addAddr(userAddr);

		return String.valueOf(result);
	}

	// 주소지 삭제
	@GetMapping("delAddr.do")
	@ResponseBody
	public String delAddr(String addrKey) {
		int result = service.delAddr(addrKey);
		return String.valueOf(result);
	}

	// 주소지 수정 페이지 이동
	@GetMapping("updAddrFrm.do")
	public String updAddrFrm(String addrKey, Model model) {
		UserAddr userAddr = service.userAddr(addrKey);

		model.addAttribute("addrInfo", userAddr);
		return "/user/updAddr";
	}

	// 주소지 수정
	@PostMapping("updAddr.do")
	@ResponseBody
	public String updAddr(UserAddr userAddr) {
		// 주소지 변경
		int result = 0;
		// 기본주소지 변경 체크박스 체크 시 기존에 기본주소지로 세팅되어있는 주소 defaultYn 0으로 변경
		int defaultYnChk = 0;
		/*
		 * jsp에서 기본배송지가 아닌 경우만 defaultYn 체크박스 체크 가능 defaultYn이 체크되어 있으면 1이 반환되고 1이 반환되면
		 * 기존 기본배송지의 defaultYn을 0으로 변경 후 주소지 변경(1 = 기본배송지, 0 = 배송지) defaultYn이 체크되어있지
		 * 않으면 0이니까 그냥 변경만
		 */
		if (userAddr.getDefaultYn() == 1) {
			defaultYnChk = service.setDefaultYn(userAddr);
			result = service.updAddr(userAddr);
		} else {
			result = service.updAddr(userAddr);
		}
		int complete = result + defaultYnChk;
		System.out.println("complete : " + complete);

		return String.valueOf(complete);
	}

	// 로그아웃
	@GetMapping("logout.do")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:/";
	}

	// 결제를 위한 defaultAddr 가져오기
	public UserAddr getDefaultAddr(String userKey) {
		UserAddr userAddr = service.getDefaultAddr(userKey);
		return userAddr;
	}

	@PostMapping("createTestAccount.do")
	public String createTestAccount(int testAccount) {

        User u = new User();
        UserAddr a = new UserAddr();

		switch (testAccount) {
			case 0:
                u.setUserKey("us0000000000");
                u.setUserCd(0);
                u.setUserId("admin999");
                u.setUserPw("admin999@");
                u.setUserEmail("blackeagle10@icloud.com");
                u.setUserNm("관리자");
                u.setUserNickNm("관리자관리자");
                u.setUserPhone("01086455542");
                u.setUserPoint(0);
                u.setAdultChk(1);
                a.setAddrKey("ad0000000000");
                a.setUserKey("us0000000000");
                a.setAddrNm("관리자");
                a.setAddrCd("17097");
                a.setAddr("경기 용인시 기흥구 덕영대로1967번길 38-12");
                a.setAddrDetail("12호");
                a.setAddrRef("하갈동");
                a.setRcptNm("관리자");
                a.setRcptPhone("01086455542");
                a.setDefaultYn(1);
				break;
			case 1:
                u.setUserKey("us0000000001");
                u.setUserCd(1);
                u.setUserId("user111");
                u.setUserPw("user111@");
                u.setUserEmail("blackeagle10@icloud.com");
                u.setUserNm("레벨1");
                u.setUserNickNm("레벨1레벨1");
                u.setUserPhone("01086455542");
                u.setUserPoint(100);
                u.setAdultChk(1);
                a.setAddrKey("ad0000000001");
                a.setUserKey("us0000000001");
                a.setAddrNm("유저1");
                a.setAddrCd("17097");
                a.setAddr("경기 용인시 기흥구 덕영대로1967번길 38-1");
                a.setAddrDetail("1호");
                a.setAddrRef("하갈동");
                a.setRcptNm("레벨1");
                a.setRcptPhone("01086455542");
                a.setDefaultYn(1);
				break;
			case -1:
                u.setUserKey("us0000000005");
                u.setUserCd(-1);
                u.setUserId("user555");
                u.setUserPw("user555@");
                u.setUserEmail("blackeagle10@icloud.com");
                u.setUserNm("레벨5");
                u.setUserNickNm("레벨5레벨5");
                u.setUserPhone("01086455542");
                u.setUserPoint(0);
                u.setAdultChk(0);
                a.setAddrKey("ad0000000005");
                a.setUserKey("us0000000005");
                a.setAddrNm("유저5");
                a.setAddrCd("17097");
                a.setAddr("경기 용인시 기흥구 덕영대로1967번길 38-5");
                a.setAddrDetail("5호");
                a.setAddrRef("하갈동");
                a.setRcptNm("레벨5");
                a.setRcptPhone("01086455542");
                a.setDefaultYn(1);
				break;
		}

    int result = service.insertTestAccount(u);
		if(result == 1){
			result = service.joinAddr(a);
		}

		return "redirect:/";
	}

}
