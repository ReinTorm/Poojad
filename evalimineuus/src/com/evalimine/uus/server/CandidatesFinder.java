package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class CandidatesFinder extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4899988548156347523L;

	java.sql.Connection c = null;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		Object obj=JSONValue.parse(req.getReader());
    
		JSONArray array=(JSONArray) obj;
		
		JSONObject requestParams = (JSONObject) array.get(0);
		int radioID = requestParams.get("radio")==null ? 0 : Integer.parseInt((String) requestParams.get("radio"));
		long userID = requestParams.get("userId")==null ? 0 : (long) requestParams.get("userId");
		ArrayList<String> checkboxList =  (ArrayList<String>) requestParams.get("checkboxes");
		
		String query = queryBuilder(radioID, userID, checkboxList);
	
        PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		String endJson = "";
		if(query!=null){
			try {
				java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
				c = java.sql.DriverManager.getConnection("jdbc:google:rdbms:valiminee:evalimine2");
				if(c!=null){
					java.sql.ResultSet rs = c.createStatement().executeQuery(query);
					endJson = ResultSetConverter.convert(rs).toString();
				}
			} catch (java.sql.SQLException | JSONException e) {
				e.printStackTrace();
			}
		}
		out.print(endJson); 
	}

	private String queryBuilder(int radioID, long userID, ArrayList<String> checkboxList) {
		int[] checkID = null;
		String arrayForTheQuery = "(";
		if(checkboxList!=null){
			checkID = new int[checkboxList.size()];
			for(int i = 0; i < checkboxList.size(); i++) {
				checkID[i] = Integer.parseInt(checkboxList.get(i));
				arrayForTheQuery += checkID[i];
				arrayForTheQuery += i<checkID.length-1 ? ", " : ")";
			}
		}

		String query = "SELECT db.user.*, db.party.PartyName, db.constituency.ConstituencyName FROM db.user";
		query+=" LEFT JOIN db.party ON db.user.PartyId = db.party.PartyID ";
		query+=" LEFT JOIN db.constituency ON db.user.CID = db.constituency.CID ";
		if((radioID!=0) || (userID!=0) || checkID!=null && checkID.length>0){
			query+=" WHERE ";
		}
		if (radioID !=0){
			query+=" db.user.CID = " + radioID;
		}
		if(checkID!=null && checkID.length>0){
			if(radioID != 0){
				query+=" AND ";
			}
			query+="db.user.PartyId in " + arrayForTheQuery;
		}
		if(userID!=0){
			if(radioID != 0 || checkID!=null && checkID.length>0){
				query+=" AND ";
			}
			query+="db.user.PID="+userID;
		}
//		System.out.println(query);
		return query;
	}
}
