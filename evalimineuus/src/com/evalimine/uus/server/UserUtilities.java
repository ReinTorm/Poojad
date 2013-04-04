package com.evalimine.uus.server;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;

public class UserUtilities extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2116782260926435190L;

	public static boolean loggedIn(HttpServletRequest req){
		return req.getSession(true).getAttribute("google_id") != null;
	}
}
