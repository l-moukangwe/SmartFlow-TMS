-- ============================================
-- SMARTFLOW TRAFFIC MANAGEMENT SYSTEM
-- Database Schema for Java Spring Boot Project
-- ============================================

-- Drop tables in correct order (due to foreign keys)
DROP TABLE IF EXISTS traffic_logs;
DROP TABLE IF EXISTS traffic_incidents;
DROP TABLE IF EXISTS traffic_signals;
DROP TABLE IF EXISTS traffic_sensors;
DROP TABLE IF EXISTS users;

-- ============================================
-- TABLE 1: users
-- ============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('Admin','Officer','Viewer','City Planner','Dispatcher','Maintenance') NOT NULL,
    f_name VARCHAR(50) NOT NULL,
    l_name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE 2: traffic_sensors
-- ============================================
CREATE TABLE traffic_sensors (
    sensor_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_name VARCHAR(100) NOT NULL,
    location VARCHAR(255) NOT NULL,
    sensor_type ENUM('Camera','Inductive Loop','Radar','Infrared') NOT NULL,
    status ENUM('Active','Maintenance','Offline','Decommissioned') DEFAULT 'Active',
    installed_date DATE NOT NULL
);

-- ============================================
-- TABLE 3: traffic_logs
-- ============================================
CREATE TABLE traffic_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    sensor_id INT NOT NULL,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    vehicle_count INT NOT NULL,
    average_speed DECIMAL(5,2),
    occupancy_rate DECIMAL(5,2),
    FOREIGN KEY (sensor_id) REFERENCES traffic_sensors(sensor_id) ON DELETE CASCADE
);

-- ============================================
-- TABLE 4: traffic_incidents
-- ============================================
CREATE TABLE traffic_incidents (
    incident_id INT AUTO_INCREMENT PRIMARY KEY,
    incident_type ENUM('Accident','Roadwork','Hazard','Congestion','Special Event','Weather') NOT NULL,
    severity ENUM('Low','Medium','High','Critical') NOT NULL,
    location VARCHAR(255) NOT NULL,
    description VARCHAR(1000),
    reported_by INT,
    reported_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    resolved_at TIMESTAMP NULL,
    status ENUM('Active','Resolved','False Alarm','Investigating') DEFAULT 'Active',
    FOREIGN KEY (reported_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- ============================================
-- TABLE 5: traffic_signals
-- ============================================
CREATE TABLE traffic_signals (
    signal_id INT AUTO_INCREMENT PRIMARY KEY,
    intersection VARCHAR(255) NOT NULL,
    current_mode ENUM('Normal','Flashing','Manual Override','Off','Emergency Priority') DEFAULT 'Normal',
    cycle_length INT DEFAULT 60,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_by INT,
    status ENUM('Operational','Faulty','Maintenance','Testing') DEFAULT 'Operational',
    FOREIGN KEY (updated_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- ============================================
-- SAMPLE DATA (5+ records per table)
-- ============================================

-- Users
INSERT INTO users (username, password_hash, role, f_name, l_name, email) VALUES
('lmatlala', 'matlala123', 'Admin', 'Lethabo', 'Matlala', 'lethabo.matlala@city.gov'),
('lmoukangwe', 'pass123', 'Officer', 'Lesedi', 'Moukangwe', 'lesedi.moukangwe@traffic.gov'),
('lmagongoa', 'citizens123', 'Dispatcher', 'Lesedi', 'Magongoa', 'lesedi.magongoa@city.gov'),
('rlutchman', 'united123', 'City Planner', 'Rishal', 'Lutchman', 'rishal.lutchman@planning.gov'),
('tborotho', 'pass123', 'Viewer', 'Thabang', 'Borotho', 'thabang.borotho@maintenance.gov'),
('tmanka', 'pass123', 'City Planner', 'Thapelo', 'Manka', 'tmank@gmail.com');

-- Traffic Sensors
INSERT INTO traffic_sensors (sensor_name, location, sensor_type, status, installed_date) VALUES
('N1 Highway Camera 1', 'N1 Highway at Exit 5', 'Camera', 'Active', '2023-01-15'),
('CBD Loop Sensor A', 'Main Street and Church Square', 'Inductive Loop', 'Active', '2023-03-20'),
('Eastern Bypass Radar', 'Eastern Bypass near Mall', 'Radar', 'Active', '2023-06-10'),
('Airport Road Sensor', 'Airport Approach Road', 'Inductive Loop', 'Active', '2023-09-12'),
('Northern Bypass Radar', 'Northern Bypass Toll Plaza', 'Radar', 'Offline', '2023-04-18');

-- Traffic Logs
INSERT INTO traffic_logs (sensor_id, vehicle_count, average_speed, occupancy_rate) VALUES
(1, 120, 65.50, 45.20),
(1, 185, 45.20, 78.50),
(2, 45, 25.00, 60.00),
(3, 210, 80.00, 30.50),
(2, 60, 15.50, 85.00);

-- Traffic Incidents
INSERT INTO traffic_incidents (incident_type, severity, location, description, reported_by, status) VALUES
('Accident', 'High', 'N1 Highway at Exit 5', 'Multi-vehicle collision, right lane blocked', 1, 'Active'),
('Roadwork', 'Medium', 'Main Street between Church and Market', 'Road resurfacing, lane closures', 4, 'Active'),
('Congestion', 'High', 'Eastern Bypass near Mall', 'Heavy traffic due to mall opening sale', NULL, 'Active'),
('Hazard', 'Low', 'Bridge Street', 'Debris on roadway', NULL, 'Resolved'),
('Weather', 'Critical', 'Northern Bypass', 'Flash flooding, road impassable', NULL, 'Resolved'),
('Special Event', 'Medium', 'City Stadium', 'Football match, heavy traffic expected', 2, 'Active');

-- Traffic Signals
INSERT INTO traffic_signals (intersection, current_mode, cycle_length, updated_by, status) VALUES
('Main Street & Church Square', 'Flashing', 60, NULL, 'Maintenance'),
('N1 Highway & Exit 5', 'Normal', 90, NULL, 'Operational'),
('Airport Road & Terminal', 'Manual Override', 120, 1, 'Operational'),
('Bridge Street & Nelson Mandela', 'Flashing', 30, NULL, 'Maintenance'),
('Eastern Bypass & Mall Entrance', 'Normal', 75, NULL, 'Operational'),
('CBD & Government Boulevard', 'Emergency Priority', 45, 2, 'Testing');

-- ============================================
-- END OF SCRIPT
-- ============================================