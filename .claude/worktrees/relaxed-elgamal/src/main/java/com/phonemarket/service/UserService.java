package com.phonemarket.service;

import com.phonemarket.config.DBConfig;
import com.phonemarket.model.User;
import com.phonemarket.util.PasswordUtil;
import com.phonemarket.util.ValidationUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {

    private static final int MAX_FAILED_ATTEMPTS = 5;

    /** Register a new user. Returns null on success, error message on failure. */
    public String register(String fullName, String email, String password, String phoneNumber) {
        if (!ValidationUtil.isNotEmpty(fullName))      return "Full name is required.";
        if (!ValidationUtil.isValidEmail(email))        return "Invalid email address.";
        if (!ValidationUtil.isValidPassword(password))
            return "Password must be at least 8 characters with uppercase, lowercase, digit and special character.";

        try (Connection conn = DBConfig.getConnection()) {
            // Check duplicate email
            PreparedStatement check = conn.prepareStatement("SELECT user_id FROM users WHERE email = ?");
            check.setString(1, email.trim().toLowerCase());
            ResultSet rs = check.executeQuery();
            if (rs.next()) return "Email already registered.";

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO users (full_name, email, password_hash, phone_number, role) VALUES (?,?,?,?,'user')");
            ps.setString(1, ValidationUtil.sanitize(fullName));
            ps.setString(2, email.trim().toLowerCase());
            ps.setString(3, PasswordUtil.hashPassword(password));
            ps.setString(4, phoneNumber == null ? "" : phoneNumber.trim());
            ps.executeUpdate();
            return null; // success
        } catch (SQLException e) {
            e.printStackTrace();
            return "Registration failed. Please try again.";
        }
    }

    /** Authenticate user. Returns User object or null. Sets error in returned String[0]. */
    public User login(String email, String password, String[] errorOut) {
        if (email == null || password == null) {
            errorOut[0] = "Email and password are required.";
            return null;
        }
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM users WHERE email = ?");
            ps.setString(1, email.trim().toLowerCase());
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                errorOut[0] = "Invalid credentials.";
                return null;
            }

            User user = mapUser(rs);

            if (user.isLocked()) {
                errorOut[0] = "Your account is temporarily locked due to too many failed attempts. Contact admin.";
                return null;
            }

            if (!PasswordUtil.checkPassword(password, user.getPasswordHash())) {
                int attempts = user.getFailedAttempts() + 1;
                boolean lock = attempts >= MAX_FAILED_ATTEMPTS;
                PreparedStatement upd = conn.prepareStatement(
                    "UPDATE users SET failed_attempts=?, is_locked=? WHERE user_id=?");
                upd.setInt(1, attempts);
                upd.setBoolean(2, lock);
                upd.setInt(3, user.getUserId());
                upd.executeUpdate();

                if (lock) {
                    errorOut[0] = "Too many failed attempts. Your account has been locked.";
                } else {
                    errorOut[0] = "Invalid credentials. (" + (MAX_FAILED_ATTEMPTS - attempts) + " attempts remaining)";
                }
                return null;
            }

            // Reset failed attempts on success
            PreparedStatement reset = conn.prepareStatement(
                "UPDATE users SET failed_attempts=0, is_locked=0 WHERE user_id=?");
            reset.setInt(1, user.getUserId());
            reset.executeUpdate();

            return user;
        } catch (SQLException e) {
            e.printStackTrace();
            errorOut[0] = "Login failed. Please try again.";
            return null;
        }
    }

    public User getUserById(int userId) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapUser(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    public List<User> getAllUsers() {
        List<User> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM users WHERE role='user' ORDER BY created_at DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapUser(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Update user profile (excluding password). */
    public String updateProfile(int userId, String fullName, String phoneNumber) {
        if (!ValidationUtil.isNotEmpty(fullName)) return "Full name is required.";
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET full_name=?, phone_number=? WHERE user_id=?");
            ps.setString(1, ValidationUtil.sanitize(fullName));
            ps.setString(2, phoneNumber == null ? "" : phoneNumber.trim());
            ps.setInt(3, userId);
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Update failed.";
        }
    }

    /** Change password (requires current password). */
    public String changePassword(int userId, String currentPw, String newPw) {
        User user = getUserById(userId);
        if (user == null) return "User not found.";
        if (!PasswordUtil.checkPassword(currentPw, user.getPasswordHash()))
            return "Current password is incorrect.";
        if (!ValidationUtil.isValidPassword(newPw))
            return "New password does not meet requirements.";
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET password_hash=? WHERE user_id=?");
            ps.setString(1, PasswordUtil.hashPassword(newPw));
            ps.setInt(2, userId);
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Password change failed.";
        }
    }

    /** Admin: unlock a user account */
    public void unlockUser(int userId) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE users SET is_locked=0, failed_attempts=0 WHERE user_id=?");
            ps.setInt(1, userId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private User mapUser(ResultSet rs) throws SQLException {
        User u = new User();
        u.setUserId(rs.getInt("user_id"));
        u.setFullName(rs.getString("full_name"));
        u.setEmail(rs.getString("email"));
        u.setPasswordHash(rs.getString("password_hash"));
        u.setPhoneNumber(rs.getString("phone_number"));
        u.setRole(rs.getString("role"));
        u.setLocked(rs.getBoolean("is_locked"));
        u.setFailedAttempts(rs.getInt("failed_attempts"));
        u.setCreatedAt(rs.getTimestamp("created_at"));
        return u;
    }
}
