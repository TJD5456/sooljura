package com.khedu.sooljura.post.model.dao;

import com.khedu.sooljura.post.model.vo.Comment;
import com.khedu.sooljura.post.model.vo.Post;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository("postDao")
public class PostDao {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSessionTemplate sqlSession;

	public List<Post> selectPostList(HashMap<String, Integer> params) {
		return sqlSession.selectList("post.selectPostList", params);
	}
	
	public List<Post> selectPostListWuserKey(HashMap<String, Object> params, String userKey) {
		Map<String, Object> param = params;
		param.put("userKey", userKey);
		return sqlSession.selectList("post.selectPostListWuserKey", param);
	}
	
	public int selectPostCount(int postCd) {
		return sqlSession.selectOne("post.selectPostCount", postCd);
	}

	public String selectPostKey() {
		return sqlSession.selectOne("post.selectPostKey");
	}

	public int insertFreePost(Post post) {
		return sqlSession.insert("post.insertFreePost", post);
	}

	public Post selectOnePost(String postKey) {
		return sqlSession.selectOne("post.selectOnePost", postKey);
	}

	// 댓글 등록
	public int insertComment(Comment comment) {
		return sqlSession.insert("post.insertComment", comment);
	}

	// 특정 게시글의 댓글 목록 조회
	public List<Comment> selectCommentsByPostKey(String postKey) {
		return sqlSession.selectList("post.selectCommentsByPostKey", postKey);
	}

	public int deleteComment(String commentKey, String userKey) {
		Map<String, String> params = new HashMap<>();
		params.put("commentKey", commentKey);
		params.put("userKey", userKey);
		return sqlSession.delete("post.deleteComment", params);
	}

	public String selectPostKeyByCommentKey(String commentKey) {
		return sqlSession.selectOne("post.selectPostKeyByCommentKey", commentKey);
	}

	public int updateComment(Comment comment) {
		return sqlSession.update("post.updateComment", comment);
	}

	public int insertNoticePost(Post post) {
		return sqlSession.insert("post.insertNoticePost", post);
	}

	// **조회수 증가 메서드 추가**
	public void increasePostView(String postKey) {
		sqlSession.update("post.increasePostView", postKey);
	}

	public int deletePost(String postKey, String userKey) {
		Map<String, String> params = new HashMap<>();
		params.put("postKey", postKey);
		params.put("userKey", userKey);
		return sqlSession.delete("post.deletePost", params);
	}

	public int updatePost(Post post) {
		return sqlSession.update("post.updatePost", post);
	}

	public interface PostDAO {
		int insertReviewPost(Post post); // 후기 게시판 insert 메서드 추가
	}

	public int insertReviewPost(Post post) {
		return sqlSession.insert("post.insertReviewPost", post); // SQL 호출
	}

	public List<Post> selectPostsByUserAndCategory(String userKey, int postCd) {
		Map<String, Object> params = new HashMap<>();
		params.put("userKey", userKey);
		params.put("postCd", postCd);
		return sqlSession.selectList("post.selectPostsByUserAndCategory", params);
	}

	public int adminDeletePost(String postKey) {
		return sqlSession.delete("post.adminDeletePost", postKey);
	}

	public int confirmYn(String postKey) {
		return sqlSession.update("post.confirmYn", postKey);
	}

}
