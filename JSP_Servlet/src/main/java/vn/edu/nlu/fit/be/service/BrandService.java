package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.BrandDao;
import vn.edu.nlu.fit.be.model.Brand;

import java.util.List;

public class BrandService {
    private BrandDao bd = new BrandDao();
    private final BrandDao brandDao = new BrandDao();

    public List<Brand> getBrands() {
        return bd.getBrands();
    }

    public Brand getBrandById(int id) {
        return bd.getBrandById(id);
    }

    public List<Brand> loadMoreBrands() {
        return brandDao.LoadBrandLatest();
    }
    public void addBrand(Brand brand) {
        if (brand.getBrandName() == null || brand.getBrandName().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên thương hiệu không được để trống");
        }
        brandDao.insertBrand(brand);
    }
    public void deleteBrand(int id) {
        brandDao.deleteBrand(id);
    }
    public void updateBrand(Brand brand) {
        if (brand.getBrandName() == null || brand.getBrandName().trim().isEmpty()) {
            throw new IllegalArgumentException("Tên thương hiệu không được để trống");
        }
        brandDao.updateBrand(brand);
    }
}
