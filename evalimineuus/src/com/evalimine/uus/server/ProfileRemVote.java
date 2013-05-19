package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ProfileRemVote extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6084695710270575110L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Object gId = req.getSession(false).getAttribute("google_id");		
		PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		java.sql.Connection c = null;
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			c.createStatement().executeUpdate("UPDATE db.user SET db.user.Vote='"+ java.sql.Types.NULL +"' WHERE db.user.Google_Id='"+gId+"'");
			out.write("{\"message\" : \"Hääl eemaldatud!\"}");
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}	
	}
}
