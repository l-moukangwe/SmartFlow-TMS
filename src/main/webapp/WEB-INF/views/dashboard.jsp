<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>SmartFlow - Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-traffic-light"></i> SmartFlow TMS</a>
            <div class="collapse navbar-collapse">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item"><a class="nav-link active" href="/smartflow/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                    
                    <!-- Role-based menu items -->
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'Dispatcher' || sessionScope.user_id == 3}">
                        <li class="nav-item"><a class="nav-link" href="/smartflow/incidents"><i class="fas fa-exclamation-triangle"></i> Incidents</a></li>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'Maintenance' || sessionScope.user_id == 2}">
                        <li class="nav-item"><a class="nav-link" href="/smartflow/sensors"><i class="fas fa-microchip"></i> Sensors</a></li>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'City Planner' || sessionScope.user_id == 4}">
                        <li class="nav-item"><a class="nav-link" href="/smartflow/signals"><i class="fas fa-traffic-light"></i> Signals</a></li>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.user_id == 1}">
                        <li class="nav-item"><a class="nav-link" href="/smartflow/users"><i class="fas fa-users"></i> Users</a></li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> ${sessionScope.full_name} (${sessionScope.role})
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="/smartflow/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="alert alert-success">
            <h4>Welcome, ${sessionScope.full_name}!</h4>
            <p>Role: <strong>${sessionScope.role}</strong> | User ID: ${sessionScope.user_id}</p>
            <hr>
            <p class="mb-0">You have access to modules based on your role.</p>
        </div>
        
        <div class="row">
            <div class="col-md-3">
                <div class="card text-white bg-primary mb-3">
                    <div class="card-body text-center">
                        <i class="fas fa-users fa-3x"></i>
                        <h5 class="mt-2">Total Users</h5>
                        <h3>${userCount}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-success mb-3">
                    <div class="card-body text-center">
                        <i class="fas fa-microchip fa-3x"></i>
                        <h5 class="mt-2">Active Sensors</h5>
                        <h3>${sensorCount}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-warning mb-3">
                    <div class="card-body text-center">
                        <i class="fas fa-exclamation-triangle fa-3x"></i>
                        <h5 class="mt-2">Active Incidents</h5>
                        <h3>${incidentCount}</h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="card text-white bg-danger mb-3">
                    <div class="card-body text-center">
                        <i class="fas fa-traffic-light fa-3x"></i>
                        <h5 class="mt-2">Operational Signals</h5>
                        <h3>${signalCount}</h3>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header bg-dark text-white">
                <i class="fas fa-cubes"></i> Your Accessible Modules
            </div>
            <div class="card-body">
                <div class="row">
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'Dispatcher' || sessionScope.user_id == 3}">
                        <div class="col-md-3">
                            <div class="card text-center border-warning">
                                <div class="card-body">
                                    <i class="fas fa-exclamation-triangle fa-2x text-warning"></i>
                                    <h6>Incidents</h6>
                                    <small>Magongoa L.M.</small><br>
                                    <a href="/smartflow/incidents" class="btn btn-sm btn-warning mt-2">Access</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'Maintenance' || sessionScope.user_id == 2}">
                        <div class="col-md-3">
                            <div class="card text-center border-success">
                                <div class="card-body">
                                    <i class="fas fa-microchip fa-2x text-success"></i>
                                    <h6>Sensors</h6>
                                    <small>Moukangwe L.</small><br>
                                    <a href="/smartflow/sensors" class="btn btn-sm btn-success mt-2">Access</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.role == 'City Planner' || sessionScope.user_id == 4}">
                        <div class="col-md-3">
                            <div class="card text-center border-danger">
                                <div class="card-body">
                                    <i class="fas fa-traffic-light fa-2x text-danger"></i>
                                    <h6>Signals</h6>
                                    <small>Lutchman R.</small><br>
                                    <a href="/smartflow/signals" class="btn btn-sm btn-danger mt-2">Access</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${sessionScope.role == 'Admin' || sessionScope.user_id == 1}">
                        <div class="col-md-3">
                            <div class="card text-center border-primary">
                                <div class="card-body">
                                    <i class="fas fa-users fa-2x text-primary"></i>
                                    <h6>Users</h6>
                                    <small>Matlala L.B.</small><br>
                                    <a href="/smartflow/users" class="btn btn-sm btn-primary mt-2">Access</a>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${empty sessionScope.role}">
                        <div class="col-12 text-center">Please log in</div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>