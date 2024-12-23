package com.khedu.sooljura.user.model.vo;

import java.util.ArrayList;

public class AddrListData {
    private ArrayList<UserAddr> addrList;

    public AddrListData() {
        super();
    }

    public AddrListData(ArrayList<UserAddr> addrList) {
        super();
        this.addrList = addrList;
    }

    public ArrayList<UserAddr> getAddrList() {
        return addrList;
    }

    public void setAddrList(ArrayList<UserAddr> addrList) {
        this.addrList = addrList;
    }

    @Override
    public String toString() {
        return "AddrListData [addrList=" + addrList + "]";
    }

}
