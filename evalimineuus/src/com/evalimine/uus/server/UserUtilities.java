package com.evalimine.uus.server;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

import com.google.appengine.api.rdbms.AppEngineDriver;

public class UserUtilities extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2116782260926435190L;

	public static boolean loggedIn(HttpServletRequest req){
		return req.getSession(true).getAttribute("google_id") != null;
	}
	
	public static boolean isAdmin(HttpServletRequest req){
		String gId = (String) req.getSession(true).getAttribute("google_id");
		if(gId != null){
			java.sql.Connection c = null;
			try {
				java.sql.DriverManager.registerDriver(new AppEngineDriver());
				c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
				java.sql.PreparedStatement stmt = c.prepareStatement("SELECT State FROM db.user WHERE Google_Id=?");
				stmt.setString(1, gId);
				java.sql.ResultSet rs = stmt.executeQuery();
				if(rs.next()){
					String state = rs.getString(1);
					if(state.equalsIgnoreCase("admin")){
						return true;
					}
				}
			} catch (java.sql.SQLException e) {
				e.printStackTrace();
			}
		}
		return false;
	}

}
