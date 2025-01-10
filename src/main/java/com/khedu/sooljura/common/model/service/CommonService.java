package com.khedu.sooljura.common.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.common.model.dao.CommonDao;

@Service("commonService")
public class CommonService {

    private final CommonDao dao;

    public CommonService(@Qualifier("commonDao") CommonDao dao) {
        this.dao = dao;
    }

	public ArrayList<Product> getProdList(String categoryKey) {
		ArrayList<Product> list = new ArrayList<>();
		ArrayList<Product> prodList = (ArrayList<Product>) dao.getProdList(categoryKey);

		if (prodList != null) {
			for (int i = 0; i < 5; i++) {
				list.add(prodList.get(i));
			}

		}
		return list;
	}

}
