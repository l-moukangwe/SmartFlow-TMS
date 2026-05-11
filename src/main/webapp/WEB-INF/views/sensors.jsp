<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>SmartFlow - Sensors</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-traffic-light"></i> SmartFlow TMS</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link" href="/smartflow/dashboard">Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/incidents">Incidents</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/smartflow/sensors">Sensors</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/signals">Signals</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/users">Users</a></li>
                </ul>
                <ul class="navbar-nav"><li class="nav-item"><a class="nav-link" href="/smartflow/logout">Logout</a></li></ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-microchip"></i> Sensors Management</h2>
            <span class="badge bg-success">Moukangwe L.</span>
        </div>
        
        <!-- Add Sensor Form -->
        <div class="card mb-4">
            <div class="card-header bg-success text-white">
                <i class="fas fa-plus-circle"></i> Add New Sensor
            </div>
            <div class="card-body">
                <form method="post" action="/smartflow/sensors/add" class="row g-3">
                    <div class="col-md-4"><input type="text" name="sensor_name" class="form-control" placeholder="Sensor Name" required></div>
                    <div class="col-md-4"><input type="text" name="location" class="form-control" placeholder="Location" required></div>
                    <div class="col-md-2">
                        <select name="sensor_type" class="form-select" required>
                            <option value="">Type</option><option>Camera</option><option>Inductive Loop</option><option>Radar</option>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <select name="status" class="form-select" required>
                            <option value="">Status</option><option>Active</option><option>Maintenance</option><option>Offline</option>
                        </select>
                    </div>
                    <div class="col-12"><button type="submit" class="btn btn-success"><i class="fas fa-plus"></i> Add Sensor</button></div>
                </form>
            </div>
        </div>
        
        <!-- Sensors Table -->
        <div class="card">
            <div class="card-header bg-dark text-white"><i class="fas fa-list"></i> Current Sensors</div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead class="table-dark"><tr><th>ID</th><th>Name</th><th>Location</th><th>Type</th><th>Status</th><th>Action</th></tr></thead>
                    <tbody>
                        <c:forEach items="${sensors}" var="s">
                            <tr>
                                <td>${s.sensor_id}</td><td>${s.sensor_name}</td><td>${s.location}</td>
                                <td>${s.sensor_type}</td>
                                <td><span class="badge bg-${s.status == 'Active' ? 'success' : 'secondary'}">${s.status}</span></td>
                                <td><a href="/smartflow/sensors/delete?id=${s.sensor_id}" class="btn btn-sm btn-danger" onclick="return confirm('Delete?')"><i class="fas fa-trash"></i> Delete</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>