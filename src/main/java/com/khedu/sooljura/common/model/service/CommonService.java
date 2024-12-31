package com.khedu.sooljura.common.model.service;

import com.khedu.sooljura.common.model.dao.CommonDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

@Service("commonService")
public class CommonService {


    @Autowired
    @Qualifier("commonDao")
    private CommonDao dao;


}
