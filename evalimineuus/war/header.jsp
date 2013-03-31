<%@page import="com.evalimine.uus.server.GoogleAuthHelper"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<header>
	<p id="notice">Antud rakendus ei ole mõeldud kasutamiseks reaalsetel valimistel!</p>
	<a href="/" id="logo"></a>
	  	<% 
		Object userName = request.getSession(true).getAttribute("User");
		if (userName!=null){ %>
			<p id="username">Tere, <% out.print(userName); %></p>
	<%  }else{ %>
			<p id="username">&#8194;</p>
	<% 	}; %>
	<nav >
		<ul>
			<li><a href="/" id="votenav">Hääleta</a></li>
			<li><a href="/statistics" id="statnav">Statistika</a></li>
			<%if (request.getSession(true).getAttribute("User")!=null){ %>
				<li><a href="/apply" id="applynav">Kandideeri</a></li>
				<li><a href="/profile" id="profilenav">Profiil</a></li>
				<li><a href="/logout">Logi välja</a></li>
			<%}else{ %>
				<li><a href="/login" id="loginnav">Logi sisse</a></li>
			<%} %>
		</ul>
	</nav>
</header>