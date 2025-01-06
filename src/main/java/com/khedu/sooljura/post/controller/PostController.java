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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

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

	@GetMapping("reviewListPost.do")
	public String reviewListPost() {
		return "post/reviewListPost";
	}
	
	@GetMapping("freePostWriter.do")
	public String freePostWriter() {
	    return "post/freePostWriter";  // JSP: /WEB-INF/views/post/freePostWriter.jsp
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
	    post.setPostCd(2);  // 자유게시판 코드 설정

	    try {
	        int result = service.insertfreePost(post);
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

	@GetMapping("webPageInfo.do")
	public String webPageInfo() {
		return "post/webPageInfo";
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

	  @GetMapping("noticeList.do") // 공지사항
	    public String noticeList(@RequestParam(defaultValue = "1") int reqPage, Model model) {
	        return getPostList(reqPage, model, 1, "post/noticeListPost"); // post_cd 1: 공지사항
	    }
	  private String getPostList(int reqPage, Model model, int postCd, String viewName) {
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
	          return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	      }

	      // 2. 관리자 권한 확인
	      if (loginUser.getUserCd() != 0) {  // 0: 관리자 권한
	          model.addAttribute("errorMessage", "공지사항 작성 권한이 없습니다.");
	          return "redirect:/post/noticeList.do";  // 공지사항 목록 페이지로 리다이렉트
	      }

	      // 3. 공지사항 작성 페이지 반환
	      return "post/noticeWriter";  // noticeWriter.jsp를 렌더링
	  }

	  @PostMapping("noticeWrite.do")
	  public String noticeWrite(HttpSession session, Post post, Model model) {
	      // 0. 제목 확인
	      if (post.getPostTitle() == null || post.getPostTitle().isEmpty()) {
	          model.addAttribute("errorMessage", "제목을 입력해주세요.");
	          return "post/noticeWriter";  // 공지사항 작성 페이지
	      }

	      // 1. 로그인 사용자 정보 확인
	      User loginUser = (User) session.getAttribute("loginUser");
	      if (loginUser == null) {
	          model.addAttribute("errorMessage", "로그인이 필요합니다.");
	          return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	      }

	      // 2. 관리자 권한 확인
	      if (loginUser.getUserCd() != 0) {  // 0: 관리자 권한
	          model.addAttribute("errorMessage", "공지사항 작성 권한이 없습니다.");
	          return "redirect:/post/noticeList.do";  // 공지사항 목록 페이지로 리다이렉트
	      }

	      // 3. 작성자 정보 설정 및 게시판 코드 설정
	      post.setUserKey(loginUser.getUserKey());
	      post.setUserNm(loginUser.getUserNm());
	      post.setPostCd(1);  // 공지사항 코드: 1

	      // 4. 게시글 저장
	      try {
	          int result = service.insertNoticePost(post);
	          if (result > 0) {
	              return "redirect:/post/noticeList.do?reqPage=1";  // 성공 시 공지사항 목록 페이지로 리다이렉트
	          } else {
	              model.addAttribute("errorMessage", "공지사항 등록 중 오류가 발생했습니다.");
	              return "post/noticeWriter";  // 실패 시 작성 페이지로 복귀
	          }
	      } catch (Exception e) {
	          e.printStackTrace();
	          model.addAttribute("errorMessage", "공지사항 등록 중 예외가 발생했습니다.");
	          return "post/noticeWriter";
	      }
	  }

	@RequestMapping("/freePostDetail.do")
	public String freePostDetail(@RequestParam(value = "postKey", required = true) String postKey, Model model) {
		if (postKey == null || postKey.isEmpty()) {
			model.addAttribute("errorMessage", "게시글 키가 유효하지 않습니다.");
			return "errorPage"; // 에러 페이지로 이동
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
	        return "errorPage";  // 에러 페이지로 리다이렉트
	    }

	    // 2. 게시글 조회 (내부에서 조회수 증가 처리)
	    Post post = service.selectOnePost(postKey);

	    // 3. 모델에 게시글 정보 추가
	    model.addAttribute("post", post);

	    return "post/noticeDetail";  // noticeDetail.jsp 페이지로 이동
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

	@PostMapping("/editComment.do")
	public String editComment(@RequestParam("commentKey") String commentKey,
			@RequestParam("commentContent") String commentContent, RedirectAttributes redirectAttributes) {
		Comment comment = new Comment();
		comment.setCommentKey(commentKey);
		comment.setCommentContent(commentContent);

		try {
			int result = service.updateComment(comment);
			if (result > 0) {
				redirectAttributes.addFlashAttribute("msg", "댓글이 수정되었습니다.");
			} else {
				redirectAttributes.addFlashAttribute("msg", "댓글 수정에 실패했습니다.");
			}

			// 댓글이 속한 게시글의 postKey를 가져와 리다이렉트
			String postKey = service.getPostKeyByCommentKey(commentKey);
			return "redirect:/post/freePostDetail.do?postKey=" + postKey;
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("msg", "댓글 수정 중 오류가 발생했습니다.");
			return "redirect:/post/freePostDetail.do";
		}
	}
	
	@PostMapping("/deletePost.do")
	public String deletePost(@RequestParam("postKey") String postKey, HttpSession session, RedirectAttributes redirectAttributes) {
	    User loginUser = (User) session.getAttribute("loginUser");

	    // 1. 로그인 여부 확인
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	    }

	    try {
	        // 2. 게시글 작성자 확인 및 삭제 처리
	        int result = service.deletePost(postKey, loginUser.getUserKey());

	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("successMessage", "게시글이 삭제되었습니다.");
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제 권한이 없습니다.");
	        }

	        return "redirect:/post/freePostList.do";  // 성공 시 자유게시판 목록으로 리다이렉트
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "게시글 삭제 중 오류가 발생했습니다.");
	        return "redirect:/post/freePostDetail.do?postKey=" + postKey;
	    }
	}
	
	@GetMapping("freePostEdit.do")
	public String freePostEdit(@RequestParam("postKey") String postKey, HttpSession session, Model model) {
	    User loginUser = (User) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        model.addAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	    }

	    Post post = service.selectOnePost(postKey);
	    if (!post.getUserKey().equals(loginUser.getUserKey())) {
	        model.addAttribute("errorMessage", "게시글 수정 권한이 없습니다.");
	        return "redirect:/post/freePostDetail.do?postKey=" + postKey;  // 게시글 상세보기로 이동
	    }

	    model.addAttribute("post", post);  // 기존 게시글 데이터를 모델에 추가
	    return "post/freePostEdit";  // 수정 페이지
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
	        return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	    }

	    // 2. 관리자 권한 확인
	    if (loginUser.getUserCd() != 0) {  // 0: 관리자 권한
	        model.addAttribute("errorMessage", "공지사항 수정 권한이 없습니다.");
	        return "redirect:/post/noticeDetail.do?postKey=" + postKey;  // 상세보기 페이지로 이동
	    }

	    // 3. 공지사항 데이터 조회 및 모델 설정
	    Post post = service.selectOnePost(postKey);
	    model.addAttribute("post", post);  // 기존 게시글 데이터를 모델에 추가

	    return "post/noticePostEdit";  // 수정 페이지 렌더링
	}

	// 공지사항 수정 처리
	@PostMapping("noticePostUpdate.do")
	public String noticePostUpdate(HttpSession session, Post post, RedirectAttributes redirectAttributes) {
	    User loginUser = (User) session.getAttribute("loginUser");

	    // 1. 로그인 확인
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/user/login.do";  // 로그인 페이지로 리다이렉트
	    }

	    // 2. 관리자 권한 확인
	    if (loginUser.getUserCd() != 0) {  // 0: 관리자 권한
	        redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 권한이 없습니다.");
	        return "redirect:/post/noticeDetail.do?postKey=" + post.getPostKey();  // 상세보기 페이지로 리다이렉트
	    }

	    try {
	        // 3. 작성자 정보 설정
	        post.setUserKey(loginUser.getUserKey());

	        // 4. 게시글 수정 처리
	        int result = service.updatePost(post);
	        if (result > 0) {
	            redirectAttributes.addFlashAttribute("successMessage", "공지사항이 성공적으로 수정되었습니다.");
	            return "redirect:/post/noticeDetail.do?postKey=" + post.getPostKey();  // 성공 시 상세보기 페이지로 이동
	        } else {
	            redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 중 오류가 발생했습니다.");
	            return "redirect:/post/noticePostEdit.do?postKey=" + post.getPostKey();  // 실패 시 수정 페이지로 복귀
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        redirectAttributes.addFlashAttribute("errorMessage", "공지사항 수정 중 예외가 발생했습니다.");
	        return "redirect:/post/noticePostEdit.do?postKey=" + post.getPostKey();
	    }
	}
}
