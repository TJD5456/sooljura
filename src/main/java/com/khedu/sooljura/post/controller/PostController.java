package com.khedu.sooljura.post.controller;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostFile;
import com.khedu.sooljura.post.model.vo.PostPageData;

import org.springframework.beans.factory.annotation.Qualifier;

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

	@GetMapping("detaliReviewPost.do")
	public String detaliReviewPost() {
		return "post/detaliReviewPost";
	}

	@GetMapping("reviewListPost.do")
	public String reviewListPost() {
		return "post/reviewListPost";
	}

	@GetMapping("freePostWirter.do")
	public String freePostWirter() {
		return "post/freePostWirter";
	}

	@GetMapping("webPageInfo.do")
	public String webPageInfo() {
		return "post/webPageInfo";
	}

	@GetMapping("getList.do")
	public String getList(int reqPage, Model model) {
		PostPageData pd = service.selectPostList(reqPage);

		// 응답페이지(list.jsp)에서 게시글 목룍을 보여주기 위해, 응답 데이터를 등록 할 수 있는 Model 객체 매개변수에 추가.
		model.addAttribute("list", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());

		return "post/freePost";
	}

	@GetMapping("freewrite.do")
	public String freewrite(HttpServletRequest request, MultipartFile[] files, Post post) {

		// 서비스에 파일 정보를 전달하기 위한 ArrayList
		ArrayList<PostFile> fileList = new ArrayList<PostFile>();

		for (int i = 0; i < files.length; i++) {
			MultipartFile file = files[i];

			if (!file.isEmpty()) {
				String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/notice/");
				String originalFileName = file.getOriginalFilename();// 업로드한 파일명 =>test1.txt
				String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));// test1
				String extension = originalFileName.substring(originalFileName.lastIndexOf("."));// .txt

				String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());// 오늘 날짜 ==20241205
				int ranNum = new Random().nextInt(10000) + 1;// 1~10000사이 랜덤 숫자
				String filePath = fileName + "_" + toDay + "_" + ranNum + extension;// test1 + _ + 20241205 + _랜덤숫자 +
																					// .txt = > test1_20241205_4525.txt

				savePath += filePath;

				// 파일 업로드를 위한 보조 스트림
				BufferedOutputStream bos = null;

				try {
					byte[] bytes = file.getBytes();
					FileOutputStream fos = new FileOutputStream(new File(savePath));
					bos = new BufferedOutputStream(fos);
					bos.write(bytes);

					PostFile postFile = new PostFile();
					// tbl_post_file(post_file_key,post_key,post_file_nm,post_file_path)
					postFile.setPostFileNm(originalFileName);// 원본 파일명
					postFile.setPostFilePath(filePath); // 업로드 파일명

					// 리스트에 추가
					fileList.add(postFile);
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} finally {
					try {
						bos.close();
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

		}
		int result = service.insertPost(post, fileList);
		
		return "redirect:/post/getList.do?reqPage=1";
	}
}
