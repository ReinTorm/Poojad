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
		String birthplace = requestParams.get("pob").equals("") ? null : (String)requestParams.get("pob");
		String education = requestParams.get("education").equals("") ? null : (String) requestParams.get("education");
		String degree = requestParams.get("degree").equals("") ? null : (String) requestParams.get("degree");
		String workplace = requestParams.get("workp").equals("") ? null : (String) requestParams.get("workp");
		String job = requestParams.get("job").equals("") ? null : (String)requestParams.get("job");
		
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
				
				java.sql.PreparedStatement stmt = c.prepareStatement("INSERT INTO db.kandidaat (Firstname, Lastname, Isikukood, PartyName, ConstituencyName, Address, Mobilephone, Birthplace, Education, Degree, Work, Job) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", Statement.RETURN_GENERATED_KEYS);
				stmt.setString(1, fname);
				stmt.setString(2, lname);
				stmt.setLong(3, socnumber == null? java.sql.Types.NULL : socnumber);
				stmt.setString(4, party);
				stmt.setString(5, constituency);
				stmt.setString(6, address);
				stmt.setLong(7, phone == null? java.sql.Types.NULL : phone);
				stmt.setString(8, birthplace);
				stmt.setString(9, education);
				stmt.setString(10, degree);
				stmt.setString(11, workplace);
				stmt.setString(12, job);
				stmt.executeUpdate();

				ResultSet rs = stmt.getGeneratedKeys();
				if(rs.next() && gId!=null){
				   int auto_id = rs.getInt(1);
				   java.sql.PreparedStatement stmt2 = c.prepareStatement("UPDATE db.user SET Avaldus=? WHERE Google_Id=?");
				   stmt2.setInt(1,auto_id);
				   stmt2.setString(2, gId.toString());
				   stmt2.execute();
				}
				out.write("{\"message\" : \"Ankeet edukalt ülevaatusele saadetud!\"}");
			}catch(SQLException e){
				e.printStackTrace();
				res.sendError(999, "Midagi läks valesti!");
				return;
			}
		}
		
	}
}
