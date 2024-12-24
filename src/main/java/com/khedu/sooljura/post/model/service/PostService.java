package com.khedu.sooljura.post.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.khedu.sooljura.post.model.dao.PostDao;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostFile;
import com.khedu.sooljura.post.model.vo.PostPageData;

import org.springframework.beans.factory.annotation.Qualifier;

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
		
		//등록될 게시글의 번호를 먼저 조회(notice 정보 및 notice_file 정보 등록 시 모두 필요하므로)
			String Postkey = dao.selectPostKey();
		//tbl_poset(참조되는)와 tbl_post_file(참조하는)은 참조 관계이므로, tbl_post-insert를 선작업.
			post.setPostKey(Postkey);
			int result = dao.insertPost(post);
			
			
			
			if(result > 0) {
				for(int i=0; i<fileList.size();i++) {
					PostFile file = fileList.get(i);
					file.setPostKey(Postkey);
					
//					result = dao.insertNoticeFile(file);
					  RuntimeException ex = new RentimeException("강제 exception");
				
				}
			}
			return result;

	}
	
*/	
}
