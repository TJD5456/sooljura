package com.khedu.sooljura.notice.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.notice.model.dao.NoticeDao;

import org.springframework.beans.factory.annotation.Qualifier;

@Service("noticeService")
public class NoticeService {

	@Autowired
	@Qualifier("noticeDao")
	private NoticeDao dao;
	
	
	
	
	
	
	
	
}
