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
							<li><label><input type="radio" name="ringkond" value="1"/><span>1 Tallinn</span></label></li>
							<li><label><input type="radio" name="ringkond" value="2"/><span>2</span></label></li>
							<li><label><input type="radio" name="ringkond" value="3"/><span>3</span></label></li>
							<li><label><input type="radio" name="ringkond" value="4"/><span>4</span></label></li>
							<li><label><input type="radio" name="ringkond" value="5"/><span>5 Saaremaa</span></label></li>
							<li><label><input type="radio" name="ringkond" value="6"/><span>6</span></label></li>
							<li><label><input type="radio" name="ringkond" value="7"/><span>7</span></label></li>
							<li><label><input type="radio" name="ringkond" value="8"/><span>8</span></label></li>
							<li><label><input type="radio" name="ringkond" value="9"/><span>9</span></label></li>
							<li><label><input type="radio" name="ringkond" value="10"/><span>10 Tartu</span></label></li>
							<li><label><input type="radio" name="ringkond" value="11"/><span>11</span></label></li>
							<li><label><input type="radio" name="ringkond" value="12"/><span>12</span></label></li>
						</ul>
					</li>

					<li>
						<h5>Erakond:</h5>
						<ul id="checkboxes" class="custom-checkbox">
							<li><label><input type="checkbox" value="Eesti Iseseisvuspartei" /><span>Eesti Iseseisvuspartei</span></label></li>
							<li><label><input type="checkbox" value="Eesti Keskerakond" /><span>Eesti Keskerakond</span></label></li>
							<li><label><input type="checkbox" value="Eesti Konservatiivne Rahvaerakond" /><span>Eesti Konservatiivne Rahvaerakond</span></label></li>
							<li><label><input type="checkbox" value="Eesti Reformierakond" /><span>Eesti Reformierakond</span></label></li>
							<li><label><input type="checkbox" value="Eesti Vabaduspartei – Põllumeeste Kogu" /><span>Eesti Vabaduspartei – Põllumeeste Kogu</span></label></li>
							<li><label><input type="checkbox" value="Eestimaa Ühendatud Vasakpartei" /><span>Eestimaa Ühendatud Vasakpartei</span></label></li>
							<li><label><input type="checkbox" value="Erakond Eesti Kristlikud Demokraadid" /><span>Erakond Eesti Kristlikud Demokraadid</span></label></li>
							<li><label><input type="checkbox" value="Erakond Eestimaa Rohelised" /><span>Erakond Eestimaa Rohelised</span></label></li>
							<li><label><input type="checkbox" value="Erakond Isamaa ja Res Publica Liit" /><span>Erakond Isamaa ja Res Publica Liit</span></label></li>
							<li><label><input type="checkbox" value="Sotsiaaldemokraatlik Erakond" /><span>Sotsiaaldemokraatlik Erakond</span></label></li>
							<li><label><input type="checkbox" value="Üksikkandidaat" /><span>Üksikkandidaat</span></label></li>
						</ul>
					</li>
					<li>
						<h5>Kandidaadid:</h5>
						<div id="results_wrapper">
							<ul id="results">
							</ul>
						</div>
					</li>
					<li>
						<div id="profile">							
						</div> 
					</li>
				</ul>
				<a href="javascript:void(0);" id="votebutton" class="button">Hääleta!</a>
			</div><!-- content -->
		</div><!-- votepage -->

		<jsp:include page="footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="scripts.jsp" />
</body>
</html>