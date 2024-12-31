package com.khedu.sooljura.post.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.Comment;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostPageData;
import com.khedu.sooljura.user.model.vo.User;

@Controller
@RequestMapping("/post/")
public class PostController {

	@Autowired
	@Qualifier("postService")
	private PostService service;

	@GetMapping("notePost.do")
	public String notePost() {
		return "post/notePost";
	}

	@GetMapping("detailReviewPost.do")

	public String detailReviewPost() {
		return "post/detailReviewPost";
	}

	@GetMapping("reviewListPost.do")

	public String reviewListPost() {
		return "post/reviewListPost";
	}

	@GetMapping("freePostWriter.do")

	public String freePostWirter() {
		return "post/freePostWriter";
	}

	@GetMapping("webPageInfo.do")

	public String webPageInfo() {
		return "post/webPageInfo";
	}

	@GetMapping("getList.do")
	public String getList(int reqPage, Model model) {
	    PostPageData pd = service.selectPostList(reqPage);
	    model.addAttribute("list", pd.getList());
	    model.addAttribute("pageNavi", pd.getPageNavi());
	    return "post/freePost";
	}

	@PostMapping("freewrite.do")
	public String freewrite(HttpSession session, Post post, Model model) {
	   
		// 0.제목 확인
	    if (post.getPostTitle() == null || post.getPostTitle().isEmpty()) {
	        model.addAttribute("errorMessage", "제목을 입력해주세요.");
	        return "post/freePostWriter";
	    }
		
		// 1. 로그인 사용자 정보 확인
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        model.addAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
	    }

	    // 2. 작성자 정보 설정
	    post.setUserKey(loginUser.getUserKey());
	    post.setUserNm(loginUser.getUserNm());

	    // 3. 게시글 저장
	    try {
	        int result = service.insertfreePost(post);
	        if (result > 0) {
	            return "redirect:/post/getList.do?reqPage=1"; // 성공 시 목록 페이지로 리다이렉트
	        } else {
	            model.addAttribute("errorMessage", "게시글 등록 중 오류가 발생했습니다.");
	            return "post/freePostWriter"; // 실패 시 작성 페이지로 복귀
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        model.addAttribute("errorMessage", "게시글 등록 중 예외가 발생했습니다.");
	        return "post/freePostWriter"; // 예외 발생 시 작성 페이지로 복귀
	    }
	}
	
	@GetMapping("freePostDetail.do")
	public String freePostDetail(String postKey, Model model) {
	    if (postKey == null || postKey.isEmpty()) {
	        model.addAttribute("errorMessage", "postKey가 누락되었습니다.");
	        return "errorPage";
	    }

	    Post post = service.selectOnePost(postKey);
	    if (post == null) {
	        model.addAttribute("errorMessage", "해당 게시글을 찾을 수 없습니다.");
	        return "errorPage";
	    }

	    // 댓글 목록 조회
	    List<Comment> comments = service.selectCommentsByPostKey(postKey);
	    model.addAttribute("post", post);
	    model.addAttribute("comments", comments);

	    return "post/freePostDetail";
	}
	
	   // 댓글 작성
	@PostMapping("/addComment.do")
	public String addComment(HttpSession session, Comment comment, RedirectAttributes redirectAttributes) {
	    // 1. 로그인 여부 확인
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다. 로그인 후 댓글을 작성해주세요.");
	        return "redirect:/user/login.do"; // 로그인 페이지로 리다이렉트
	    }

	    // 2. 로그인 사용자 정보 설정
	    comment.setUserKey(loginUser.getUserKey());
	    comment.setUserNickNm(loginUser.getUserNickNm());

	    // 3. 댓글 저장
	    try {
	        int result = service.insertComment(comment);
	        if (result > 0) {
	            return "redirect:/post/freePostDetail.do?postKey=" + comment.getPostKey();
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록에 실패했습니다.");
	            return "redirect:/post/freePostDetail.do?postKey=" + comment.getPostKey();
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "댓글 등록 중 오류가 발생했습니다.");
	        return "redirect:/post/freePostDetail.do?postKey=" + comment.getPostKey();
	    }
	}
	
	
	@PostMapping("deleteComment.do")
	public String deleteComment(String commentKey, HttpSession session, RedirectAttributes redirectAttributes) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do";
	    }

	    try {
	        int result = service.deleteComment(commentKey, loginUser.getUserKey());
	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("successMessage", "댓글이 삭제되었습니다.");
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 권한이 없습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 중 오류가 발생했습니다.");
	    }

	    return "redirect:/post/freePostDetail.do?postKey=" + commentKey;
	}

	@PostMapping("updateComment.do")
	public String updateComment(String commentKey, String commentContent, HttpSession session, RedirectAttributes redirectAttributes) {
	    User loginUser = (User) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do";
	    }

	    try {
	        int result = service.updateComment(commentKey, loginUser.getUserKey(), commentContent);
	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("successMessage", "댓글이 수정되었습니다.");
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "댓글 수정 권한이 없습니다.");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "댓글 수정 중 오류가 발생했습니다.");
	    }

	    return "redirect:/post/freePostDetail.do?postKey=" + commentKey;
	}
}
