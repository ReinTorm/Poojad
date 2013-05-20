<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import="com.evalimine.uus.server.UserUtilities" %>
<% if (!UserUtilities.loggedIn(request)) {
 		response.sendRedirect("/login");
 	}
	if (!UserUtilities.isAdmin(request)){
		response.sendRedirect("/");
	}
%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine - Administraator</title>
	<link rel="stylesheet" href="/css/style.css">
</head>
<body id="adminpage">
	<div id="wrapper" class="wideradminpage">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="statpage" class="tab">
		<br/>
			<h4 class="content_heading">Administraatori leht</h4>
			<table class='stattable sortable'>
				<thead>
					<tr>
						<th class='sorttable_numeric'>#</th>
						<th class='alphabetic'>Eesnimi</th>
						<th class='alphabetic'>Perenimi</th>
						<th class='alphabetic'>Isikukood</th>
						<th class='alphabetic'>Erakond</th>
						<th class='alphabetic'>Valimispiirkond</th>
						<th class='alphabetic'>Aadress</th>
						<th class='alphabetic'>Lühike Info</th>
						<th class='alphabetic'>Pikk Info</th>
						<th class="sorttable_nosort">Staatus<br />
						<select id="CandidateStateOption">
						  <option value="PENDING">Pending</option>
						  <option value="DECLINED">Declined</option>
						  <option value="ACTIVE">Active</option>
						  <option value="NONE">None</option>
						  <option value="ALL">All</option>
						</select>
						</th>
					</tr>
				</thead>
				<tbody id="adminTable">
				</tbody>
			</table>
		</div><!-- statpage -->
	<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/sorttable.js"></script>
<script type="text/javascript" src='/js/json2.js'></script>
<script type="text/javascript" src='/js/adminpage.js'></script>
</body>
</html>