package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.VoucherDao;
import vn.edu.nlu.fit.be.model.Voucher;

import java.util.List;

public class AdminVoucherService {

    private final VoucherDao voucherDao = new VoucherDao();

    public List<Voucher> getAllVouchers() {
        return voucherDao.getAll();
    }

    public void addVoucher(Voucher voucher) {
        voucherDao.insert(voucher);
    }

    public void deleteVoucher(int id) {
        voucherDao.delete(id);
    }
}
