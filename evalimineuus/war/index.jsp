<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<head>
	<meta charset="utf-8">
	<title>eValimine</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body id="votepagebody">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>

		<div id="votepage" class="tab">
			<aside>
				<h4>Hääletamine</h4>
				<p>Hääletamine läbi eValimiste rakenduse on ülimalt lihtne!<br/><br/>
					Selleks et anda hääl kasutage meie kasutajasõbraliku otsingut ning peale sobiva kandidaadi leidmist vajutage palun "Hääleta".<br/><br/>
					Kui kõik läks edukalt, siis kuvatakse teile kohane teade.
				</p>
			</aside>
			<div id="content">
				<h4 class="content_heading">Kandidaadid</h4>
				<ul id="advanced_search">
					<li>
						<h5>Valimisringkond:</h5>
						<ul id="radioboxes" class="custom-radiobox">
						<li><label><input type="radio" name="ringkond" value="0" checked="checked"/><span>Kõik</span></label></li>
						<% java.sql.Connection c = null;
							try {
								java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
								c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
								java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.constituency");
								while (rs.next()){
									String CID = rs.getString("CID");
							        String cname = rs.getString("ConstituencyName");
									out.println("<li><label title= '" + cname + "'><input type='radio' name='ringkond' value='" + CID + "'/><span>" + CID + " - " + cname + "</span></label></li>");								
							    }
							} catch (java.sql.SQLException e) {
								e.printStackTrace();
							} %>
						</ul>
					</li>

					<li>
						<h5>Erakond:</h5>
						<ul id="checkboxes" class="custom-checkbox">
						<% 
							try {
								java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.party");
								while (rs.next()){
									int partyID = rs.getInt("PartyID");
							        String pname = rs.getString("PartyName");
									out.println("<li><label><input type='checkbox' value='"+partyID+"' checked='checked'/><span>"+pname+"</span></label></li>");
							    }
							} catch (java.sql.SQLException e) {
								e.printStackTrace();
								out.println(e.toString());
							} %>
						</ul>
					</li>
					<li>
						<h5>Kandidaadid:</h5>
						<div id="results_wrapper">
						<input type="text" id="resultSearch">
							<div id="noResultsFound">
								<p>
									Ei leidnud midagi!<br/>
									Muuda otsingu kriteeriume!<br/><br/> 
									<a href="javascript:void(0);" onClick="javascript:clearAllFilters();"><u>Otsi kõikide kandidaatide hulgast</u></a>
								</p>
							</div>
							<ul id="results">
							</ul>
						</div>
					</li>
					<li>
						<div id="profile">
							<img src="img/avatar.jpg" id="avatar" alt="avatar">

							<h1><span id="name"></span></h1>
							<p><b>Sünniaeg: </b><span id="birthdate"></span></p>
							<p><b>Partei: </b><span id="party"></span></p>
							<p><b>Valimisringkond: </b><span id="constituency"></span></p>
							<p><b>Facebook: </b><span id="facebook"></span></p>
							<p><b>Skype: </b> <span id="skype"></span></p>
							<p><b>Muu: </b> <span id="other"></span></p>
							<h4>Kokkuvõte</h4>
							<p><span id="shortText"></span></p>
							<h4>Minust</h4>
							<p><span id="longText"></span></p>					
						</div> 
					</li>
				</ul>
				<div id="buttonLoader">
					<a href="javascript:void(0);" onClick="javascript:void(0);" id="votebutton" class="button">Hääleta!</a>
				</div>
			</div><!-- content -->
		</div><!-- votepage -->

		<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script>window.jQuery || document.write('<script src="js/jquery-1.9.1.min.js"><\/script>')</script>
<script type="text/javascript" src='/js/json2.js'></script>
<script type="text/javascript" src='/js/index.js'></script>
</body>
</html>