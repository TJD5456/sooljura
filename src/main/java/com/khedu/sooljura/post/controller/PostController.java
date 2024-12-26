package com.khedu.sooljura.post.controller;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.khedu.sooljura.post.model.service.PostService;
import com.khedu.sooljura.post.model.vo.Post;
import com.khedu.sooljura.post.model.vo.PostFile;
import com.khedu.sooljura.post.model.vo.PostPageData;

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

		// 응답페이지(list.jsp)에서 게시글 목룍을 보여주기 위해, 응답 데이터를 등록 할 수 있는 Model 객체 매개변수에 추가.
		model.addAttribute("list", pd.getList());
		model.addAttribute("pageNavi", pd.getPageNavi());

		return "post/freePost";
	}

	
	/*
	@PostMapping("freewrite.do")
	public String freewrite(HttpServletRequest request, MultipartFile file, Post post, Model model) {
	    String savePath = request.getSession().getServletContext().getRealPath("/resources/upload/post/");
	    String filePath = null;

	    try {
	        // 디렉토리가 존재하지 않을 경우 생성
	        File directory = new File(savePath);
	        if (!directory.exists()) {
	            directory.mkdirs();
	        }

	        if (file != null && !file.isEmpty()) {
	            String originalFileName = file.getOriginalFilename();
	            String fileName = originalFileName.substring(0, originalFileName.lastIndexOf("."));
	            String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	            String toDay = new SimpleDateFormat("yyyyMMdd").format(new Date());
	            int ranNum = new Random().nextInt(10000) + 1;
	            filePath = fileName + "_" + toDay + "_" + ranNum + extension;
	            String fullSavePath = savePath + filePath;

	            // 파일 저장
	            try (BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(new File(fullSavePath)))) {
	                byte[] bytes = file.getBytes();
	                bos.write(bytes);
	            }

	            // 파일 정보를 PostFile 객체에 설정
	            PostFile postFile = new PostFile();
	            postFile.setPostFileNm(originalFileName);
	            postFile.setPostFilePath(filePath);

	            ArrayList<PostFile> fileList = new ArrayList<>();
	            fileList.add(postFile);
	            service.insertPost(post, fileList);
	        } else {
	            service.insertPost(post, null); // 파일 없이 게시글 등록
	        }

	        return "redirect:/post/getList.do?reqPage=1";

	    } catch (Exception e) {
	        e.printStackTrace(); // 디버깅용 로그
	        model.addAttribute("errorMessage", "게시글 등록에 실패했습니다.");
	        model.addAttribute("post", post); // 기존 입력 내용을 다시 전달
	        return "post/freePostWriter"; // 작성 페이지로 다시 이동
	    }
	}
	*/
}
