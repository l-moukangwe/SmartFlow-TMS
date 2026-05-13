<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>SmartFlow - Users</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
		<div class="container">
			<a class="navbar-brand" href="#"><i class="fas fa-traffic-light"></i>
				SmartFlow TMS</a>
			<div class="collapse navbar-collapse">
				<ul class="navbar-nav me-auto">
					<li class="nav-item"><a class="nav-link"
						href="/smartflow/dashboard">Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/smartflow/incidents">Incidents</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/smartflow/sensors">Sensors</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/smartflow/signals">Signals</a></li>
					<li class="nav-item"><a class="nav-link active"
						href="/smartflow/users">Users</a></li>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link"
						href="/smartflow/logout">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container mt-4">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2>
				<i class="fas fa-users"></i> Users Management
			</h2>
			<span class="badge bg-primary">Matlala L.B.</span>
		</div>

		<!-- Add User Form -->
		<div class="card mb-4">
			<div class="card-header bg-primary text-white">
				<i class="fas fa-user-plus"></i> Add New User
			</div>
			<div class="card-body">
				<form method="post" action="/smartflow/users/add" class="row g-3">
					<div class="col-md-3">
						<input type="text" name="username" class="form-control"
							placeholder="Username" required>
					</div>
					<div class="col-md-3">
						<input type="text" name="password" class="form-control"
							placeholder="Password" required>
					</div>
					<div class="col-md-3">
						<input type="text" name="f_name" class="form-control"
							placeholder="First Name" required>
					</div>
					<div class="col-md-3">
						<input type="text" name="l_name" class="form-control"
							placeholder="Last Name" required>
					</div>
					<div class="col-md-3">
						<input type="email" name="email" class="form-control"
							placeholder="Email">
					</div>
					<div class="col-md-2">
						<select name="role" class="form-select" required>
							<option value="">Role</option>
							<option>Admin</option>
							<option>Officer</option>
							<option>Viewer</option>
						</select>
					</div>
					<div class="col-md-2">
						<button type="submit" class="btn btn-primary">
							<i class="fas fa-plus"></i> Add User
						</button>
					</div>
				</form>
			</div>
		</div>

		<!-- Users Table -->
		<div class="card">
			<div class="card-header bg-dark text-white">
				<i class="fas fa-list"></i> System Users
			</div>
			<div class="card-body">
				<table class="table table-striped">
					<thead class="table-dark">
						<tr>
							<th>ID</th>
							<th>Username</th>
							<th>Name</th>
							<th>Role</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users}" var="u">
							<tr>
								<td>${u.user_id}</td>
								<td>${u.username}</td>
								<td>${u.f_name}${u.l_name}</td>
								<td>
									<form method="post" action="/smartflow/users/update"
										style="display: inline;">
										<input type="hidden" name="user_id" value="${u.user_id}">
										<select name="role" class="form-select form-select-sm"
											style="width: 120px; display: inline-block;">
											<option ${u.role == 'Admin' ? 'selected' : ''}>Admin</option>
											<option ${u.role == 'Officer' ? 'selected' : ''}>Officer</option>
											<option ${u.role == 'Viewer' ? 'selected' : ''}>Viewer</option>
										</select>
										<button type="submit" class="btn btn-sm btn-warning">
											<i class="fas fa-save"></i> Update
										</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
