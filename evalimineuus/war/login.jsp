<%@page import="com.evalimine.uus.server.GoogleAuthHelper"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<html manifest="cache.manifest">
<head>
	<meta charset="utf-8">
	<title>eValimine</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body id="loginpage">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>

		<div class="tab">
		<br/>
		<h4 class="content_heading">Sisse logimine</h4>
		
		<%
			final GoogleAuthHelper helper = new GoogleAuthHelper();

			if (request.getParameter("code") == null || request.getParameter("state") == null) {
				out.println("<a href='" + helper.buildLoginUrl() + "' id='googlelogin'></a>");
			} else if (request.getParameter("code") != null && request.getParameter("state").equals("google")) {
				
				HttpSession sess = request.getSession(true);
				String json = helper.getUserInfoJson(request.getParameter("code"));
				org.json.JSONObject googleJson = new org.json.JSONObject(json); 
				
				String gId, gEmail, gFname, gLname, gPic = null;
				gId = googleJson.get("id").toString();
				gEmail = googleJson.get("email").toString();
				gFname = googleJson.get("given_name").toString();
				gLname = googleJson.get("family_name").toString();
				try{
				gPic = googleJson.get("picture").toString();
				}catch(org.json.JSONException e){
					//no picture
				}
				
				sess.setAttribute("google_id", gId);
				sess.setAttribute("google_firstname", gFname);
				sess.setAttribute("google_lastname", gLname);
				
				String queryCheck = ("SELECT * FROM db.user WHERE Google_Id=" + gId);
				String queryAdd = String.format("INSERT INTO db.user (Firstname, Lastname, Email, Google_Id, ImgUrl) VALUES"
						+ "('%s', '%s',  '%s', '%s', %s)", gFname, gLname, gEmail, gId, gPic==null? null : '"' + gPic + '"');
				
				java.sql.Connection c = null;
				try {
					java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
					c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
					java.sql.ResultSet check = c.createStatement().executeQuery(queryCheck);
					if(check.next()){
						if((check.getString("ImgUrl")!=gPic) && gPic!=null){
							c.createStatement().executeUpdate("UPDATE db.user SET db.user.ImgUrl='"+gPic+"' WHERE db.user.Google_Id='"+gId+"'");
						}
					}else{
						c.createStatement().execute(queryAdd);
					}
				} catch (java.sql.SQLException e) {
					e.printStackTrace();
				}						        
				response.sendRedirect("/");
			}
		%>
		</div>

		<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
</body>
</html>