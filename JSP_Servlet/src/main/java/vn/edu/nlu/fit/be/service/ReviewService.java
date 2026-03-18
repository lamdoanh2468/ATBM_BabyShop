package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.ReviewDao;

import java.util.*;

public class ReviewService {
    private ReviewDao rdao = new ReviewDao();

    public List<Map<String, Object>> getReviewsByProductId(int productId) {
        return rdao.getReviewsByProductId(productId);
    }

    public boolean addReview(int accountId, int productId, String comment) {
        return rdao.addReview(accountId, productId, comment);
    }

}
