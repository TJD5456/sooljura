package com.khedu.sooljura.post.model.vo;

import java.util.ArrayList;

public class PostPageData {

    private ArrayList<Post> list;
    private String pageNavi;

    public PostPageData() {
        super();
    }

    public PostPageData(ArrayList<Post> list, String pageNavi) {
        super();
        this.list = list;
        this.pageNavi = pageNavi;
    }

    public ArrayList<Post> getList() {
        return list;
    }

    public void setList(ArrayList<Post> list) {
        this.list = list;
    }

    public String getPageNavi() {
        return pageNavi;
    }

    public void setPageNavi(String pageNavi) {
        this.pageNavi = pageNavi;
    }

    @Override
    	 public String toString() {
    	        return "PostPageData [listSize=" + (list != null ? list.size() : 0) + ", pageNavi=" + pageNavi + "]";
    }

}
