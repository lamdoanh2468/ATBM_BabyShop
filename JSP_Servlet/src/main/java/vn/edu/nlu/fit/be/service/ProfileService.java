package vn.edu.nlu.fit.be.service;

import vn.edu.nlu.fit.be.dao.ProfileDao;
import vn.edu.nlu.fit.be.model.Profile;

import java.util.Optional;

public class ProfileService {

    private final ProfileDao profileDao = new ProfileDao();

    /* ===================== FIND ===================== */
    public Profile findById(int profileId) {
        if (profileId <= 0) return null;
        return profileDao.findById(profileId).orElse(null);
    }

    /* ===================== CREATE ===================== */
    public int createProfile(Profile profile) {
        if (profile == null) return -1;
        return profileDao.insert(profile);
    }

    /* ===================== GET ===================== */
    public Optional<Profile> getProfileById(int profileId) {
        if (profileId <= 0) return Optional.empty();
        return profileDao.findById(profileId);
    }

    /* ===================== UPDATE ===================== */
    public boolean update(Profile profile) {
        if (profile == null) return false;
        if (profile.getProfileId() <= 0) return false;
        return profileDao.update(profile);
    }

    /* ===================== DELETE ===================== */
    public boolean deleteProfile(int profileId) {
        if (profileId <= 0) return false;
        return profileDao.delete(profileId);
    }
}
