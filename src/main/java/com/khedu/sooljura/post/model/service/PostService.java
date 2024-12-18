package com.khedu.sooljura.post.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.khedu.sooljura.post.model.dao.PostDao;

import org.springframework.beans.factory.annotation.Qualifier;

@Service("postService")
public class PostService {

	@Autowired
	@Qualifier("postDao")
	private PostDao dao;
	
	
	
	
	
	
}
