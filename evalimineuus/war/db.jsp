<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>Database Test</TITLE>
	<link rel='stylesheet' href='/css/style.css'></HEAD>
</head>
<body>
	<h2 align="center">Database jsp test</h2>
	<ol>
	<% java.sql.Connection c = null;
	try {
		java.sql.DriverManager.registerDriver(new com.google.appengine.api.rdbms.AppEngineDriver());
		c = java.sql.DriverManager.getConnection("jdbc:google:rdbms:valiminee:evalimine2");
		java.sql.ResultSet rs = c.createStatement().executeQuery("SELECT * FROM db.test");
		while (rs.next()){
			String FirstName = rs.getString("FirstName");
	        String LastName = rs.getString("LastName");
			out.println("<li>" + FirstName + " " + LastName + "</li>");
	    }
	} catch (java.sql.SQLException e) {
		e.printStackTrace();
		out.println(e.toString());
	} %>
	</ol>
</body>
</HTML>
