package com.evalimine.uus.server;

public class TableCreator {
	public static String getCanditTable(){
		String result = "<table class='stattable sortable'>\n"
				+ "<thead>\n"
				+ "<tr><th class='alphabetic'>#</th><th class='alphabetic'>Number</th><th class='alphabetic'>Nimi</th><th class='alphabetic'>Partei</th><th class='alphabetic'>Piirkond</th><th class='alphabetic'>Hääli</th></tr>\n"
				+ "</thead>\n"
				+"<tbody>\n";
		
		java.sql.Connection c = null;
		
		String query= "SELECT t1.PID, CONCAT(t1.Firstname, ' ', t1.Lastname) AS Nimi, t1.PartyName, t1.ConstituencyName, COALESCE(t2.Count, 0) AS Hääli"
				 	+ " FROM "
					+ " (SELECT db.user.PID, db.user.Firstname, db.user.Lastname, db.party.PartyName, db.constituency.ConstituencyName "
					+ " FROM db.user "
					+ " LEFT JOIN db.party ON db.user.PartyId = db.party.PartyID " 
					+ " LEFT JOIN db.constituency ON db.user.CID = db.constituency.CID "
					+ " WHERE db.user.PartyId IS NOT NULL "
					+ " AND db.user.CID IS NOT NULL "
				    + " ) t1 "
				    + " LEFT JOIN "
				    + " (SELECT db.user.Vote, COUNT(*) AS 'Count' " 
				    + " FROM db.user "
				    + " GROUP BY db.user.Vote "
				    + " ) t2 "
				    + " ON "
				    + " t1.PID = t2.Vote "
				    + " ORDER BY t2.Count DESC "
				    + " LIMIT 10 ";
		
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms:valiminee:evalimine2");
			java.sql.ResultSet rs = c.createStatement().executeQuery(query);
			int count = 1;
			while(rs.next()){
				result+= "<tr>" +
							"<td>" + count + "</td>" +
							"<td>" + rs.getString(1) + "</td>" +
							"<td>" + rs.getString(2) + "</td>" +
							"<td>" + rs.getString(3) + "</td>" +
							"<td>" + rs.getString(4) + "</td>" +
							"<td>" + rs.getString(5) + "</td>" +
						"</tr>\n";
				count++;
			}	
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		
		result+="</tbody>\n" +
				"</table>";
		
		return result;
	}
}
