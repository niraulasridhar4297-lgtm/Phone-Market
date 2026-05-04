package com.phonemarket.service;

import com.phonemarket.config.DBConfig;
import com.phonemarket.model.PhoneListing;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ListingService {

    /** Create a new listing. Returns error message or null on success. */
    public String createListing(PhoneListing l) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO phone_listings " +
                "(seller_id, title, brand, model_name, first_buy_date, ram_gb, storage_gb, " +
                " battery_mah, screen_size_inch, color, condition_grade, price, description, image_path, status, listing_order) " +
                "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,'available', " +
                "(SELECT COALESCE(MAX(listing_order),0)+1 FROM phone_listings pl2))");
            ps.setInt(1, l.getSellerId());
            ps.setString(2, l.getTitle());
            ps.setString(3, l.getBrand());
            ps.setString(4, l.getModelName());
            ps.setDate(5, l.getFirstBuyDate());
            ps.setInt(6, l.getRamGb());
            ps.setInt(7, l.getStorageGb());
            ps.setInt(8, l.getBatteryMah());
            ps.setBigDecimal(9, l.getScreenSizeInch());
            ps.setString(10, l.getColor());
            ps.setString(11, l.getConditionGrade());
            ps.setBigDecimal(12, l.getPrice());
            ps.setString(13, l.getDescription());
            ps.setString(14, l.getImagePath());
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Failed to create listing. Please try again.";
        }
    }

    /** Get all available listings with optional search, brand filter and sort. */
    public List<PhoneListing> searchListings(String keyword, String brand,
                                              String conditionGrade, String sortBy) {
        List<PhoneListing> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT pl.*, u.full_name AS seller_name, u.email AS seller_email " +
            "FROM phone_listings pl JOIN users u ON pl.seller_id = u.user_id " +
            "WHERE pl.status = 'available' ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (pl.title LIKE ? OR pl.brand LIKE ? OR pl.model_name LIKE ? OR pl.description LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw); params.add(kw); params.add(kw); params.add(kw);
        }
        if (brand != null && !brand.trim().isEmpty()) {
            sql.append("AND pl.brand = ? ");
            params.add(brand.trim());
        }
        if (conditionGrade != null && !conditionGrade.trim().isEmpty()) {
            sql.append("AND pl.condition_grade = ? ");
            params.add(conditionGrade.trim());
        }

        if ("price_asc".equals(sortBy))       sql.append("ORDER BY pl.price ASC ");
        else if ("price_desc".equals(sortBy)) sql.append("ORDER BY pl.price DESC ");
        else if ("newest".equals(sortBy))     sql.append("ORDER BY pl.created_at DESC ");
        else                                   sql.append("ORDER BY pl.listing_order ASC, pl.created_at DESC ");

        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapListing(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Get all listings by a specific seller. */
    public List<PhoneListing> getListingsBySeller(int sellerId) {
        List<PhoneListing> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT pl.*, u.full_name AS seller_name, u.email AS seller_email " +
                "FROM phone_listings pl JOIN users u ON pl.seller_id = u.user_id " +
                "WHERE pl.seller_id = ? ORDER BY pl.created_at DESC");
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapListing(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public PhoneListing getListingById(int listingId) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT pl.*, u.full_name AS seller_name, u.email AS seller_email " +
                "FROM phone_listings pl JOIN users u ON pl.seller_id = u.user_id " +
                "WHERE pl.listing_id = ?");
            ps.setInt(1, listingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapListing(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    /** User can update their own listing (only if status = available). */
    public String updateListing(PhoneListing l, int requesterId) {
        PhoneListing existing = getListingById(l.getListingId());
        if (existing == null) return "Listing not found.";
        if (existing.getSellerId() != requesterId) return "Unauthorized.";

        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE phone_listings SET title=?, brand=?, model_name=?, first_buy_date=?, " +
                "ram_gb=?, storage_gb=?, battery_mah=?, screen_size_inch=?, color=?, " +
                "condition_grade=?, price=?, description=? WHERE listing_id=?");
            ps.setString(1, l.getTitle());
            ps.setString(2, l.getBrand());
            ps.setString(3, l.getModelName());
            ps.setDate(4, l.getFirstBuyDate());
            ps.setInt(5, l.getRamGb());
            ps.setInt(6, l.getStorageGb());
            ps.setInt(7, l.getBatteryMah());
            ps.setBigDecimal(8, l.getScreenSizeInch());
            ps.setString(9, l.getColor());
            ps.setString(10, l.getConditionGrade());
            ps.setBigDecimal(11, l.getPrice());
            ps.setString(12, l.getDescription());
            ps.setInt(13, l.getListingId());
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Update failed.";
        }
    }

    /** User deletes their own listing. */
    public String deleteListing(int listingId, int requesterId) {
        PhoneListing existing = getListingById(listingId);
        if (existing == null) return "Listing not found.";
        if (existing.getSellerId() != requesterId) return "Unauthorized.";
        return deleteListingById(listingId);
    }

    /** Admin can delete any listing. */
    public String adminDeleteListing(int listingId) {
        return deleteListingById(listingId);
    }

    private String deleteListingById(int listingId) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "DELETE FROM phone_listings WHERE listing_id=?");
            ps.setInt(1, listingId);
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Delete failed.";
        }
    }

    /** Admin changes listing status (approve/reject/flag). */
    public void adminUpdateStatus(int listingId, String status) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE phone_listings SET status=? WHERE listing_id=?");
            ps.setString(1, status);
            ps.setInt(2, listingId);
            ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    /** Admin reorders a listing (swap with adjacent). */
    public void adminReorder(int listingId, String direction) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement getCurrent = conn.prepareStatement(
                "SELECT listing_order FROM phone_listings WHERE listing_id=?");
            getCurrent.setInt(1, listingId);
            ResultSet rs = getCurrent.executeQuery();
            if (!rs.next()) return;
            int currentOrder = rs.getInt("listing_order");

            String condition = "up".equals(direction) ? "<" : ">";
            String sortDir   = "up".equals(direction) ? "DESC" : "ASC";
            PreparedStatement getAdj = conn.prepareStatement(
                "SELECT listing_id, listing_order FROM phone_listings " +
                "WHERE status='available' AND listing_order " + condition + " ? " +
                "ORDER BY listing_order " + sortDir + " LIMIT 1");
            getAdj.setInt(1, currentOrder);
            ResultSet adjRs = getAdj.executeQuery();
            if (!adjRs.next()) return;
            int adjId    = adjRs.getInt("listing_id");
            int adjOrder = adjRs.getInt("listing_order");

            PreparedStatement upd1 = conn.prepareStatement(
                "UPDATE phone_listings SET listing_order=? WHERE listing_id=?");
            upd1.setInt(1, adjOrder); upd1.setInt(2, listingId); upd1.executeUpdate();

            PreparedStatement upd2 = conn.prepareStatement(
                "UPDATE phone_listings SET listing_order=? WHERE listing_id=?");
            upd2.setInt(1, currentOrder); upd2.setInt(2, adjId); upd2.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    /** Get all listings for admin review. */
    public List<PhoneListing> getAllListingsForAdmin() {
        List<PhoneListing> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT pl.*, u.full_name AS seller_name, u.email AS seller_email " +
                "FROM phone_listings pl JOIN users u ON pl.seller_id = u.user_id " +
                "ORDER BY pl.created_at DESC");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapListing(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    /** Get distinct brands for filter dropdown. */
    public List<String> getDistinctBrands() {
        List<String> brands = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT DISTINCT brand FROM phone_listings WHERE status='available' ORDER BY brand");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) brands.add(rs.getString("brand"));
        } catch (SQLException e) { e.printStackTrace(); }
        return brands;
    }

    private PhoneListing mapListing(ResultSet rs) throws SQLException {
        PhoneListing l = new PhoneListing();
        l.setListingId(rs.getInt("listing_id"));
        l.setSellerId(rs.getInt("seller_id"));
        l.setSellerName(rs.getString("seller_name"));
        l.setSellerEmail(rs.getString("seller_email"));
        l.setTitle(rs.getString("title"));
        l.setBrand(rs.getString("brand"));
        l.setModelName(rs.getString("model_name"));
        l.setFirstBuyDate(rs.getDate("first_buy_date"));
        l.setRamGb(rs.getInt("ram_gb"));
        l.setStorageGb(rs.getInt("storage_gb"));
        l.setBatteryMah(rs.getInt("battery_mah"));
        BigDecimal screen = rs.getBigDecimal("screen_size_inch");
        l.setScreenSizeInch(screen);
        l.setColor(rs.getString("color"));
        l.setConditionGrade(rs.getString("condition_grade"));
        l.setPrice(rs.getBigDecimal("price"));
        l.setDescription(rs.getString("description"));
        l.setImagePath(rs.getString("image_path"));
        l.setStatus(rs.getString("status"));
        l.setListingOrder(rs.getInt("listing_order"));
        l.setCreatedAt(rs.getTimestamp("created_at"));
        l.setUpdatedAt(rs.getTimestamp("updated_at"));
        return l;
    }
}
