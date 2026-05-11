<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>SmartFlow - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #1a3e6f, #2c5a8c);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .card {
            border-radius: 15px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 400px;
        }
        .btn-primary { background: #1a3e6f; border: none; }
        .btn-primary:hover { background: #0f2b4a; }
    </style>
</head>
<body>
    <div class="card">
        <div class="card-header bg-primary text-white text-center">
            <h3>🚦 SmartFlow TMS</h3>
            <small>Traffic Management System</small>
        </div>
        <div class="card-body">
            <% if(request.getAttribute("error") != null) { %>
                <div class="alert alert-danger">${error}</div>
            <% } %>
            <form method="post" action="/smartflow/login">
                <div class="mb-3">
                    <label class="form-label">Username</label>
                    <input type="text" name="username" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary w-100">Login</button>
            </form>
            <hr>
            <div class="text-center">
                <small>Contact IT Support for password issues</small>
            </div>
        </div>
    </div>
</body>
</html>