package com.khedu.sooljura.admin.model.vo;

public class ProductCategory {
    private String categoryKey;
    private int categoryLevel;
    private String categoryNm;
    private String higherCategory;

    public ProductCategory() {
        super();
    }

    public ProductCategory(String categoryKey, int categoryLevel, String categoryNm, String higherCategory) {
        this.categoryKey = categoryKey;
        this.categoryLevel = categoryLevel;
        this.categoryNm = categoryNm;
        this.higherCategory = higherCategory;
    }

    public String getCategoryKey() {
        return categoryKey;
    }

    public void setCategoryKey(String categoryKey) {
        this.categoryKey = categoryKey;
    }

    public int getCategoryLevel() {
        return categoryLevel;
    }

    public void setCategoryLevel(int categoryLevel) {
        this.categoryLevel = categoryLevel;
    }

    public String getCategoryNm() {
        return categoryNm;
    }

    public void setCategoryNm(String categoryNm) {
        this.categoryNm = categoryNm;
    }

    public String getHigherCategory() {
        return higherCategory;
    }

    public void setHigherCategory(String higherCategory) {
        this.higherCategory = higherCategory;
    }
}
