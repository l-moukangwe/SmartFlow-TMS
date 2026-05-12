<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<title>SmartFlow - Incidents</title>
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
						href="/smartflow/dashboard"><i class="fas fa-home"></i>
							Dashboard</a></li>

					<c:if
						test="${sessionScope.role == 'Admin' || sessionScope.role == 'Dispatcher' || sessionScope.user_id == 3}">
						<li class="nav-item"><a class="nav-link active"
							href="/smartflow/incidents"><i
								class="fas fa-exclamation-triangle"></i> Incidents</a></li>
					</c:if>

					<c:if
						test="${sessionScope.role == 'Admin' || sessionScope.role == 'Maintenance' || sessionScope.user_id == 2}">
						<li class="nav-item"><a class="nav-link"
							href="/smartflow/sensors"><i class="fas fa-microchip"></i>
								Sensors</a></li>
					</c:if>

					<c:if
						test="${sessionScope.role == 'Admin' || sessionScope.role == 'City Planner' || sessionScope.user_id == 4}">
						<li class="nav-item"><a class="nav-link"
							href="/smartflow/signals"><i class="fas fa-traffic-light"></i>
								Signals</a></li>
					</c:if>

					<c:if
						test="${sessionScope.role == 'Admin' || sessionScope.user_id == 1}">
						<li class="nav-item"><a class="nav-link"
							href="/smartflow/users"><i class="fas fa-users"></i> Users</a></li>
					</c:if>
				</ul>
				<ul class="navbar-nav">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						data-bs-toggle="dropdown"> <i class="fas fa-user-circle"></i>
							${sessionScope.full_name} (${sessionScope.role})
					</a>
						<ul class="dropdown-menu dropdown-menu-end">
							<li><a class="dropdown-item" href="/smartflow/logout"><i
									class="fas fa-sign-out-alt"></i> Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container mt-4">
		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2>
				<i class="fas fa-exclamation-triangle"></i> Incidents Management
			</h2>
			<span class="badge bg-warning">Magongoa L.M.</span>
		</div>

		<!-- Incidents Table -->
		<div class="card">
			<div class="card-header bg-dark text-white">
				<i class="fas fa-list"></i> Traffic Incidents List
			</div>
			<div class="card-body">
				<div class="table-responsive">
					<table class="table table-striped table-hover">
						<thead class="table-dark">
							<tr>
								<th>ID</th>
								<th>Type</th>
								<th>Severity</th>
								<th>Location</th>
								<th>Status</th>
								<th>Reported By</th>
								<th>Reported At</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${incidents}" var="incident">
								<tr>
									<td>${incident.incident_id}</td>
									<td>${incident.incident_type}</td>
									<td><span
										class="badge bg-${incident.severity == 'Critical' ? 'danger' : (incident.severity == 'High' ? 'warning' : 'secondary')}">${incident.severity}</span></td>
									<td>${incident.location}</td>
									<td><span
										class="badge bg-${incident.status == 'Active' ? 'danger' : 'success'}">${incident.status}</span></td>
									<td>${incident.reported_by_name}</td>
									<td>${incident.reported_at}</td>
									<td><c:if test="${incident.status == 'Active'}">
											<a
												href="/smartflow/incidents/resolve?id=${incident.incident_id}"
												class="btn btn-sm btn-success"
												onclick="return confirm('Resolve this incident?')"> <i
												class="fas fa-check"></i> Resolve
											</a>
										</c:if></td>
								</tr>
							</c:forEach>
							<c:if test="${empty incidents}">
								<tr>
									<td colspan="8" class="text-center">No incidents found</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>