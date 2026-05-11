package com.SmartFlowTMS.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    
    private static final String DB_URL = "jdbc:mysql://sql7.freesqldatabase.com:3306/sql7826420?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String DB_USER = "sql7826420";
    private static final String DB_PASS = "jeXe9Yve6G";
    
    private Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
    }
    
    @GetMapping("/")
    public String home() { return "redirect:/login"; }
    
    @GetMapping("/login")
    public String showLogin() { return "login"; }
    
    @PostMapping("/login")
    public String doLogin(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT user_id, f_name, l_name, role FROM users WHERE username = ? AND password_hash = ?");
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                session.setAttribute("user_id", rs.getInt("user_id"));
                session.setAttribute("full_name", rs.getString("f_name") + " " + rs.getString("l_name"));
                session.setAttribute("role", rs.getString("role"));
                return "redirect:/dashboard";
            }
            model.addAttribute("error", "Invalid credentials");
            return "login";
        } catch (Exception e) {
            model.addAttribute("error", "Database error: " + e.getMessage());
            return "login";
        }
    }
    
    @GetMapping("/dashboard")
    public String dashboard(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("SELECT COUNT(*) FROM users");
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) model.addAttribute("userCount", rs.getInt(1));
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM traffic_sensors WHERE status='Active'");
            rs = stmt.executeQuery();
            if (rs.next()) model.addAttribute("sensorCount", rs.getInt(1));
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM traffic_incidents WHERE status='Active'");
            rs = stmt.executeQuery();
            if (rs.next()) model.addAttribute("incidentCount", rs.getInt(1));
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM traffic_signals WHERE status='Operational'");
            rs = stmt.executeQuery();
            if (rs.next()) model.addAttribute("signalCount", rs.getInt(1));
        } catch (Exception e) { e.printStackTrace(); }
        return "dashboard";
    }
    
    @GetMapping("/logout")
    public String logout(HttpSession session) { session.invalidate(); return "redirect:/login"; }
    
    // ========== INCIDENTS MODULE ==========
    @GetMapping("/incidents")
    public String incidents(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        List<Map<String, Object>> incidents = new ArrayList<>();
        try (Connection conn = getConnection()) {
            String sql = "SELECT i.*, CONCAT(u.f_name, ' ', u.l_name) as reported_by_name FROM traffic_incidents i LEFT JOIN users u ON i.reported_by = u.user_id ORDER BY i.reported_at DESC";
            ResultSet rs = conn.createStatement().executeQuery(sql);
            while (rs.next()) {
                Map<String, Object> inc = new HashMap<>();
                inc.put("incident_id", rs.getInt("incident_id"));
                inc.put("incident_type", rs.getString("incident_type"));
                inc.put("severity", rs.getString("severity"));
                inc.put("location", rs.getString("location"));
                inc.put("status", rs.getString("status"));
                inc.put("reported_by_name", rs.getString("reported_by_name") != null ? rs.getString("reported_by_name") : "System");
                inc.put("reported_at", rs.getTimestamp("reported_at"));
                incidents.add(inc);
            }
        } catch (Exception e) { e.printStackTrace(); }
        model.addAttribute("incidents", incidents);
        return "incidents";
    }
    
    @GetMapping("/incidents/resolve")
    public String resolveIncident(@RequestParam int id, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("UPDATE traffic_incidents SET status='Resolved', resolved_at=NOW() WHERE incident_id=?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/incidents";
    }
    
    // ========== SENSORS MODULE ==========
    @GetMapping("/sensors")
    public String sensors(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        List<Map<String, Object>> sensors = new ArrayList<>();
        try (Connection conn = getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM traffic_sensors ORDER BY sensor_id");
            while (rs.next()) {
                Map<String, Object> s = new HashMap<>();
                s.put("sensor_id", rs.getInt("sensor_id"));
                s.put("sensor_name", rs.getString("sensor_name"));
                s.put("location", rs.getString("location"));
                s.put("sensor_type", rs.getString("sensor_type"));
                s.put("status", rs.getString("status"));
                sensors.add(s);
            }
        } catch (Exception e) { e.printStackTrace(); }
        model.addAttribute("sensors", sensors);
        return "sensors";
    }
    
    @PostMapping("/sensors/add")
    public String addSensor(@RequestParam String sensor_name, @RequestParam String location, @RequestParam String sensor_type, @RequestParam String status, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO traffic_sensors (sensor_name, location, sensor_type, status, installed_date) VALUES (?, ?, ?, ?, CURDATE())");
            stmt.setString(1, sensor_name);
            stmt.setString(2, location);
            stmt.setString(3, sensor_type);
            stmt.setString(4, status);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/sensors";
    }
    
    @GetMapping("/sensors/delete")
    public String deleteSensor(@RequestParam int id, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM traffic_sensors WHERE sensor_id=?");
            stmt.setInt(1, id);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/sensors";
    }
    
    // ========== SIGNALS MODULE ==========
    @GetMapping("/signals")
    public String signals(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        List<Map<String, Object>> signals = new ArrayList<>();
        try (Connection conn = getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT * FROM traffic_signals ORDER BY signal_id");
            while (rs.next()) {
                Map<String, Object> sig = new HashMap<>();
                sig.put("signal_id", rs.getInt("signal_id"));
                sig.put("intersection", rs.getString("intersection"));
                sig.put("current_mode", rs.getString("current_mode"));
                sig.put("cycle_length", rs.getInt("cycle_length"));
                sig.put("status", rs.getString("status"));
                signals.add(sig);
            }
        } catch (Exception e) { e.printStackTrace(); }
        model.addAttribute("signals", signals);
        return "signals";
    }
    
    @PostMapping("/signals/update")
    public String updateSignal(@RequestParam int signal_id, @RequestParam String status, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("UPDATE traffic_signals SET status=?, last_updated=NOW() WHERE signal_id=?");
            stmt.setString(1, status);
            stmt.setInt(2, signal_id);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/signals";
    }
    
    // ========== USERS MODULE ==========
    @GetMapping("/users")
    public String users(HttpSession session, Model model) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        List<Map<String, Object>> users = new ArrayList<>();
        try (Connection conn = getConnection()) {
            ResultSet rs = conn.createStatement().executeQuery("SELECT user_id, username, f_name, l_name, role, email FROM users ORDER BY user_id");
            while (rs.next()) {
                Map<String, Object> u = new HashMap<>();
                u.put("user_id", rs.getInt("user_id"));
                u.put("username", rs.getString("username"));
                u.put("f_name", rs.getString("f_name"));
                u.put("l_name", rs.getString("l_name"));
                u.put("role", rs.getString("role"));
                u.put("email", rs.getString("email"));
                users.add(u);
            }
        } catch (Exception e) { e.printStackTrace(); }
        model.addAttribute("users", users);
        return "users";
    }
    
    @PostMapping("/users/add")
    public String addUser(@RequestParam String username, @RequestParam String password, @RequestParam String f_name, @RequestParam String l_name, @RequestParam String email, @RequestParam String role, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (username, password_hash, f_name, l_name, email, role) VALUES (?, ?, ?, ?, ?, ?)");
            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, f_name);
            stmt.setString(4, l_name);
            stmt.setString(5, email);
            stmt.setString(6, role);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/users";
    }
    
    @PostMapping("/users/update")
    public String updateUser(@RequestParam int user_id, @RequestParam String role, HttpSession session) {
        if (session.getAttribute("user_id") == null) return "redirect:/login";
        try (Connection conn = getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("UPDATE users SET role=? WHERE user_id=?");
            stmt.setString(1, role);
            stmt.setInt(2, user_id);
            stmt.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
        return "redirect:/users";
    }
}