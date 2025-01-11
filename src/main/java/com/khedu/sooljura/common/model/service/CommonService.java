package com.khedu.sooljura.common.model.service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.common.model.dao.CommonDao;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service("commonService")
public class CommonService {

    private final CommonDao dao;

    public CommonService(@Qualifier("commonDao") CommonDao dao) {
        this.dao = dao;
    }

    public ArrayList<Product> sel5EachCat() {
        return (ArrayList<Product>) dao.sel5EachCat();
    }

}
