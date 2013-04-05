<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine - Statistika</title>
	<link rel="stylesheet" href="/css/style.css">
</head>
<body id="statpage">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="statpage"class="tab">
			<aside>
				<h4>Vaata statistikat</h4>
				<a href="/statistics/kandidaat" class="statbutton">Kandidaatide lõikes</a> 
				<a href="/statistics/piirkond" class="statbutton">Piirkondade lõikes</a> 
				<a href="/statistics/partei" class="statbutton">Parteide lõikes</a> 
				<a href="/statistics/riik" class="statbutton">Riigi lõikes</a>
			</aside>
			<div id="content">
				<% 
				if(getServletConfig().getInitParameter("subpage")!=null) {
					String subpage="/" + getServletConfig().getInitParameter("subpage") + ".jsp"; %>
					<jsp:include page="<%=subpage%>"/><%
				} 
				
				
				%> 
			</div><!-- content -->
		</div><!-- statpage -->
	<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="/js/sorttable.js"></script>
<script type="text/javascript" src='/js/stat.js'></script>
</body>
</html>