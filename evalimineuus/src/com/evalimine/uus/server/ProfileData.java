package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

public class ProfileData extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4777777548156347523L;

	java.sql.Connection c = null;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Object gId = req.getSession(false).getAttribute("google_id");
		String query = "SELECT t1.Firstname, t1.Lastname, t1.CID, t1.ConstituencyName, t1.PartyName, t1.Email, t2.VName, t1.ImgUrl, COALESCE(t3.Count, 0) AS VCount, COALESCE(t1.PartyId, 0) AS PartyId " 
				+ " FROM (( "
				+ " (SELECT db.user.PID, db.user.Firstname, db.user.Lastname, db.user.CID, db.constituency.ConstituencyName, db.party.PartyName, db.user.Email, db.user.Vote, db.user.Google_Id, db.user.ImgUrl, db.user.PartyId "
				+ " FROM db.user "
				+ " LEFT JOIN db.party ON db.user.PartyId = db.party.PartyID "
				+ " LEFT JOIN db.constituency ON db.user.CID = db.constituency.CID) t1 "
				+ " LEFT JOIN "
				+ " (SELECT db.user.PID, db.user.Google_Id, CONCAT(db.user.Firstname, ' ', db.user.Lastname) As VName "
				+ " FROM db.user) t2 "
				+ " ON t1.Vote = t2.PID) "
				+ " LEFT JOIN "
				+ " (SELECT db.user.Vote, COUNT(*) AS 'COUNT' "
				+ " FROM db.user "
				+ " GROUP BY db.user.Vote) t3 "
				+ " ON t1.PID = t3.Vote) "
				+ " WHERE t1.Google_Id=" + gId;
		PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
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
	
}
