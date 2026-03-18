package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.ContactDao;
import vn.edu.nlu.fit.be.model.Contact;

import java.util.List;

public class ContactService {
    private final ContactDao contactDao = new ContactDao();

    public boolean createContact(int accountId, String fullName, String phone, String email, String address, String message) {
        Contact contact = new Contact();
        contact.setAccountId(accountId);
        contact.setFullName(fullName);
        contact.setPhone(phone);
        contact.setEmail(email);
        contact.setAddress(address);
        contact.setMessage(message);
        int rows = contactDao.insertContact(contact);
        return rows > 0;
    }
    public List<Contact> loadMoreContacts() {
        return contactDao.LoadContactLatest();
    }
    public Contact getContactById(int id) {
        return contactDao.findById(id);
    }

    public void deleteContact(int id) {
        contactDao.deleteById(id);
    }

}

