package com.khedu.sooljura.post.model.service;

import com.khedu.sooljura.post.model.dao.PostDao;
import com.khedu.sooljura.post.model.vo.Comment;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostPageData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@Service("postService")
public class PostService {

	@Autowired
	@Qualifier("postDao")
	private PostDao dao;

	// 자유게시판, 공지사항 등 공통 메서드
	public PostPageData selectPostList(int reqPage, int postCd) {
		int postsPerPage = 5;
		int end = reqPage * postsPerPage;
		int start = end - postsPerPage + 1;

		HashMap<String, Integer> params = new HashMap<>();
		params.put("start", start);
		params.put("end", end);
		params.put("postCd", postCd);

		List<Post> list = dao.selectPostList(params);
		int totalPostCount = dao.selectPostCount(postCd);
		int totalPages = (int) Math.ceil((double) totalPostCount / postsPerPage);

		StringBuilder pageNavi = new StringBuilder();
		int naviSize = 3;
		int naviStart = ((reqPage - 1) / naviSize) * naviSize + 1;

		if (naviStart > 1) {
			pageNavi.append("<a href='?reqPage=").append(naviStart - 1).append("'> 이전 </a>");
		}
		for (int i = 0; i < naviSize && naviStart <= totalPages; i++, naviStart++) {
			if (naviStart == reqPage) {
				pageNavi.append("<span>").append(naviStart).append("</span>");
			} else {
				pageNavi.append("<a href='?reqPage=").append(naviStart).append("'>").append(naviStart).append("</a>");
			}
		}
		if (naviStart <= totalPages) {
			pageNavi.append("<a href='?reqPage=").append(naviStart).append("'> 다음 </a>");
		}

		PostPageData pd = new PostPageData();
		pd.setList((ArrayList<Post>) list);
		pd.setPageNavi(pageNavi.toString());
		return pd;
	}

	public int insertFreePost(Post post) {
		return dao.insertFreePost(post);
	}

	public Post selectOnePost(String postKey) {
		if (postKey == null || postKey.isEmpty()) {
			throw new IllegalArgumentException("postKey는 null이거나 비어 있을 수 없습니다.");
		}

		// 조회수 증가 처리
		dao.increasePostView(postKey); // 게시글 조회 시 항상 조회수 증가

		Post post = dao.selectOnePost(postKey);
		if (post == null) {
			throw new RuntimeException("해당 postKey에 대한 게시글이 존재하지 않습니다: " + postKey);
		}

		return post;
	}

	public int insertComment(Comment comment) {
		return dao.insertComment(comment);
	}

	public List<Comment> selectCommentsByPostKey(String postKey) {
		return dao.selectCommentsByPostKey(postKey);
	}

	public int deleteComment(String commentKey, String userKey) {
		return dao.deleteComment(commentKey, userKey);
	}

	public String getPostKeyByCommentKey(String commentKey) {
		String postKey = dao.selectPostKeyByCommentKey(commentKey);
		if (postKey == null) {
			throw new RuntimeException("해당 댓글에 대한 postKey를 찾을 수 없습니다: " + commentKey);
		}
		return postKey;
	}

	public int insertNoticePost(Post post) {
		return dao.insertNoticePost(post);
	}

	// 후기 게시판 insert 추가
	public int insertReviewPost(Post post) {
		return dao.insertReviewPost(post); // 후기 게시판 insert 호출
	}

	public int deletePost(String postKey, String userKey) {
		// 게시글 작성자 확인 후 삭제 처리
		return dao.deletePost(postKey, userKey);
	}

	public int updatePost(Post post) {
		return dao.updatePost(post);
	}

	public List<Post> getMyPostsByCategory(String userKey, int postCd) {
		return dao.selectPostsByUserAndCategory(userKey, postCd);
	}

}
