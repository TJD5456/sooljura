package com.khedu.sooljura.post.model.dao;

import org.springframework.stereotype.Repository;

import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostFile;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;


@Repository("postDao")
public class PostDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSession;

    public List<Post> selectPostList(HashMap<String, Integer> map) {
        return sqlSession.selectList("post.selectPostList", map);
        
    }

    public int selectPostCount() {
        return sqlSession.selectOne("post.selectPostCount");
    }

	public String selectPostKey() {
		return sqlSession.selectOne("post.selectPostKey");
	}

	public int insertPost(Post post) {
		return sqlSession.insert("post.insertPost",post);
	}

	public int insertPostFile(PostFile file) {
		return sqlSession.insert("post.insertPostFile",file);
	}
}

