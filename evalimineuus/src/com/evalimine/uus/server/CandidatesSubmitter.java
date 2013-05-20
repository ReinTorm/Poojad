package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;

public class CandidatesSubmitter  extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = -2143119039414204831L;

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
		
		Object obj=JSONValue.parse(req.getReader());
		JSONObject requestParams = (JSONObject) obj;
		
		String fname = requestParams.get("fname").equals("") ? null : (String) requestParams.get("fname");
		String lname = requestParams.get("lname").equals("") ? null : (String) requestParams.get("lname");
		Long socnumber = requestParams.get("socnumber").equals("") ? null : Long.parseLong((String) requestParams.get("socnumber"));
		String party = (String) requestParams.get("party");
		String constituency = (String) requestParams.get("constituency");
		String address = requestParams.get("address").equals("") ? null : (String) requestParams.get("address");
		Long phone = requestParams.get("phone").equals("") ? null :Long.parseLong((String) requestParams.get("phone"));
		String sInfo = requestParams.get("sinfo").equals("") ? null : (String) requestParams.get("sinfo");
		String lInfo = requestParams.get("linfo").equals("") ? null : (String) requestParams.get("linfo");

        PrintWriter out = res.getWriter();
        res.setContentType("text/html; charset=UTF-8");
		Object gId = (req.getSession(false) == null) ? null : req.getSession(false).getAttribute("google_id");
		if(gId==null){
			res.sendError(333, "Kandideerimiseks peate olema sisselogitud");
		}else if(fname==null || lname==null || socnumber == null || address == null || party == null ){
			res.sendError(666, "Vigane sisend");
		}else{
			java.sql.Connection c = null;
			try {
				java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
				c = java.sql.DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
					
				java.sql.PreparedStatement stmt = c.prepareStatement("select PartyId from db.party where PartyName=?");
				stmt.setString(1, party);
				int partyInt=-1;
				int constituencyInt=-1;
				ResultSet rs = stmt.executeQuery();
				if(!rs.next()){
					res.sendError(327, "Midagi läks valesti!");
					return;
				}else{
					partyInt = rs.getInt(1);
				}
				constituencyInt= Integer.parseInt(constituency.split(" ")[0]);
				if(partyInt==-1 || constituencyInt==-1){
					res.sendError(546, "Midagi läks valesti!");
					return;
				}
				if(fname!=null && lname!=null && socnumber!=null && party!=null && constituency!=null && address!=null && sInfo!=null && lInfo!=null) {
					stmt = c.prepareStatement(
							" UPDATE db.user " +
							" SET db.user.Firstname=?, " +
							" db.user.Lastname=?, " +
							" db.user.Isikukood=?, " +
							" db.user.PartyId=?, " +
							" db.user.CID=?, " +
							" db.user.Aadress=?, " +
							" db.user.ShortInfo=?, " +
							" db.user.LongInfo=?, " +
							" db.user.ApplyState='PENDING' " +
							" WHERE db.user.Google_Id=?");
					stmt.setString(1, fname);
					stmt.setString(2, lname);
					stmt.setLong(3, socnumber == null? java.sql.Types.NULL : socnumber);
					stmt.setInt(4, partyInt);
					stmt.setInt(5, constituencyInt);
					stmt.setString(6, address);
					stmt.setString(7, sInfo);
					stmt.setString(8, lInfo);
					stmt.setString(9, gId.toString());
					stmt.executeUpdate();
				}else{
					res.sendError(9999, "Midagi jäi täitmata?");
					return;
				}
				if(phone!=null){
					stmt = c.prepareStatement("UPDATE db.user SET db.user.Mobiil=? WHERE db.user.Google_Id=?");
					stmt.setLong(1, phone);
					stmt.setString(2, gId.toString());
					stmt.executeUpdate();
				}
				out.write("{\"message\" : \"Avaldus edukalt ülevaatusele saadetud!\"}");
			}catch(SQLException e){
				e.printStackTrace();
				res.sendError(999, "Midagi läks valesti!");
				return;
			}
		}
		
	}
}
