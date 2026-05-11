<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>SmartFlow - Signals</title>
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
                    <li class="nav-item"><a class="nav-link" href="/smartflow/sensors">Sensors</a></li>
                    <li class="nav-item"><a class="nav-link active" href="/smartflow/signals">Signals</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/users">Users</a></li>
                </ul>
                <ul class="navbar-nav"><li class="nav-item"><a class="nav-link" href="/smartflow/logout">Logout</a></li></ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2><i class="fas fa-traffic-light"></i> Traffic Signals Management</h2>
            <span class="badge bg-danger">Lutchman R.</span>
        </div>
        
        <div class="card">
            <div class="card-header bg-dark text-white"><i class="fas fa-list"></i> Traffic Signals</div>
            <div class="card-body">
                <table class="table table-striped">
                    <thead class="table-dark"><tr><th>ID</th><th>Intersection</th><th>Mode</th><th>Cycle (sec)</th><th>Status</th><th>Action</th></tr></thead>
                    <tbody>
                        <c:forEach items="${signals}" var="sig">
                            <tr>
                                <td>${sig.signal_id}</td><td>${sig.intersection}</td>
                                <td>${sig.current_mode}</td><td>${sig.cycle_length}</td>
                                <td><span class="badge bg-${sig.status == 'Operational' ? 'success' : 'warning'}">${sig.status}</span></td>
                                <td>
                                    <form method="post" action="/smartflow/signals/update" style="display:inline;">
                                        <input type="hidden" name="signal_id" value="${sig.signal_id}">
                                        <select name="status" class="form-select form-select-sm" style="width:120px;display:inline-block;">
                                            <option>Operational</option><option>Faulty</option><option>Maintenance</option>
                                        </select>
                                        <button type="submit" class="btn btn-sm btn-warning"><i class="fas fa-edit"></i> Update</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>