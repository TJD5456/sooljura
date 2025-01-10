package com.khedu.sooljura.post.controller;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.Comment;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostPageData;
import com.khedu.sooljura.user.model.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/post/")
public class PostController {

	@Autowired
	@Qualifier("postService")
	private PostService service;

	@GetMapping("detailReviewPost.do")
	public String detailReviewPost() {
		return "post/detailReviewPost";
	}

	@GetMapping("freePostWriter.do")
	public String freePostWriter() {
		return "post/freePostWriter"; // JSP: /WEB-INF/views/post/freePostWriter.jsp
	}

	@PostMapping("freeWrite.do")
	public String freeWrite(HttpSession session, Post post, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do";
		}
		post.setUserKey(loginUser.getUserKey());
		post.setUserNm(loginUser.getUserNm());
		post.setPostCd(2); // 자유게시판 코드 설정

		try {
			int result = service.insertFreePost(post);
			if (result > 0) {
				return "redirect:/post/freePostList.do?reqPage=1";
			} else {
				model.addAttribute("errorMessage", "게시글 등록 중 오류가 발생했습니다.");
				return "post/freePostWriter";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "게시글 등록 중 예외가 발생했습니다.");
			return "post/freePostWriter";
		}
	}

	@GetMapping("freePostList.do") // 자유게시판
	public String freePostList(@RequestParam(defaultValue = "1") int reqPage, Model model) {
		return getPostList(reqPage, model, 2, "post/freePost"); // post_cd 2: 자유게시판
	}

	@GetMapping("noticeList.do") // 공지사항
	public String noticeList(@RequestParam(defaultValue = "1") int reqPage, Model model) {
		return getPostList(reqPage, model, 1, "post/noticeListPost"); // post_cd 1: 공지사항
	}

	public String getPostList(int reqPage, Model model, int postCd, String viewName) {
		reqPage = Math.max(reqPage, 1);
		PostPageData pd = service.selectPostList(reqPage, postCd);
		model.addAttribute("list", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());
		return viewName;
	}

	@GetMapping("noticePostWriter.do")
	public String noticePostWriter(HttpSession session, Model model) {
		// 1. 로그인 사용자 정보 확인
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		// 2. 관리자 권한 확인
		if (loginUser.getUserCd() != 0) { // 0: 관리자 권한
			model.addAttribute("errorMessage", "공지사항 작성 권한이 없습니다.");
			return "redirect:/post/noticeList.do"; // 공지사항 목록 페이지로 리다이렉트
		}

		// 3. 공지사항 작성 페이지 반환
		return "post/noticeWriter"; // noticeWriter.jsp를 렌더링
	}

	@PostMapping("noticeWrite.do")
	public String noticeWrite(HttpSession session, Post post, Model model) {
		// 0. 제목 확인
		if (post.getPostTitle() == null || post.getPostTitle().isEmpty()) {
			model.addAttribute("errorMessage", "제목을 입력해주세요.");
			return "post/noticeWriter"; // 공지사항 작성 페이지
		}

		// 1. 로그인 사용자 정보 확인
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		// 2. 관리자 권한 확인
		if (loginUser.getUserCd() != 0) { // 0: 관리자 권한
			model.addAttribute("errorMessage", "공지사항 작성 권한이 없습니다.");
			return "redirect:/post/noticeList.do"; // 공지사항 목록 페이지로 리다이렉트
		}

		// 3. 작성자 정보 설정 및 게시판 코드 설정
		post.setUserKey(loginUser.getUserKey());
		post.setUserNm(loginUser.getUserNm());
		post.setPostCd(1); // 공지사항 코드: 1

		// 4. 게시글 저장
		try {
			int result = service.insertNoticePost(post);
			if (result > 0) {
				return "redirect:/post/noticeList.do?reqPage=1"; // 성공 시 공지사항 목록 페이지로 리다이렉트
			} else {
				model.addAttribute("errorMessage", "공지사항 등록 중 오류가 발생했습니다.");
				return "post/noticeWriter"; // 실패 시 작성 페이지로 복귀
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "공지사항 등록 중 예외가 발생했습니다.");
			return "post/noticeWriter";
		}
	}

	@GetMapping("/freePostDetail.do")
	public String freePostDetail(@RequestParam(value = "postKey", required = true) String postKey, Model model) {
		if (postKey == null || postKey.isEmpty()) {
			model.addAttribute("errorMessage", "게시글 키가 유효하지 않습니다.");
			return "errorPage";
		}

		Post post = service.selectOnePost(postKey);
		List<Comment> comments = service.selectCommentsByPostKey(postKey);
		model.addAttribute("post", post);
		model.addAttribute("comments", comments);
		return "post/freePostDetail";
	}

	@GetMapping("noticeDetail.do")
	public String noticeDetail(@RequestParam("postKey") String postKey, Model model) {
		// 1. postKey 유효성 검사
		if (postKey == null || postKey.isEmpty()) {
			model.addAttribute("errorMessage", "잘못된 게시글 정보입니다.");
			return "errorPage"; // 에러 페이지로 리다이렉트
		}

		// 2. 게시글 조회 (내부에서 조회수 증가 처리)
		Post post = service.selectOnePost(postKey);

		// 3. 모델에 게시글 정보 추가
		model.addAttribute("post", post);

		return "post/noticeDetail"; // noticeDetail.jsp 페이지로 이동
	}

	// 댓글작성 or 댓글이 없는 경우 에러메세지를 추가
	@PostMapping("/addComment.do")
	public String addComment(HttpSession session, Comment comment, RedirectAttributes redirectAttributes) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다. 로그인 후 댓글을 작성해주세요.");
			return "redirect:/user/login.do";
		}

		comment.setUserKey(loginUser.getUserKey());
		comment.setUserNickNm(loginUser.getUserNickNm());

		try {
			int result = service.insertComment(comment);
			if (result > 0) {
				return "redirect:/post/freePostDetail.do?postKey=" + comment.getPostKey();
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록에 실패했습니다.");
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록 중 오류가 발생했습니다.");
		}

		return "redirect:/post/freePostDetail.do?postKey=" + comment.getPostKey();
	}

	@PostMapping("deleteComment.do")
	public String deleteComment(String commentKey, HttpSession session, RedirectAttributes redirectAttributes) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/loginfrm.do";
		}

		try {
			// 댓글 소속 게시글의 postKey 가져오기
			String postKey = service.getPostKeyByCommentKey(commentKey);

			int result = service.deleteComment(commentKey, loginUser.getUserKey());
			if (result > 0) {
				redirectAttributes.addFlashAttribute("successMessage", "댓글이 삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 권한이 없습니다.");
			}

			return "redirect:/post/freePostDetail.do?postKey=" + postKey;
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 중 오류가 발생했습니다.");
			return "redirect:/post/freePostDetail.do";
		}
	}

	@PostMapping("/deletePost.do")
	public String deletePost(@RequestParam("postKey") String postKey, HttpSession session,
			RedirectAttributes redirectAttributes) {
		User loginUser = (User) session.getAttribute("loginUser");

		// 1. 로그인 여부 확인
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		try {
			// 2. 게시글 작성자 확인 및 삭제 처리
			int result = service.deletePost(postKey, loginUser.getUserKey());

			if (result > 0) {
				redirectAttributes.addFlashAttribute("successMessage", "게시글이 삭제되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제 권한이 없습니다.");
			}

			return "redirect:/post/noticeList.do";
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제 중 오류가 발생했습니다.");
			return "redirect:/post/noticeList.do?postKey=" + postKey;
		}
	}

	@GetMapping("freePostEdit.do")
	public String freePostEdit(@RequestParam("postKey") String postKey, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		Post post = service.selectOnePost(postKey);
		if (!post.getUserKey().equals(loginUser.getUserKey())) {
			model.addAttribute("errorMessage", "게시글 수정 권한이 없습니다.");
			return "redirect:/post/freePostDetail.do?postKey=" + postKey; // 게시글 상세보기로 이동
		}

		model.addAttribute("post", post); // 기존 게시글 데이터를 모델에 추가
		return "post/freePostEdit"; // 수정 페이지
	}

	// 게시글 수정 처리
	@PostMapping("freePostUpdate.do")
	public String freePostUpdate(HttpSession session, Post post, RedirectAttributes redirectAttributes) {
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do";
		}

		try {
			post.setUserKey(loginUser.getUserKey());
			int result = service.updatePost(post);

			if (result > 0) {
				redirectAttributes.addFlashAttribute("successMessage", "게시글이 성공적으로 수정되었습니다.");
				return "redirect:/post/freePostDetail.do?postKey=" + post.getPostKey();
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "게시글 수정 중 오류가 발생했습니다.");
				return "redirect:/post/freePostEdit.do?postKey=" + post.getPostKey();
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "게시글 수정 중 예외가 발생했습니다.");
			return "redirect:/post/freePostEdit.do?postKey=" + post.getPostKey();
		}
	}

	// 공지사항 수정 페이지 이동
	@GetMapping("noticePostEdit.do")
	public String noticePostEdit(@RequestParam("postKey") String postKey, HttpSession session, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");

		// 1. 로그인 확인
		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		// 2. 관리자 권한 확인
		if (loginUser.getUserCd() != 0) { // 0: 관리자 권한
			model.addAttribute("errorMessage", "공지사항 수정 권한이 없습니다.");
			return "redirect:/post/noticeDetail.do?postKey=" + postKey; // 상세보기 페이지로 이동
		}

		// 3. 공지사항 데이터 조회 및 모델 설정
		Post post = service.selectOnePost(postKey);
		model.addAttribute("post", post); // 기존 게시글 데이터를 모델에 추가

		return "post/noticePostEdit"; // 수정 페이지 렌더링
	}

	// 공지사항 수정 처리
	@PostMapping("noticePostUpdate.do")
	public String noticePostUpdate(HttpSession session, Post post, RedirectAttributes redirectAttributes) {
		User loginUser = (User) session.getAttribute("loginUser");

		// 1. 로그인 확인
		if (loginUser == null) {
			redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
		}

		// 2. 관리자 권한 확인
		if (loginUser.getUserCd() != 0) { // 0: 관리자 권한
			redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 권한이 없습니다.");
			return "redirect:/post/noticeDetail.do?postKey=" + post.getPostKey(); // 상세보기 페이지로 리다이렉트
		}

		try {
			// 3. 작성자 정보 설정
			post.setUserKey(loginUser.getUserKey());

			// 4. 게시글 수정 처리
			int result = service.updatePost(post);
			if (result > 0) {
				redirectAttributes.addFlashAttribute("successMessage", "공지사항이 성공적으로 수정되었습니다.");
				return "redirect:/post/noticeDetail.do?postKey=" + post.getPostKey(); // 성공 시 상세보기 페이지로 이동
			} else {
				redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 중 오류가 발생했습니다.");
				return "redirect:/post/noticePostEdit.do?postKey=" + post.getPostKey(); // 실패 시 수정 페이지로 복귀
			}
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 중 예외가 발생했습니다.");
			return "redirect:/post/noticePostEdit.do?postKey=" + post.getPostKey();
		}
	}

	@GetMapping("reviewListPost.do")
	public String reviewListPost(@RequestParam(defaultValue = "1") int reqPage, Model model) {
		return getPostList(reqPage, model, 3, "post/reviewListPost"); // 3: 제품 후기 게시판 코드
	}

	@GetMapping("reviewPostDetail.do") // 메서드 이름도 JSP와 맞춰줌
	public String reviewPostDetail(@RequestParam("postKey") String postKey, Model model) {
		Post post = service.selectOnePost(postKey);
		List<Comment> comments = service.selectCommentsByPostKey(postKey);
		model.addAttribute("post", post);
		model.addAttribute("comments", comments);
		return "post/reviewPostDetail"; // JSP 이름과 컨트롤러 반환 이름 일치
	}

	// 작성 페이지 이동 (GET 요청)
	@GetMapping("reviewPostWriter.do")
	public String reviewPostWriter() {
		return "post/reviewPostWriter"; // JSP 경로
	}

	// 작성 처리 (POST 요청)
	@PostMapping("reviewPostWrite.do")
	public String reviewPostWrite(HttpSession session, Post post, Model model) {
		User loginUser = (User) session.getAttribute("loginUser");
		if (loginUser == null) {
			model.addAttribute("errorMessage", "로그인이 필요합니다.");
			return "redirect:/user/login.do";
		}

		post.setUserKey(loginUser.getUserKey());
		post.setUserNm(loginUser.getUserNm());
		post.setPostCd(3); // 후기 게시판 코드

		try {
			int result = service.insertReviewPost(post); // 후기 게시판 전용 insert 호출
			if (result > 0) {
				return "redirect:/post/reviewListPost.do?reqPage=1"; // 후기 목록으로 리다이렉트
			} else {
				model.addAttribute("errorMessage", "후기 작성 중 오류가 발생했습니다.");
				return "post/reviewPostWriter";
			}
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("errorMessage", "후기 작성 중 예외가 발생했습니다.");
			return "post/reviewPostWriter";
		}
	}

	@GetMapping("getUserPosts.do")
	@ResponseBody
	public Map<String, List<Post>> getUserPosts(HttpSession session) {
		User loginUser = (User) session.getAttribute("loginUser");
		Map<String, List<Post>> resultMap = new HashMap<>();

		if (loginUser == null) {
			resultMap.put("error", null);
			return resultMap;
		}

		String userKey = loginUser.getUserKey();
		List<Post> freePosts = service.getMyPostsByCategory(userKey, 2); // 자유게시판
		List<Post> noticePosts = service.getMyPostsByCategory(userKey, 1); // 공지사항
		List<Post> reviewPosts = service.getMyPostsByCategory(userKey, 3); // 후기 게시판

		resultMap.put("freePosts", freePosts);
		resultMap.put("noticePosts", noticePosts);
		resultMap.put("reviewPosts", reviewPosts);

		return resultMap; // JSON 형식으로 반환
	}

	@GetMapping("adminDeletePost.do")
	public String adminDeletePost(String postKey) {
		if (service.adminDeletePost(postKey) > 0) {
			return "redirect:/admin/managePosts.do";
		} else {
			return "redirect:/post/freePostDetail.do?postKey=" + postKey;
		}
	}

	@GetMapping("confirmYn.do")
	@ResponseBody
	public String confirmYn(String postKey) {
		if (service.confirmYn(postKey) > 0) {
			return "confirm check";
		} else {
			return "foobar";
		}
	}

	@PostMapping("readMyPost.do")
	public String readMyPostPage(String userKey, Model model) {
		PostPageData pd1 = service.selectPostList(1, 2, userKey);
	    PostPageData pd2 = service.selectPostList(1, 2, userKey);
	    PostPageData pd3 = service.selectPostList(1, 3, userKey);

	    model.addAttribute("noticeList", pd1.getList());
		model.addAttribute("noticePageNavi", pd1.getPageNavi());

	    model.addAttribute("freePostList", pd2.getList());
		model.addAttribute("freePageNavi", pd2.getPageNavi());

		model.addAttribute("reviewPostList", pd3.getList());
		model.addAttribute("reviewPageNavi", pd3.getPageNavi());
		return "userMyPage/readMyPost";
	    }

}
