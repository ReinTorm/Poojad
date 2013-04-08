package com.evalimine.uus.server;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.rdbms.AppEngineDriver;

public class DatabaseTest extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
	    String title = "Database Test";
		out.println(ServletUtilities.headWithTitle(title));
		out.println("<body>");
		out.println("<h2 align=center>" + title + "</h2>");
		out.println("<ol>");
		
		Connection c = null;
	    try {
			DriverManager.registerDriver(new AppEngineDriver());
		    c = DriverManager.getConnection("jdbc:google:rdbms://valiminee:evalimine2/db");
		    ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.test");
		    while (rs.next()){
		        String FirstName = rs.getString("FirstName");
		        String LastName = rs.getString("LastName");
				out.println("<li>" + FirstName + " " + LastName + "</li>");
		    }
		} catch (SQLException e) {
			e.printStackTrace();
			out.println(e.toString());
		}
	    
		out.println("</ol>\n</body>\n</html>");

	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
