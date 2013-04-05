<%@page import="com.evalimine.uus.server.GeneralHelpers"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<div class="stat-content">
	<h4 class="content_heading">Parteide lõikes</h4>

	<p>Otsi: <select id="partyTableOption">
		<%
			java.sql.ResultSet rs = GeneralHelpers.getPartyOptions();

			while (rs.next()) {
				int partyID = rs.getInt("PartyID");
				String pname = rs.getString("PartyName");
				out.println("<option id=" + partyID + ">" + pname + "</option>");
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
		<tbody id="partyTable">
		</tbody>
	</table>
	<a onClick="window.print()" id="printbutton" class="button">Prindi statistika</a>
</div>
<!-- parteistat-content -->