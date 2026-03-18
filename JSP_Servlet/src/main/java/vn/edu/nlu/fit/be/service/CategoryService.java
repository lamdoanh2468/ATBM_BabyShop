package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.CategoryDao;
import vn.edu.nlu.fit.be.model.Category;

import java.util.List;

public class CategoryService {
    private final CategoryDao categoryDao = new CategoryDao();

    public List<Category> getAllCategories() {
        return categoryDao.findAllCategory();
    }

    public List<Category> getCategoryList() {
        return categoryDao.getCategoryList();
    }

    public Category getCategoryById(int id) {
        return categoryDao.getCategoryById(id);
    }
}
