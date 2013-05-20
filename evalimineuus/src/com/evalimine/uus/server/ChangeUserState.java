package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class ChangeUserState extends HttpServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		Object obj=JSONValue.parse(req.getReader());

		JSONArray array=(JSONArray) obj;
		JSONObject requestParams = (JSONObject) array.get(0);
		
		String userId = requestParams.get("uId")==null ? null : (String) requestParams.get("uId");
		String newState = requestParams.get("nState")==null ? null : (String) requestParams.get("nState");
				
        PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		if(userId!=null && newState!=null){
			java.sql.Connection c = null;
			try {
				java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
				c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
					
				java.sql.PreparedStatement stmt = c.prepareStatement("UPDATE db.user SET db.user.ApplyState=? WHERE db.user.PID=?");
				stmt.setString(1, newState);
				stmt.setString(2, userId);
				int updatedRows = stmt.executeUpdate();
				out.write("{\"message\" : \"Uuendatud ridade arv: " + updatedRows + "\"}");
			}catch(SQLException e){
				res.sendError(862, e.toString());
			}
		}else{
			res.sendError(2314, "Mingi väärtus oli NULL!");
		}
	}
}
