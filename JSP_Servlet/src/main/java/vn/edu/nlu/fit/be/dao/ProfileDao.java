package vn.edu.nlu.fit.be.dao;

import vn.edu.nlu.fit.be.DB.DBConnect;
import vn.edu.nlu.fit.be.model.Gender;
import vn.edu.nlu.fit.be.model.Profile;

import java.util.Optional;

public class ProfileDao extends BaseDao {
    /* ===================== INSERT ===================== */
    public int insert(Profile p) {
        return jdbi.withHandle(handle ->
                handle.createUpdate("""
                    INSERT INTO profiles
                        (full_name, email, phone, address, gender, avatar_url, birth_date)
                    VALUES
                        (:fullName, :email, :phone, :address, :gender, :avatarUrl, :birthDate)
                """)
                        .bind("fullName", p.getFullName())
                        .bind("email", p.getEmail())
                        .bind("phone", p.getPhone())
                        .bind("address", p.getAddress())
                        .bind("gender", p.getGender().name())
                        .bind("avatarUrl", p.getAvatarUrl())
                        .bind("birthDate", p.getBirthDate())
                        .executeAndReturnGeneratedKeys("profile_id")
                        .mapTo(Integer.class)
                        .one()
        );
    }

    /* ===================== FIND BY ID ===================== */
    public Optional<Profile> findById(int id) {
        return jdbi.withHandle(handle ->
                handle.createQuery("""
            SELECT profile_id, full_name, email, phone, address,
                   gender, avatar_url, birth_date, updated_at
            FROM profiles
            WHERE profile_id = :id
        """)
                        .bind("id", id)
                        .map((rs, ctx) -> {
                            Profile p = new Profile();
                            p.setProfileId(rs.getInt("profile_id"));
                            p.setFullName(rs.getString("full_name"));
                            p.setEmail(rs.getString("email"));
                            p.setPhone(rs.getString("phone"));
                            p.setAddress(rs.getString("address"));
                            p.setAvatarUrl(rs.getString("avatar_url"));
                            p.setBirthDate(rs.getDate("birth_date"));
                            p.setUpdatedAt(rs.getTimestamp("updated_at"));

                            // ⭐ FIX CHÍNH Ở ĐÂY ⭐
                            String genderStr = rs.getString("gender");
                            if (genderStr != null) {
                                p.setGender(Gender.valueOf(genderStr.toUpperCase()));
                            } else {
                                p.setGender(null); // hoặc Gender.OTHER
                            }

                            return p;
                        })
                        .findOne()
        );
    }

    /* ===================== UPDATE ===================== */
    public boolean update(Profile p) {
        int rows = jdbi.withHandle(handle ->
                handle.createUpdate("""
                    UPDATE profiles
                    SET
                        full_name   = :fullName,
                        phone       = :phone,
                        address     = :address,
                        gender      = :gender,
                        avatar_url  = :avatarUrl,
                        birth_date  = :birthDate,
                        updated_at  = CURRENT_TIMESTAMP
                    WHERE profile_id = :id
                """)
                        .bind("fullName", p.getFullName())
                        .bind("phone", p.getPhone())
                        .bind("address", p.getAddress())
                        .bind("gender", p.getGender().name())
                        .bind("avatarUrl", p.getAvatarUrl())
                        .bind("birthDate", p.getBirthDate())
                        .bind("id", p.getProfileId())
                        .execute()
        );
        return rows > 0;
    }

    /* ===================== DELETE ===================== */
    public boolean delete(int profileId) {
        int rows = jdbi.withHandle(handle ->
                handle.createUpdate("""
                    DELETE FROM profiles
                    WHERE profile_id = :id
                """)
                        .bind("id", profileId)
                        .execute()
        );
        return rows > 0;
    }
}
