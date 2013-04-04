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

						<p><img src="./img/avatar.jpg"></p>
						<p class="error">Pilt on kandideerimiseks vajalik!</p>
						<p><a href="javascript:void(0);">Muuda pilti!</a></p>

					</div><!-- avatar_block -->
					<div id="my_data_block">
						<label>Eesnimi:</label><input type="text" name="fname"><br /> 
						<label>Perenimi:</label><input type="text" name="lname"><br /> 
						<label>Vanus:</label><input type="text" name="age"><br /> 
						<label>Valimispiirkond:</label>
						<select>
							<option value="" disabled="disabled" selected="selected">Vali valimisringkond</option>
							<option value="1">1 – Tallinna Haabersti, Põhja-Tallinna ja Kristiine linnaosa</option>
							<option value="2">2 – Tallinna Kesklinna, Lasnamäe ja Pirita linnaosa</option>
							<option value="3">3 – Tallinna Mustamäe ja Nõmme linnaosa</option>
							<option value="4">4 – Harju- (v.a Tallinn) ja Raplamaa</option>
							<option value="5">5 – Hiiu-, Lääne- ja Saaremaa</option>
							<option value="6">6 – Lääne-Virumaa</option>
							<option value="7">7 – Ida-Virumaa</option>
							<option value="8">8 – Järva- ja Viljandimaa</option>
							<option value="9">9 – Jõgeva- ja Tartumaa (v.a Tartu linn)</option>
							<option value="10">10 – Tartu linn</option>
							<option value="11">11 – Võru-, Valga- ja Põlvamaa</option>
							<option value="12">12 – Pärnumaa</option>
						</select><br> 
						<label>E-mail:</label><input type="text" name="email"><br>
						<label>Isikukood:</label><input type="text" name="secnr"><br>
					</div><!-- my_data_block -->
				</div><!-- my_data -->
				<div id="votedfor">
					<h4>Sinu hääl</h4>
					<p><b>Kandidaat:</b> <a href="javascript:void(0);">Artur Käpp</a><a href="javascript:void(0);"><img src="./img/cross_remove.png"></a>
					</p>
				</div>
				<div id="mystatus">
					<h4>Kandidatuur</h4>
					<table>
						<tr><td width="100"><b>Staatus</b></td><td width="150">Kandideerinud</td></tr>
						<tr><td><b>Erakond</b></td><td>Üksikkandidaat</td></tr>
						<tr><td><b>Valimispiirkond</b></td><td>1. Tallinna Haabersti, Põhja-Tallinna ja Kristiine linnaosa</td></tr>
						<tr><td><b>Häälte arv</b></td><td>2324</td></tr>
					</table>
				</div>
				<a href="javascript:void(0);" id="savebutton" class="button">Salvesta!</a>
			</div><!-- content -->
		</div><!-- profilepage -->
		
		<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="/scripts.jsp" />
</body>
</html>