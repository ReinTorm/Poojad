<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.evalimine.uus.server.UserUtilities"%>
<% if (!UserUtilities.loggedIn(request)) response.sendRedirect("/login"); %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine - Profiil</title>
	<link rel="stylesheet" href="/css/style.css">
</head>
<body id="profilepage">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="profilepage" class="tab">
			<aside>
				<h4>Minu andmed</h4>
				<p>Siin saad muuta seda kuidas teised sind valimiste keskonnas näevad. <br/><br />
					NB: kandideerimiseks on kõik väljad vajalikud. (ka. pilt)
				</p>
			</aside>
			<div id="content">
				<h4 class="content_heading">Minu Andmed</h4>
				<div id="my_data">
					<div id="avatar_block">

						<p><img id="avatar" src="./img/avatar.jpg"></p>
						<p class="error">Pilt on kandideerimiseks vajalik!</p>
						<p><a href="javascript:void(0);">Muuda pilti!</a></p>

					</div><!-- avatar_block -->
					<div id="my_data_block">
						<label>Piirkond:</label>
						<select id="constituency">
							<option value="" disabled="disabled" selected="selected">Vali valimisringkond</option>
							<% java.sql.Connection c = null;
							try {
								java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
								c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
								java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.constituency");								
								while (rs.next()){
									String CID = rs.getString("CID");
							        String cName = rs.getString("ConstituencyName");
									out.println("<option value='" + CID + "'>" + CID + " - " + cName + "</option>");								
							    }
							} catch (java.sql.SQLException e) {
								e.printStackTrace();
							} %>
						</select><br>
					</div><!-- my_data_block -->
				</div><!-- my_data -->
				<div id="votedfor">
					<h4>Sinu hääl</h4>
					<p><b>Kandidaat:</b> <a href="javascript:void(0);" id="voted_for_name">-</a><a href="javascript:void(0);"><img src="./img/cross_remove.png"></a>
					</p>
				</div>
				<div id="mystatus">
					<h4>Kandidatuur</h4>					
				</div>
				<a href="javascript:void(0);" id="savebutton" class="button">Salvesta!</a>
			</div><!-- content -->
		</div><!-- profilepage -->
		
		<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src='/js/json2.js'></script>
<script type="text/javascript" src='/js/profile.js'></script>
</body>
</html>