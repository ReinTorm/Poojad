<%@ page language="java" contentType="text/html; charset=utf-8"%>
<div class="stat-content">
	<h4 class="content_heading">Kandidaatide lõikes</h4>
	<table class='stattable sortable'>
		<thead>
			<tr>
				<th class='sorttable_numeric'>#</th>
				<th class='sorttable_numeric'>Number</th>
				<th class='alphabetic'>Nimi</th>
				<th class='alphabetic'>Partei</th>
				<th class='alphabetic'>Piirkond</th>
				<th class='sorttable_numeric'>Hääli</th>
			</tr>
		</thead>
		<tbody id="candidateTable">
		</tbody>
	</table>
	<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
</div><!-- candidate-content -->