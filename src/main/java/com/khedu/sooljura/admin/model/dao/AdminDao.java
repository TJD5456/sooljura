package com.khedu.sooljura.admin.model.dao;

import jdk.jfr.Registered;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

@Repository("adminDao")
public class AdminDao {

    @Autowired
    @Qualifier("sqlSessionTemplate")
    private SqlSessionTemplate sqlSessionTemplate;

}
