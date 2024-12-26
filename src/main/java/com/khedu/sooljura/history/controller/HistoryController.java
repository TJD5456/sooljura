package com.khedu.sooljura.history.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.khedu.sooljura.history.model.service.HistoryService;

@Controller
@RequestMapping("/history/")
public class HistoryController {
	@Autowired
	@Qualifier("historyService")
	private HistoryService service;
}
