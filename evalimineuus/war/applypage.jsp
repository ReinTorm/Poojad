<%@ page language="java" contentType="text/html; charset=utf-8"%><!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>eValimine - Kandideeri</title>
	<link rel="stylesheet" href="css/style.css">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="applypage" class="tab">
			<aside>
				<h4>Kandideeri</h4>
				<p>Kandideerimiseks tuleb esitada kandideerimisdokumendid.<br/><br/> Palun tõmmake enda arvutisse/mobiili kandideerimisavaldus ja kandidaadi ankeet.<br/><br/> 
					Antud dokumendid tuleb ära täita ja digiallkirjastada. Seejärel tuleb dokumendid üles laadida ja ära saata.
				</p>
			</aside>
			<div id="content">
				<h4 class="content_heading">Kandideerimine</h4>

				<h4>Kandideerimisavaldus</h4>
				<div class='popbox' id="kandideerimisavaldus">
					<a class='open' href='javascript:void(0);'><b>Kandideerimisavalduse saad siit!</b></a>
					<div class='box'>
						<form action="/submittedData" method="post" id="subForm">
							<h4>Kandidaadeerimisavaldus</h4>
							<p>Mina, <b>Kalle Blomkvist</b>, soovin kandideerida <input type="text" name="date" placeholder="Kuupäev" /></p>
							<p>toimuvatel Riigikogu valimistel valimisringkonnas nr: <input type="text" name="number" /></p>
							<p> 
								<input type="text" name="partyName" placeholder="Erakonna nimi"/>
								<select><option value="unlisted">Üksikkandidaadina</option><option value="listed">Nimekirjas</option></select>
							</p>
							<h5>Kinnita, et vastan järgmistele Riigikogu valimise seaduses Riigikogu liikme kandidaadile esitatud nõuetele:</h5>
							<p>
								<ul>
									<li>Olen Eesti kodanik</li>
									<li>Olen kandidaatide registreerimise viimaseks päevaks saanud 21-aastaseks</li>
									<li>Mind ei ole valimis]iguse osas tunnistatud teovõimetuks</li>
									<li>Mind ei ole kohtu poolt süüdi mõistetud kuriteos ja ma ei kanna vanlakaristust</li>
									<li>Ma ei ole kaadrikaitseväelane</li>
									<li>Ma ei ole teise erakonna liige *</li>
									<li>Olen registreerimiseks esitatud ainult ühes valimisringkonnas</li>
									<li>Ma ei kandideeri samaaegselt erakonna nimekirjas ja üksikkandidaadina</li>
									<li>Kandideerin ainult ühe erakonna kandidaatide nimekirjas *</li>
								</ul>
							</p>
							<p><small>* - Ei kehti üksikkandidaadi kohta</small></p>
							<a href="javascript:void(0);" onclick="$(this).closest('form').submit();" class="button" id="marginFixer">Laadi alla PDF</a>
							<a href="javascript:void(0);" class="close button">Katkesta</a>
						</form>
					</div>
				</div>
				<p>Digiallkirjastatud kandideerimisavaldus:<br/> 
					<input type="file" name="kandideerimisavaldus">
				</p>

				<h4>Kandidaat</h4>
				<div class='popbox'>
					<a class='open' href='javascript:void(0);'><b>Kandidaadi ankeedi saad siit!</b></a>
					<div class='box'>
						<form action="/submittedData" method="POST" id="candidateForm">
							<h4>Kandidaadi ankeet</h4>
							<p>* märgistatud väljad on kohustuslikud</p>
							<input type="text" name="fname" title="Eesnimi" placeholder="Eesnimi *" />
							<input type="text" name="lname" placeholder="Perekonnanimi *" />
							<input type="text" name="socnumber" placeholder="Isikukood *" />
							<input type="text" name="party" placeholder="Erakondlik kuuluvus *" />
							<input type="text" name="address" placeholder="Elukoha aadress *" />
							<input type="text" name="phone" placeholder="Mobiil" />
							<input type="text" name="pob" placeholder="Sünnikoht" />
							<textarea name="education" placeholder="Haridus ja eriala ning õppeasutuse nimetus ja lõpetamise aeg"></textarea>
							<input type="text" name="degree" placeholder="Teaduskraad" />
							<input type="text" name="workp" placeholder="Töökoht" />
							<input type="text" name="job" placeholder="Amet" />
							<a href="javascript:void(0);" onclick="$(this).closest('form').submit();" class="button" id="marginFixer">Laadi alla PDF</a>
							<a href="javascript:void(0);" class="close button">Katkesta</a>
						</form>
					</div>
				</div>
				<p>Digiallkirjastatud kandidaadi ankeet:<br /> 
					<input type="file" name="kandidaadi_ankeet">
				</p>

				<div class="custom-checkbox">
					<h4>Tingimused</h4>
					<p>
						<label><input type="checkbox"><span>Olen tutvunud <b><a href="javascript:void(0);">"kandideerimise tingimustega"</a></b></span></label>.
					</p>
				</div>

				<a href="javascript:void(0);" id="candidatebutton" class="button">Kandideeri!</a>
			</div><!--content-->
		</div><!--applypage-->

		<jsp:include page="footer.jsp" />
	</div><!-- wrapper -->
	<jsp:include page="scripts.jsp" />
</body>
</html>