<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@page import="com.evalimine.uus.server.UserUtilities"%>
<!DOCTYPE html>
<html manifest="cache.manifest">
<head>
	<meta charset="utf-8">
	<title>eValimine - KKK</title>
	<link rel="stylesheet" href="/css/style.css">
</head>
<body id="faqpagebody">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="KKKpage" class="tab">
			<aside>
				<h4>KKK</h4>
				<ol class="FaqListing">
					<li><a href="#faq1">Kuidas luua kasutaja?</a></li>
					<li><a href="#faq2">Kuidas hääletada?</a></li>
					<li><a href="#faq3">Kuidas leida sobiv kandidaat?</a></li>
					<li><a href="#faq4">Kuidas muuta häält?</a></li>
					<li><a href="#faq5">Kuidas näha kes kandidaatidest juhib praegu?</a></li>
					<li><a href="#faq6">Kuidas saan muuta kandideerimisavaldust?</a></li>
					<li><a href="#faq7">Kuidas tühistada kandideerimisavaldus?</a></li>
				</ol>
				<p>Juhul kui ei leidnud oma küsimusele vastust, siis kontakteerumiseks kasutage palun järgnevat e-maili ning proovime Teie probleemile leida lahenduse.<br>
				<a id="FagEmail" href="mailto:ArturKp+valimine@gmail.com?Subject=3valimine">Saada kiri!</a>
				</p>
			</aside>
			<div id="content">
				<h4 class="content_heading">Korduma kippuvad küsimused</h4>
				<ol class="FaqListing">
					<li><a href="#faq1">Kuidas luua kasutaja?</a></li>
					<li><a href="#faq2">Kuidas hääletada?</a></li>
					<li><a href="#faq3">Kuidas leida sobiv kandidaat?</a></li>
					<li><a href="#faq4">Kuidas muuta häält?</a></li>
					<li><a href="#faq5">Kuidas näha kes kandidaatidest juhib praegu?</a></li>
					<li><a href="#faq6">Kuidas saan muuta kandideerimisavaldust?</a></li>
					<li><a href="#faq7">Kuidas tühistada kandideerimisavaldus?</a></li>
				</ol>
				<a class="faq_question_heading" name="faq1">
				<h4>Kuidas luua kasutaja?</h4></a>
				<p>
				Et häält anda või kandideerida on vaja luua kasutaja. Kasutaja tuleb luua Google keskkonda ning läbi selle on võimalik ka süsteemi sisse logida.
				</p>
				<p><a href="https://accounts.google.com/SignUp?lp=1&hl=et">Uue Google'i konto loomine</a></p>
				
				<a class="faq_question_heading" name="faq2"></a>
				<h4>Kuidas hääletada?</h4>
				<p>Hääletamine on tegevus mis nõuab kasutaja autoriseerimist. Kuidas kasutaja luua võib lugeda <a href="#faq1">siit</a>. 
				Peale kasutaja loomist tuleb "Hääleta" lehel leida sobiv kandidaat ning lehe all ääres on nupp kirjaga "Hääleta".
				</p>
				<p>Eduka hääle andmise korral näete teadet et hääl edukalt antud</p>
				
				<a class="faq_question_heading" name="faq3"></a>
				<h4>Kuidas leida sobiv kandidaat?</h4>
				<p>Sobiva kandidaadi leidmiseks kasutaga pealehel ("Hääleta") asuvaid võimalusi.
				Võimalik on sorteerida välja erakonna ning valimisringkonna järgi kõiki kandideerijaid.
				Kõige parempoolsemas kastis nime peale vajutades näete kasutaja kohta täpsemat informatsiooni.
				Juhul kui leiate lõpuks sobiva kandidaadi, siis on võimalik temale oma hääl anda.</p>
				
				<a class="faq_question_heading" name="faq4"></a>
				<h4>Kuidas muuta häält?</h4>
				<p>Juhul kui on vaja hääl eemaldada, siis seda on võimalik teha enda profiili lehel ("Profiil"). Kus on näha teie hääl ning selle taga punane rist hääle eemaldamiseks</p>
				<p>Juhul kui on vaja ainult häält muuta, siis piisab uue kandidaadida otsimisest ning uuesti hääle andmisest. Sel juhul teavitatakse teid, et hääl edukalt <b>uuendatud</b>.</p>
				
				<a class="faq_question_heading" name="faq5"></a>
				<h4>Kuidas näha kes kandidaatidest juhib praegu?</h4>
				<p>Et näha statistikat kas erakondade või kandidaatide kohta tuleb minna "Statistika" lehele. Külje peal on kuvatud kõik võimalikud valikud.
				<ul class="FaqListing">
					<li><b>Kandidaatide lõikes</b> - Võimalik vaadata kõiki kandidaate. Algselt sorteeritud häälte arvu järgi. Sobiva tulba pealkirja peale vajutades on võimalik ka teisiti sorteerida.</li>
					<li><b>Piirkondade lõikes</b> - Võimaldab valida piirkonna ning näha kõiki selle piirkonna kandidaate. Tulba pealkirjale vajutades on võimalik ka muuta järjestust.</li>
					<li><b>Parteide lõikes</b> - Võimaldab valida partei. Ning on näha järjestatud häälte järgi kõiki selle erakondliku kuuluvusega kandidaate. Tulba pealkirjale vajutades on võimalik ka sorteerida.</li>
					<li><b>Riigi lõikes</b> - Riigi lõikes näitab kõiki erakondi ning neile kokku antud häälte arvu.</li>
					<li><b>Kaart</b> - Visualiseering hetke seisust igas valimisringkonnas. Ringi peale minnes on võimalik näha kes on hetkel juhtivas positsioonis selles piirkonnas.</li>
				</ul>
				</p>

				<a class="faq_question_heading" name="faq6"></a>
				<h4>Kuidas saan muuta kandideerimisavaldust?</h4>
				<p>Juhul kui tekib vajadus muuta enda kandideerimis andmeid. Siis tuleb minna kandideerimise lehele ning esitada uuesti avaldus. Algselt on kõik väljad täidetud hetkeandmetega ning neid muutes ning uuesti avaldust saates, olete edukalt muutnud oma andmeid. Küll aga avaldus läheb uuesti administraatoritele ülevaatuseks ning selle tõttu ei ole mõnda aega võimalik oma häält teile anda.</p>	
				
				<a class="faq_question_heading" name="faq7"></a>
				<h4>Kuidas tühistada kandideerimisavaldus?</h4>
				<p>Kandideerimisavalduse tühistamiseks tuleb minna oma profiili lehele ning sealt on näha oma kandidatuuri all võimalus oma avalduse tühistamiseks.</p>
				<p><b>NB: Kõik kogutud hääled teile tühistatakse!</b></p>	
				<br><br><br>
				<p>Juhul kui Te ei leidnud oma küsimusele eelnevatest vastust, siis kontakteerumiseks kasutage palun järgnevat e-maili ning proovime Teie probleemile peagi leida lahenduse.<br>
				<a id="FagEmail" href="mailto:ArturKp+valimine@gmail.com?Subject=3valimine">Saada kiri!</a>
				</p>				
			</div><!-- content -->
		</div><!-- KKKpage -->
		<jsp:include page="/footer.jsp" />
	</div><!-- wrapper -->
</body>
</html>