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

    public int selectPostCount(int postCd) {
        return sqlSession.selectOne("post.selectPostCount", postCd);
    }

    public String selectPostKey() {
        return sqlSession.selectOne("post.selectPostKey");
    }

    public int insertfreePost(Post post) {
        return sqlSession.insert("post.insertfreePost", post);
    }

    public Post selectOnePost(String postKey) {
        Post result = sqlSession.selectOne("post.selectOnePost", postKey);
        return result;
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

}

