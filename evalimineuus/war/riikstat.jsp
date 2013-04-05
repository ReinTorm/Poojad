<%@ page language="java" contentType="text/html; charset=utf-8"%>
<div class="stat-content">
	<h4 class="content_heading">Riigi lõikes</h4>
	
	<table class="stattable sortable">
		<thead>
			<tr>
				<th class="sorttable_numeric">#</th>
				<th class="alphabetic">Erakond</th>
				<th class="sorttable_numeric">Hääli</th>
			</tr>
		</thead>
		<tbody id="riikTable">
		</tbody>	
	</table>
	<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
</div><!-- riikstat-content -->