# 🚦 SmartFlow Traffic Management System

## Overview
SmartFlow is a real-time traffic management system developed for the INT316D semester project. It helps traffic authorities monitor incidents, manage sensors, control traffic signals, and manage users.

## Technologies Used
- **Backend:** Java Spring Boot 3.1.5
- **Frontend:** JSP, Bootstrap 5, Font Awesome
- **Database:** MySQL (Cloud-hosted on FreeSQLDatabase)
- **Server:** Apache Tomcat (embedded)

## Team Members & Modules

| Member | Module | Student ID |
| :--- | :--- | :--- |
| Magongoa L.M. | Incidents Management | 221478770 |
| Moukangwe L. | Sensors Management | 224139632 |
| Lutchman R. | Traffic Signals Management | 231141979 |
| Matlala L.B. | Users Management | 231515216 |

## Features
- 🔐 User Authentication (Role-based: Admin, Officer, Viewer)
- 🚨 Incident Management (List, Resolve incidents)
- 📡 Sensor Management (List, Add, Delete sensors)
- 🚦 Traffic Signal Management (List, Update signal status)
- 👥 User Management (List, Add, Update user roles)
- 📊 Dashboard with real-time statistics
- 🗄️ Cloud-hosted MySQL database

## Setup Instructions

### Prerequisites
- Java 17 or higher
- Eclipse IDE (or IntelliJ)
- Maven

### Steps
1. Clone the repository: `git clone https://github.com/YOUR_USERNAME/SmartFlow-TMS.git`
2. Import as Maven project in Eclipse
3. Update `application.properties` with your database credentials
4. Run `SmartFlowTmsApplication.java`
5. Access at: `http://localhost:8080/smartflow`

### Test Credentials
| Username | Password | Role |
| :--- | :--- | :--- |
| lmatlala | matlala123 | Admin |
| lmoukangwe | pass123 | Officer |

## Database Schema
- users
- traffic_sensors
- traffic_logs
- traffic_incidents
- traffic_signals

## Screenshots
[Add screenshots here]

## Submission Date
May 11, 2026
