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

public class AdminTable extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4888888548156347523L;

	java.sql.Connection c = null;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		Object obj=JSONValue.parse(req.getReader());

		JSONArray array=(JSONArray) obj;
		JSONObject requestParams = (JSONObject) array.get(0);
		
		String currentSelect = requestParams.get("current")==null ? "PENDING" : (String) requestParams.get("current");
		
		long startIndex = requestParams.get("start")==null ? 0L : (long) requestParams.get("start");
		long endIndex = requestParams.get("end")==null ? 100L : (long) requestParams.get("end");
		String query = "Select PID, Firstname,Lastname,Isikukood,Aadress,ShortInfo,LongInfo,CID,PartyId,ApplyState from db.user LIMIT " + startIndex +", "+ endIndex;
		System.out.println(currentSelect);
		if(!currentSelect.equalsIgnoreCase("ALL")){
			query = "Select PID, Firstname,Lastname,Isikukood,Aadress,ShortInfo,LongInfo,CID,PartyId,ApplyState from db.user WHERE db.user.ApplyState='"+ currentSelect +"' LIMIT " + startIndex +", "+ endIndex;
		}
		
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