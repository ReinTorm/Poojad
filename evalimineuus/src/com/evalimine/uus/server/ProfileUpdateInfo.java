package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class ProfileUpdateInfo extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6084695713270575110L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		Object obj=JSONValue.parse(req.getReader());   
		JSONArray array=(JSONArray) obj;
		JSONObject requestParams = (JSONObject) array.get(0);
		String fname = (String) requestParams.get("fname");
		String lname = (String) requestParams.get("lname");
		String email = (String) requestParams.get("email");
		String facebook = (String) requestParams.get("face_id");
		String skype = (String) requestParams.get("skype");
		String CID = (String) requestParams.get("const_id");
		
		Object gId = req.getSession(false).getAttribute("google_id");		
		PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		java.sql.Connection c = null;
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			c.createStatement().executeUpdate("UPDATE db.user SET db.user.CID='"+CID+"', db.user.Firstname='"+fname+"', db.user.Lastname='"+lname+"', db.user.Email='"+email+"', db.user.Facebook_Id='"+facebook+"', db.user.Skype='"+skype+"' WHERE db.user.Google_Id='"+gId+"'");
			out.write("{\"message\" : \"Teie informatsioon on uuendatud!\"}");
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}	
	}
}
