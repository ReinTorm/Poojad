<%@page import="com.evalimine.uus.server.GoogleAuthHelper"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>


<html>
<head>
	<meta charset="utf-8">
	<title>eValimine</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body id="loginpage">
	<div id="wrapper">
		<jsp:include page="header.jsp" />
		<canvas id="highlight"></canvas>

		<div class="tab">
		<h4 align="center">Sisse logimine</h4>
		
		<%
			final GoogleAuthHelper helper = new GoogleAuthHelper();

			if (request.getParameter("code") == null || request.getParameter("state") == null) {
				out.println("<a href='" + helper.buildLoginUrl() + "' id='googlelogin'></a>");
			} else if (request.getParameter("code") != null && request.getParameter("state").equals("google")) {
				
				HttpSession sess = request.getSession(true);
				String json = helper.getUserInfoJson(request.getParameter("code"));
				int startIndex=json.indexOf("\"name\": \"")+9;
				int endIndex=json.indexOf("\"", startIndex);
				String name = json.substring(startIndex, endIndex);

				sess.setAttribute("User", name);
						        
				response.sendRedirect("/");
			}
		%>
		</div>

		<jsp:include page="footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="scripts.jsp" />
</body>
</html>