<%@ page language="java" contentType="text/html; charset=utf-8"%>
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