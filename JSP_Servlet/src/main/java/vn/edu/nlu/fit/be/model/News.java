package vn.edu.nlu.fit.be.model;

import java.sql.Timestamp;

public class News {

    private int newsId;
    private String newsName;
    private String newsImg;
    private Timestamp newsCreated;

    //Constructor

    public News() {}

    public News(int newsId, String newsName, String newsImg, Timestamp newsCreated) {
        this.newsId = newsId;
        this.newsName = newsName;
        this.newsImg = newsImg;
        this.newsCreated = newsCreated;
    }

    // Getters & Setters

    public int getNewsId() {
        return newsId;
    }

    public void setNewsId(int newsId) {
        this.newsId = newsId;
    }

    public Timestamp getNewsCreated() {
        return newsCreated;
    }

    public void setNewsCreated(Timestamp newsCreated) {
        this.newsCreated = newsCreated;
    }

    public String getNewsImg() {
        return newsImg;
    }

    public void setNewsImg(String newsImg) {
        this.newsImg = newsImg;
    }

    public String getNewsName() {
        return newsName;
    }

    public void setNewsName(String newsName) {
        this.newsName = newsName;
    }
}
