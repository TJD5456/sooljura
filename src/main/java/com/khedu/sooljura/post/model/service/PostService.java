package com.khedu.sooljura.post.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.post.model.dao.PostDao;
import com.khedu.sooljura.post.model.vo.Comment;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostPageData;

@Service("postService")
public class PostService {

	@Autowired
	@Qualifier("postDao")
	private PostDao dao;

	public PostPageData selectPostList(int reqPage) {
	    int viewNoticeCnt = 5; // 한 페이지당 표시할 게시글 수

	    // 페이징 시작 및 끝 계산
	    int end = reqPage * viewNoticeCnt;
	    int start = end - viewNoticeCnt + 1;

	    HashMap<String, Integer> map = new HashMap<>();
	    map.put("start", start);
	    map.put("end", end);

	    // 게시글 리스트 가져오기
	    ArrayList<Post> list = (ArrayList<Post>) dao.selectPostList(map);

	    // 전체 게시글 수 가져오기
	    int totCnt = dao.selectPostCount();

	    // 전체 페이지 수 계산
	    int totPage = (totCnt % viewNoticeCnt > 0) ? (totCnt / viewNoticeCnt + 1) : (totCnt / viewNoticeCnt);

	    // 페이지 네비게이션 설정
	    int pageNaviSize = 3; // 한 번에 보여줄 페이지 네비게이션 크기
	    int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1; // 페이지 네비게이션 시작 번호
	    StringBuilder pageNavi = new StringBuilder();

	    // 이전 버튼
	    if (pageNo != 1) {
	        pageNavi.append("<a href='/post/getList.do?reqPage=").append(pageNo - 1).append("'> 이전 </a>");
	    }

	    // 페이지 번호
	    for (int i = 0; i < pageNaviSize; i++) {
	        if (pageNo == reqPage) {
	            pageNavi.append("<span>").append(pageNo).append("</span>");
	        } else {
	            pageNavi.append("<a href='/post/getList.do?reqPage=").append(pageNo).append("'>").append(pageNo)
	                    .append("</a>");
	        }
	        pageNo++;
	        if (pageNo > totPage) {
	            break;
	        }
	    }

	    // 다음 버튼
	    if (pageNo <= totPage) {
	        pageNavi.append("<a href='/post/getList.do?reqPage=").append(pageNo).append("'> 다음 </a>");
	    }
	    
	    // PostPageData 객체 생성 후 반환
	    return new PostPageData(list, pageNavi.toString());
	}

	public int insertfreePost(Post post) {
	    return dao.insertfreePost(post);
	}
	

	public Post selectOnePost(String postKey) {
	    // postKey가 null인지 확인
	    if (postKey == null || postKey.isEmpty()) {
	        return null; // 혹은 예외 처리
	    }

	    // DAO에서 post 조회
	    Post post = dao.selectOnePost(postKey);

	    // post가 null인지 확인
	    if (post == null) {
	        System.out.println("postKey에 해당하는 게시글을 찾을 수 없습니다: " + postKey);
	        return null;
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

    public int updateComment(String commentKey, String userKey, String commentContent) {
        return dao.updateComment(commentKey, userKey, commentContent);
    }
    public String getPostKeyByCommentKey(String commentKey) {
        return dao.selectPostKeyByCommentKey(commentKey);
    }
	
	
}
