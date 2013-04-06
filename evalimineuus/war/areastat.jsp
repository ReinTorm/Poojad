<%@page import="com.evalimine.uus.server.GeneralHelpers"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<div class="stat-content">
	<h4 class="content_heading">Piirkondade lõikes</h4>
	<p>Piirkond: <select id="areaTableOption">
		<%
		java.sql.ResultSet rs = GeneralHelpers.getConstituencyOptions();
		while (rs.next()) {
			int CID = rs.getInt("CID");
			String cname = rs.getString("ConstituencyName");
			out.println("<option id=" + CID + ">" + cname + "</option>");
		}
		%>

	</select></p>

	<table class="stattable sortable">
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
		<tbody id="areaTable">
		</tbody>	
	</table>
	<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
</div><!--areastat-content-->