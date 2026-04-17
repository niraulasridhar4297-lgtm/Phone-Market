package com.phonemarket.service;

import com.phonemarket.config.DBConfig;
import com.phonemarket.model.PurchaseRequest;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PurchaseService {

    public String sendRequest(int listingId, int buyerId, String message) {
        try (Connection conn = DBConfig.getConnection()) {
            // Prevent duplicate pending request
            PreparedStatement check = conn.prepareStatement(
                "SELECT request_id FROM purchase_requests WHERE listing_id=? AND buyer_id=? AND status='pending'");
            check.setInt(1, listingId);
            check.setInt(2, buyerId);
            if (check.executeQuery().next()) return "You already have a pending request for this listing.";

            PreparedStatement ps = conn.prepareStatement(
                "INSERT INTO purchase_requests (listing_id, buyer_id, message) VALUES (?,?,?)");
            ps.setInt(1, listingId);
            ps.setInt(2, buyerId);
            ps.setString(3, message == null ? "" : message.trim());
            ps.executeUpdate();
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            return "Failed to send request.";
        }
    }

    public List<PurchaseRequest> getRequestsForSeller(int sellerId) {
        List<PurchaseRequest> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT pr.*, u.full_name AS buyer_name, u.email AS buyer_email, pl.title AS listing_title " +
                "FROM purchase_requests pr " +
                "JOIN users u ON pr.buyer_id = u.user_id " +
                "JOIN phone_listings pl ON pr.listing_id = pl.listing_id " +
                "WHERE pl.seller_id = ? ORDER BY pr.created_at DESC");
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRequest(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public List<PurchaseRequest> getRequestsByBuyer(int buyerId) {
        List<PurchaseRequest> list = new ArrayList<>();
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "SELECT pr.*, u.full_name AS buyer_name, u.email AS buyer_email, pl.title AS listing_title " +
                "FROM purchase_requests pr " +
                "JOIN users u ON pr.buyer_id = u.user_id " +
                "JOIN phone_listings pl ON pr.listing_id = pl.listing_id " +
                "WHERE pr.buyer_id = ? ORDER BY pr.created_at DESC");
            ps.setInt(1, buyerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRequest(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    public void updateRequestStatus(int requestId, String status) {
        try (Connection conn = DBConfig.getConnection()) {
            PreparedStatement ps = conn.prepareStatement(
                "UPDATE purchase_requests SET status=? WHERE request_id=?");
            ps.setString(1, status);
            ps.setInt(2, requestId);
            ps.executeUpdate();

            // If accepted, mark listing as sold
            if ("accepted".equals(status)) {
                PreparedStatement getListing = conn.prepareStatement(
                    "SELECT listing_id FROM purchase_requests WHERE request_id=?");
                getListing.setInt(1, requestId);
                ResultSet rs = getListing.executeQuery();
                if (rs.next()) {
                    PreparedStatement markSold = conn.prepareStatement(
                        "UPDATE phone_listings SET status='sold' WHERE listing_id=?");
                    markSold.setInt(1, rs.getInt("listing_id"));
                    markSold.executeUpdate();
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
    }

    private PurchaseRequest mapRequest(ResultSet rs) throws SQLException {
        PurchaseRequest r = new PurchaseRequest();
        r.setRequestId(rs.getInt("request_id"));
        r.setListingId(rs.getInt("listing_id"));
        r.setBuyerId(rs.getInt("buyer_id"));
        r.setBuyerName(rs.getString("buyer_name"));
        r.setBuyerEmail(rs.getString("buyer_email"));
        r.setListingTitle(rs.getString("listing_title"));
        r.setMessage(rs.getString("message"));
        r.setStatus(rs.getString("status"));
        r.setCreatedAt(rs.getTimestamp("created_at"));
        return r;
    }
}
