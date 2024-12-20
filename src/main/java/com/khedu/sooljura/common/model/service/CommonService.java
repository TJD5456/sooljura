package com.khedu.sooljura.common.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.common.model.dao.CommonDao;

@Service("commonService")
public class CommonService {

	
	@Autowired
	@Qualifier("commonDao")
	private CommonDao dao;
	
	
	
}
