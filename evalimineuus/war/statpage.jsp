<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine - Statistika</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body id="statpage">
	<div id="wrapper">
		<jsp:include page="header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="statpage"class="tab">
			<aside>
				<h4>Vaata statistikat</h4>
				<a id="kanditstat" class="statbutton">Kandidaatide lõikes</a> 
				<a id="areastat" class="statbutton">Piirkondade lõikes</a> 
				<a id="parteistat" class="statbutton">Parteide lõikes</a> 
				<a id="riikstat" class="statbutton">Riigi lõikes</a>
			</aside>
			<div id="content">
	
				<div id="kanditstat-content" class="stat-content">
					<h4 class="content_heading">Kandidaatide lõikes</h4>
					<table id="stattable" class="sortable">
						<thead>
							<tr><th class="alphabetic">Koht</th><th class="alphabetic">Number</th><th class="alphabetic">Nimi</th><th class="alphabetic">Partei</th><th class="alphabetic">Piirkond</th><th class="alphabetic">Hääli</th></tr>
						</thead>
						<tbody>
							<tr><td>1</td><td>123</td><td>Jaanus Lehmamees</td><td>Reformierakond</td><td>Tartumaa</td><td>20000</td></tr>
							<tr><td>2</td><td>4535</td><td>Taavi Tont</td><td>-</td><td>Tallinn</td><td>18000</td></tr>
							<tr><td>3</td><td>456</td><td>Ants Auto</td><td>Keskerakond</td><td>Võru</td><td>14554</td></tr>
							<tr><td>4</td><td>643</td><td>Liina Lähtme</td><td>Isamaa ja Respublica</td><td>Narva</td><td>12000</td></tr>
							<tr><td>5</td><td>12</td><td>Keio Kuusk</td><td>Kristlikud Demokraadid</td><td>Tartu</td><td>8900</td></tr>
							<tr><td>6</td><td>767</td><td>Koit Auto</td><td>Keskerakond</td><td>Viljandi</td><td>4544</td></tr>
							<tr><td>3</td><td>456</td><td>Ants Auto</td><td>Keskerakond</td><td>Võru</td><td>2324</td></tr>
						<tbody>
					</table>
					<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
				</div><!-- kanditstat-content -->
	
				<div id="areastat-content" class="stat-content">
					<h4 class="content_heading">Piirkondade lõikes</h4>
					Valimisringkond: 
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
	
					<table id="stattable" class="sortable">
						<thead>
							<tr><th class="alphabetic">Koht</th><th class="alphabetic">Partei</th><th class="alphabetic">Populaarseim kandidaat</th><th class="alphabetic">Hääli</th></tr>
						</thead>
						<tbody>
							<tr><td>1</td><td>Partei1</td><td>Orbit Üks</td><td>9999</td></tr>
							<tr><td>2</td><td>Partei2</td><td>Orbit Kaks</td><td>9998</td></tr>
							<tr><td>3</td><td>Partei3</td><td>Orbit Kolm</td><td>9997</td></tr>
							<tr><td>4</td><td>Partei4</td><td>Orbit Neli</td><td>9996</td></tr>
							<tr><td>5</td><td>Partei5</td><td>Orbit Viis</td><td>9995</td></tr>
							<tr><td>6</td><td>Partei6</td><td>Orbit Kuus</td><td>9994</td></tr>
							<tr><td>7</td><td>Partei7</td><td>Orbit Seitse</td><td>9993</td></tr>
							<tr><td>8</td><td>Partei8</td><td>Orbit Kaheksa</td><td>9992</td></tr>
							<tr><td>9</td><td>Partei9</td><td>Orbit Üheksa</td><td>9991</td></tr>
							<tr><td>10</td><td>Partei10</td><td>Orbit Kümme</td><td>9990</td></tr>
						</tbody>	
					</table>
					<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
				</div><!--areastat-content-->
	
				<div id="parteistat-content" class="stat-content">
					<h4 class="content_heading">Parteide lõikes</h4>
					<img src="./img/statistika.png" alt="Pie chart" id="statimg">
					<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
				</div><!-- parteistat-content -->
	
				<div id="riikstat-content" class="stat-content">
					<h4 class="content_heading">Riigi lõikes</h4>
					<img src="./img/Eesti_maakonnad.png" alt="Eesti maakonnad" id="statimg" width="600" width="500"> 
					<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
				</div><!-- riikstat-content -->
	
			</div><!-- content -->
		</div><!-- statpage -->
	<jsp:include page="footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="scripts.jsp" />
</body>
</html>