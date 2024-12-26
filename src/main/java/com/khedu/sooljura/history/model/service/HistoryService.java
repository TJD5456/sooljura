package com.khedu.sooljura.history.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.history.model.dao.HistoryDao;

@Service("historyService")
public class HistoryService {
	@Autowired
	@Qualifier("historyDao")
	private HistoryDao dao;
}
