package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class Voting extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6084695710270575110L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		Object obj=JSONValue.parse(req.getReader());   
		JSONArray array=(JSONArray) obj;
		JSONObject requestParams = (JSONObject) array.get(0);
		long candidateId = (requestParams.get("vote")==null) ? 0L : (long) requestParams.get("vote");

		if(candidateId==0){
			res.sendError(999, "Bad input");
		}
		Object gId = req.getSession(false).getAttribute("google_id");
		String queryCheck = ("SELECT * FROM db.user WHERE Google_Id=" + gId);
		
		PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		java.sql.Connection c = null;
		try {
			java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
			c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
			java.sql.ResultSet check = c.createStatement().executeQuery(queryCheck);
			if(check.next()){
				if(candidateId!=check.getLong("PID")){
					if(check.getLong("Vote")!=0){
						c.createStatement().executeUpdate("UPDATE db.user SET db.user.Vote='"+candidateId+"' WHERE db.user.Google_Id='"+gId+"'");
						out.write("{\"message\" : \"Hääl edukalt uuendatud!\"}");
					}else{
						c.createStatement().executeUpdate("UPDATE db.user SET db.user.Vote='"+candidateId+"' WHERE db.user.Google_Id='"+gId+"'");
						out.write("{\"message\" : \"Hääl salvestatud!\"}");
					}
				}else{
					out.write("{\"message\" : \"Isseenda poolt ei saa hääletada!\"}");
				}
					
			}else{
				res.sendError(888,"Not logged in");
			}
		} catch (java.sql.SQLException e) {
			e.printStackTrace();
		}	
	}
}
