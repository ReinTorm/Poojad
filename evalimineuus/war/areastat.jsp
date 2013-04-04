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

	<table class="stattable sortable">
		<thead>
			<tr><th class="alphabetic">Koht</th><th class="alphabetic">Partei</th><th class="alphabetic">Populaarseim kandidaat</th><th class="alphabetic">Hääli</th></tr>
		</thead>
		<tbody>
		</tbody>	
	</table>
	<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
</div><!--areastat-content-->