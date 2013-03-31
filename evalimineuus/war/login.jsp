<%@page import="com.evalimine.uus.server.GoogleAuthHelper"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
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
				out.println("<p style='margin: 5px 20px;'>Sain sellised andmed: </p>");
				out.println("<pre style='margin:5px 20px; background-color:#F2F2F2;border:1px solid #E0E0E0;'>");
				/*
				 * Executes after google redirects to the callback url.
				 * Please note that the state request parameter is for convenience to differentiate
				 * between authentication methods (ex. facebook oauth, google oauth, twitter, in-house).
				 * 
				 * GoogleAuthHelper()#getUserInfoJson(String) method returns a String containing
				 * the json representation of the authenticated user's information. 
				 * At this point you should parse and persist the info.
				 */

				out.println(helper.getUserInfoJson(request.getParameter("code")));

				out.println("</pre>");
			}
		%>
		</div>

		<jsp:include page="footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="scripts.jsp" />
</body>
</html>