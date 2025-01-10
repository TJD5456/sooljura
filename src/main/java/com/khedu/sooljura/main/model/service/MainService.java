package com.khedu.sooljura.main.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.khedu.sooljura.admin.model.vo.Product;
import com.khedu.sooljura.admin.model.vo.Youtube;
import com.khedu.sooljura.main.model.dao.MainDao;

@Service("mainService")
public class MainService {

	 @Autowired
	    @Qualifier("mainDao")
	    private MainDao dao;
	public ArrayList<Product> getAllItems() {
		  return (ArrayList<Product>)dao.getAllItems();
	}
	public ArrayList<Product> getWine() {
		ArrayList<Product> wineList = new ArrayList<Product>();
		ArrayList<Product> getWineList = (ArrayList<Product>)dao.getProdList("c0001");
		for(int i =0; i<5; i++) {
			wineList.add(getWineList.get(i));
		}
		 return wineList;
	}
	public ArrayList<Product> getWhiskey() {
		ArrayList<Product> whiskeyList = new ArrayList<Product>();
		ArrayList<Product> getWhiskeyList = (ArrayList<Product>)dao.getProdList("c0002");
		for(int i =0; i<5; i++) {
			whiskeyList.add(getWhiskeyList.get(i));
		}
		 return whiskeyList;
	}
	public ArrayList<Product> getBrandy() {
		ArrayList<Product> brandyList = new ArrayList<Product>();
		ArrayList<Product> getBrandyList = (ArrayList<Product>)dao.getProdList("c0003");
		for(int i =0; i<5; i++) {
			brandyList.add(getBrandyList.get(i));
		}
		 return brandyList;
	}
	public ArrayList<Product> getLiqueur() {
		ArrayList<Product> liqueurList = new ArrayList<Product>();
		ArrayList<Product> getLiqueurList = (ArrayList<Product>)dao.getProdList("c0004");
		for(int i =0; i<5; i++) {
			liqueurList.add(getLiqueurList.get(i));
		}
		 return liqueurList;
	}
	public ArrayList<Product> getSoju() {
		ArrayList<Product> sojuList = new ArrayList<Product>();
		ArrayList<Product> getSojuList = (ArrayList<Product>)dao.getProdList("c0005");
		for(int i =0; i<5; i++) {
			sojuList.add(getSojuList.get(i));
		}
		 return sojuList;
	}
	public ArrayList<Product> getEtc() {
		ArrayList<Product> etcList = new ArrayList<Product>();
		ArrayList<Product> getEtcList = (ArrayList<Product>)dao.getProdList("c0006");
		for(int i =0; i<5; i++) {
			etcList.add(getEtcList.get(i));
		}
		 return etcList;
	}
	public Youtube chkYt() {
		return dao.chkYt();
	}

}
