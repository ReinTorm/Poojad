package com.evalimine.uus.server;

import java.sql.ResultSet;

public class GeneralHelpers {
	
	public static ResultSet getConstituencyOptions(){	
		java.sql.Connection c = null;
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.constituency");
			return rs;
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static ResultSet getPartyOptions(){	
		java.sql.Connection c = null;
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.party");
			return rs;
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
}
