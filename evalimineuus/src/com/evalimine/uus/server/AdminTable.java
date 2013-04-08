package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;

public class AdminTable extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4888888548156347523L;

	java.sql.Connection c = null;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		String query = "Select * from db.kandidaat";	
		
		PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			if(c!=null){
				java.sql.ResultSet rs = c.createStatement().executeQuery(query);
				out.print(ResultSetConverter.convert(rs).toString());
			}
		} catch (java.sql.SQLException | JSONException e) {
			e.printStackTrace();
		}
	}
}