<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
                    <li class="nav-item"><a class="nav-link" href="/smartflow/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/incidents"><i class="fas fa-exclamation-triangle"></i> Incidents</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/sensors"><i class="fas fa-microchip"></i> Sensors</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/signals"><i class="fas fa-traffic-light"></i> Signals</a></li>
                    <li class="nav-item"><a class="nav-link" href="/smartflow/users"><i class="fas fa-users"></i> Users</a></li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link" href="/smartflow/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
            </div>
        </div>
    </nav>
    
    <div class="container mt-4">
        <div class="alert alert-success">
            <h4>Welcome, ${sessionScope.full_name}!</h4>
            <p>Role: <strong>${sessionScope.role}</strong> | User ID: ${sessionScope.user_id}</p>
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
                <i class="fas fa-cubes"></i> System Modules
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-exclamation-triangle fa-2x text-warning"></i>
                                <h6>Incidents</h6>
                                <small>Magongoa L.M.</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-microchip fa-2x text-success"></i>
                                <h6>Sensors</h6>
                                <small>Moukangwe L.</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-traffic-light fa-2x text-danger"></i>
                                <h6>Signals</h6>
                                <small>Lutchman R.</small>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card text-center">
                            <div class="card-body">
                                <i class="fas fa-users fa-2x text-primary"></i>
                                <h6>Users</h6>
                                <small>Matlala L.B.</small>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>