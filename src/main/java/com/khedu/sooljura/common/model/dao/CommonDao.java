package com.khedu.sooljura.common.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.khedu.sooljura.admin.model.vo.Product;

@Repository("commonDao")
public class CommonDao {

    private final SqlSessionTemplate sqlSession;

    public CommonDao(@Qualifier("sqlSessionTemplate") SqlSessionTemplate sqlSession) {
        this.sqlSession = sqlSession;
    }

    public List<Product> getProdList(String categoryKey) {
        return sqlSession.selectList("product.getProdList", categoryKey);
    }

}
