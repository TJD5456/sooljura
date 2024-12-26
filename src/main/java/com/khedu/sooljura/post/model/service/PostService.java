package com.khedu.sooljura.post.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.post.model.dao.PostDao;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostPageData;

@Service("postService")
public class PostService {

	@Autowired
	@Qualifier("postDao")
	private PostDao dao;

	public PostPageData selectPostList(int reqPage) {
		int viewNoticeCnt = 5;

		int end = reqPage * viewNoticeCnt;
		int start = end - viewNoticeCnt + 1;

		HashMap<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);

		// 게시글 리스트
		ArrayList<Post> list = (ArrayList<Post>) dao.selectPostList(map);

		// 전체 게시글 수
		int totCnt = dao.selectPostCount();

		// 전체 페이지 수
		int totPage = (totCnt % viewNoticeCnt > 0) ? (totCnt / viewNoticeCnt + 1) : (totCnt / viewNoticeCnt);

		// 페이지 네비게이션 크기
		int pageNaviSize = 3;

		// 페이지 네비게이션 시작 번호
		int pageNo = ((reqPage - 1) / pageNaviSize) * pageNaviSize + 1;

		// 페이지 네비게이션 HTML
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
		return new PostPageData(list, pageNavi.toString());
	}

	/*
	public int insertPost(Post post, ArrayList<PostFile> fileList) {
		// 1. 게시글 저장
		int postResult = dao.insertPost(post);

		// 2. 파일 저장
		int fileResult = 0;
		if (fileList != null && !fileList.isEmpty()) {
			PostFile file = fileList.get(0); // 단일 파일이므로 첫 번째 요소만 처리
			file.setPostKey(post.getPostKey()); // 게시글 키 설정
			fileResult = dao.insertPostFile(file);
		}

		return postResult > 0 && fileResult > 0 ? 1 : 0;
	}
*/
}
