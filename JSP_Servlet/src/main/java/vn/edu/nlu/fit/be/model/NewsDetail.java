package vn.edu.nlu.fit.be.model;

public class NewsDetail {
    private int newsDetailId;
    private int newsId;
    private String newsDetailImg;
    private String newsDetailDescription;

    //Constructor

    public NewsDetail() {}

    public NewsDetail(int newsDetailId, String newsDetailDescription, String newsDetailImg, int newsId) {
        this.newsDetailId = newsDetailId;
        this.newsDetailDescription = newsDetailDescription;
        this.newsDetailImg = newsDetailImg;
        this.newsId = newsId;
    }

    // Getters & Setters

    public int getNewsDetailId() {
        return newsDetailId;
    }

    public void setNewsDetailId(int newsDetailId) {
        this.newsDetailId = newsDetailId;
    }

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public String getNewsDetailDescription() {
        return newsDetailDescription;
    }

    public void setNewsDetailDescription(String newsDetailDescription) {
        this.newsDetailDescription = newsDetailDescription;
    }

    public String getNewsDetailImg() {
        return newsDetailImg;
    }

    public void setNewsDetailImg(String newsDetailImg) {
        this.newsDetailImg = newsDetailImg;
    }
}
