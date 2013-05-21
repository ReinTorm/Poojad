<%@page import="com.evalimine.uus.server.GoogleAuthHelper, com.evalimine.uus.server.UserUtilities"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<header>
	<p class="notice">Antud rakendus ei ole mõeldud kasutamiseks reaalsetel valimistel!</p>
	<a href="/" id="logo"></a>
	  	<% 
		Object firstName = request.getSession(true).getAttribute("google_firstname");
	  	Object lastName = request.getSession(true).getAttribute("google_lastname");
		if (firstName!=null && lastName!=null){ %>
			<p id="username">Tere, <% out.print(firstName + " " + lastName); %></p>
	<%  }else{ %>
			<p id="username">&#8194;</p>
	<% 	}; %>
	<nav >
		<ul>
			<li><a href="/" id="votenav">Hääleta</a></li>
			<li><a href="/statistics" id="statnav">Statistika</a></li>
			<%if (UserUtilities.loggedIn(request)){ %>
				<li><a href="/apply" id="applynav">Kandideeri</a></li>
				<li><a href="/profile" id="profilenav">Profiil</a></li>
				<% if(UserUtilities.isAdmin(request)){ %>
					<li><a href="/admin" id="adminnav">Admin</a></li>
				<% } %>
				<li><a href="/faq" id="faqnav">KKK</a></li>
				<li><a href="/logout">Logi välja</a></li>
			<%}else{ %>
				<li><a href="/faq" id="faqnav">KKK</a></li>
				<li><a href="/login" id="loginnav">Logi sisse</a></li>
			<%} %>
		</ul>
	</nav>
</header>