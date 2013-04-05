package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class GetTable extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4888888548156347523L;

	java.sql.Connection c = null;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Object obj=JSONValue.parse(req.getReader());
	    
		JSONArray array=(JSONArray) obj;
		  
		JSONObject requestParams = (JSONObject) array.get(0);
		String pageID = requestParams.get("pageID")==null ? "" : (String) requestParams.get("pageID");
		int  currentSelect = requestParams.get("current")==null ? 0 : (int) requestParams.get("current");
		String query = queryBuilder(pageID, currentSelect);	
		
		PrintWriter out = res.getWriter();
		String endJson = "";
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			if(c!=null){
				java.sql.ResultSet rs = c.createStatement().executeQuery(query);
				endJson = ResultSetConverter.convert(rs).toString();
			}
		} catch (java.sql.SQLException | JSONException e) {
			e.printStackTrace();
		}
		out.print(endJson);
	}

	private String queryBuilder(String pageID, int currentSelect) {
		String query = "";
		query = "SELECT @i := @i + 1 AS '#', x.PID, x.Nimi, x.PartyName, x.ConstituencyName, x.Hääli " 
				+ " FROM ( "
				+ "SELECT t1.PID, CONCAT(t1.Firstname, ' ', t1.Lastname) AS Nimi, t1.PartyName, t1.ConstituencyName, COALESCE(t2.Count, 0) AS Hääli "
				+ " FROM ( "
				+ " (SELECT db.user.PID, db.user.Firstname, db.user.Lastname, db.party.PartyName, db.constituency.ConstituencyName " 
				+ " FROM db.user "
				+ " LEFT JOIN db.party ON db.user.PartyId = db.party.PartyID "
				+ " LEFT JOIN db.constituency ON db.user.CID = db.constituency.CID "
				+ " WHERE db.user.PartyId IS NOT NULL "
				+ " AND db.user.CID IS NOT NULL ";
				if (pageID == "candidate") {}
				if (pageID == "partei") {
					query+= " AND db.user.PartyId = " + currentSelect;
				}
				if (pageID == "piirkond") {
					query+= " AND db.user.CID = " + currentSelect;
				}
				query+=	" ) t1 "
				+ " LEFT JOIN "
				+ " (SELECT db.user.Vote, COUNT(*) AS 'Count' " 
				+ " FROM db.user " 
				+ " GROUP BY db.user.Vote "
				+ " ) t2 "
				+ " ON "
				+ " t1.PID = t2.Vote "
				+ " ORDER BY t2.Count DESC) "
				+ " ) x "
				+ " JOIN"
				+ " (SELECT @i:=0) init";
		return query;
	}
}