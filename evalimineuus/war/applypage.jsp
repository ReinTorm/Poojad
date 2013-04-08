<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page import="com.evalimine.uus.server.UserUtilities"%>
<%
	if (!UserUtilities.loggedIn(request))
		response.sendRedirect("/login");
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>eValimine - Kandideeri</title>
<link rel="stylesheet" href="/css/style.css">
<link rel="stylesheet" href="/css/jquery.ketchup.css">
</head>
<body id="applypage">
	<div id="wrapper">
		<jsp:include page="/header.jsp" />
		<canvas id="highlight"></canvas>
		<div id="applypage" class="tab">
			<aside>
				<h4>Kandideeri</h4>
				<p>
					Kandideerimiseks tuleb esitada kandideerimisdokumendid.<br /> <br /> Palun tõmmake enda arvutisse/mobiili kandideerimisavaldus ja kandidaadi ankeet.<br /> <br /> Antud dokumendid tuleb ära
					täita ja digiallkirjastada. Seejärel tuleb dokumendid üles laadida ja ära saata.
				</p>
			</aside>
			<div id="content">
				<h4 class="content_heading">Kandideerimine</h4>
				<p>Kandideerimiseks peate täitma järgmise avalduse ning ootama kuni teie avaldus üle vaadatakse. Juhul kui avaldus on korras, siis lisatakse teid koheselt valimisnimerkirja ning oletegi kandidaat. Vastasel juhul leiate oma profiili alt teate, et teie avaldus lükati tagasi. Sellisel juhul võite uuesti kandideerida.</p>
				<div class='popbox'>
					<a class='open' href='javascript:void(0);' id="candidateFormLink"><b>Kandidaadi ankeet täida ära siin!</b></a>
					<div class='box'>
						<form id="candidateForm">
							<h4>Kandidaadi ankeet</h4>
							<p>* märgistatud väljad on kohustuslikud</p>
							<ul>
								<li><input type="text" data-validate="validate(required, name, minlength(3))" name="fname" title="Eesnimi" placeholder="Eesnimi *" /></li>
								<li><input type="text" data-validate="validate(required, name, minlength(3))" name="lname" placeholder="Perekonnanimi *" /></li>
								<li><input type="text" data-validate="validate(required, digits, minlength(11))" name="socnumber" placeholder="Isikukood *" /></li>
								<li><select name="party">
									<option id="0" disabled="disabled" selected="selected">Erakondlik kuuluvus *</option>
									<% 	java.sql.ResultSet rs;
										rs = com.evalimine.uus.server.GeneralHelpers.getPartyOptions();
										while (rs.next()) {
											int partyID = rs.getInt("PartyID");
											String pname = rs.getString("PartyName");
											out.println("<option id=" + partyID + ">" + pname + "</option>");
										} %>
								</select></li>
								<li><select name="constituency">
									<option id="0" disabled="disabled" selected="selected">Vali valimisringkond *</option>
									<% 	rs = com.evalimine.uus.server.GeneralHelpers.getConstituencyOptions();
										while (rs.next()) {
											int cID = rs.getInt("CID");
											String cname = rs.getString("ConstituencyName");
											out.println("<option id=" + cID + ">" +cID + " - " + cname + "</option>");
										} %>
								</select></li>
								<li><input type="text" data-validate="validate(required)" name="address" placeholder="Elukoha aadress *" /></li>
								<li><input type="text" data-validate="validate(digits, minlength(5))" name="phone" placeholder="Mobiil" /></li>
								<li><input type="text" name="pob" placeholder="Sünnikoht" /></li>
								<li><textarea name="education" placeholder="Haridus ja eriala ning õppeasutuse nimetus ja lõpetamise aeg"></textarea></li>
								<li><input type="text" name="degree" placeholder="Teaduskraad" /></li>
								<li><input type="text" name="workp" placeholder="Töökoht" /></li>
								<li><input type="text" name="job" placeholder="Amet" /></li>
							</ul>
							<a href="javascript:void(0);"  class="button" id="marginFixer">Valmis</a> <a href="javascript:void(0);" id="formClean" class="close button">Tühista</a>
						</form>
					</div>
				</div>

				<h4 class="content_heading">Tingimused</h4>
				<div id="termsAndConditions">
					<p>
						<strong>Kinnita, et vastan järgmistele Riigikogu valimise seaduses Riigikogu liikme kandidaadile esitatud nõuetele:</strong>
					</p>
					<p>
					<ul>
						<li>Olen Eesti kodanik</li>
						<li>Olen kandidaatide registreerimise viimaseks päevaks saanud 21-aastaseks</li>
						<li>Mind ei ole valimisõiguse osas tunnistatud teovõimetuks</li>
						<li>Mind ei ole kohtu poolt süüdi mõistetud kuriteos ja ma ei kanna vanlakaristust</li>
						<li>Ma ei ole kaadrikaitseväelane</li>
						<li>Ma ei ole teise erakonna liige *</li>
						<li>Olen registreerimiseks esitatud ainult ühes valimisringkonnas</li>
						<li>Ma ei kandideeri samaaegselt erakonna nimekirjas ja üksikkandidaadina</li>
						<li>Kandideerin ainult ühe erakonna kandidaatide nimekirjas *</li>
					</ul>
					</p>
					<p>
						<small>* - Ei kehti üksikkandidaadi kohta</small>
					</p>

					<h1>Riigikogu valimise seadus</h1>
					<h2 class="level2">
						<span>1. peatükk </span>ÜLDSÄTTED<a name="ptk1"> </a>
					</h2>
					<h3>
						<strong>§ 1.</strong><a name="para1"> </a>Valimissüsteemi alused
					</h3>
					<p>
						<a name="lg1"> </a>(1) Riigikogul on 101 liiget.
					</p>
					<p>
						<a name="lg2"> </a>(2) Riigikogu liikmete valimised on vabad, üldised, ühetaolised ja otsesed. Hääletamine on salajane.
					</p>
					<p>
						<a name="lg3"> </a>(3) Igal valijal on üks hääl.
					</p>
					<p>
						<a name="lg4"> </a>(4) Valimistulemused tehakse kindlaks proportsionaalsuse põhimõtte alusel.
					</p>
					<h3>
						<strong>§ 2.</strong><a name="para2"> </a>Korraliste valimiste toimumise aeg
					</h3>
					<p>
						<a name="lg5"> </a>(1) Riigikogu korralised valimised toimuvad märtsikuu esimesel pühapäeval neljandal aastal, mis järgneb Riigikogu eelmiste valimiste aastale.
					</p>
					<p>
						<a name="lg6"> </a>(2) Riigikogu korralised valimised kuulutab välja Vabariigi President oma otsusega Eesti Vabariigi põhiseaduse § 78 punkti 3 alusel vähemalt kolm kuud enne valimispäeva.
					</p>
					<h3>
						<strong>§ 3.</strong><a name="para3"> </a>Erakorraliste valimiste toimumise alused ja aeg
					</h3>
					<p>
						<a name="lg7"> </a>(1) Riigikogu erakorralised valimised kuulutab välja Vabariigi President oma otsusega Eesti Vabariigi põhiseaduse § 78 punkti 3 alusel:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>Eesti Vabariigi põhiseaduse §-des 89 ja 119 ettenähtud juhtudel kolme päeva jooksul, arvates väljakuulutamiskohustuse tekkimisest;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>Eesti Vabariigi põhiseaduse § 105 lõikes 4 ettenähtud juhul kolme päeva jooksul, arvates rahvahääletuse tulemuste Riigi Teatajas avaldamisest.
					</p>
					<p>
						<a name="lg8"> </a>(2) Eesti Vabariigi põhiseaduse §-s 97 ettenähtud juhul võib Vabariigi President Vabariigi Valitsuse ettepanekul kuulutada välja Riigikogu erakorralised valimised kolme päeva
						jooksul, arvates Vabariigi Valitsusele või peaministrile umbusalduse avaldamise päevast.
					</p>
					<p>
						<a name="lg9"> </a>(3) Riigikogu erakorralised valimised toimuvad varemalt 20 ja hiljemalt 40 päeva pärast valimiste väljakuulutamist.
					</p>
					<p>
						<a name="lg10"> </a>(4) Riigikogu erakorraliste valimiste päeva määrab Vabariigi President. Erakorraliste valimiste päev on pühapäev.
					</p>
					<h3>
						<strong>§ 4.</strong><a name="para4"> </a>Hääletamis- ja kandideerimisõigus
					</h3>
					<p>
						<a name="lg11"> </a>(1) Hääletamisõigus on Eesti kodanikul, kes on valimispäevaks saanud 18-aastaseks.
					</p>
					<p>
						<a name="lg12"> </a>(2) Hääleõiguslik ei ole isik, kes on valimisõiguse osas teovõimetuks tunnistatud.
					</p>
					<p>
						<a name="lg13"> </a>(3) Hääletamisest ei võta osa isik, kes on kohtu poolt süüdi mõistetud kuriteos ja kannab vanglakaristust.
					</p>
					<p>
						<a name="lg14"> </a>(4) Kandideerimisõigus on Eesti kodanikul, kes kandidaatide registreerimise viimaseks päevaks on saanud 21-aastaseks.
					</p>
					<p>
						<a name="lg15"> </a>(5) Kandideerimisõigust ei ole isikul, kes on valimisõiguse osas teovõimetuks tunnistatud.
					</p>
					<p>
						<a name="lg16"> </a>(6) Riigikogu liikmeks ei või kandideerida isik, kes on kohtu poolt süüdi mõistetud kuriteos ja kannab vanglakaristust.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>2. peatükk </span>AGITATSIOON<a name="ptk2"> </a>
					</h2>
					<h3>
						<strong>§ 5.</strong><a name="para5"> </a>Agitatsiooni piirang
					</h3>
					<p>
						<a name="lg17"> </a>(1) Aktiivse valimisagitatsiooni ajaks loetakse aega alates kandidaatide registreerimise viimasest päevast.
					</p>
					<p>
						<a name="lg18"> </a>(2) Aktiivne valimisagitatsioon on valimispäeval keelatud.
					</p>
					<p>
						<a name="lg19"> </a>(3) Hääletamisruumis ja ruumides, mille kaudu valija siseneb hääletamisruumi, on valimisagitatsioon keelatud.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 5<sup>1</sup>.
						</strong><a name="para6"> </a>Poliitilise välireklaami keeld
					</h3>
					<p>
						<a name="lg20"> </a> Üksikkandidaadi, erakonna või erakonna nimekirjas kandideeriva isiku või nende logo või muu eraldusmärgi või programmi reklaamimine hoonel, rajatisel, ühistranspordivahendi
						või takso sise- või välisküljel ning muu poliitiline välireklaam on aktiivse agitatsiooni ajal keelatud.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/914829">RT I 2005, 37, 281</a> - jõust. 10.07.2005]
						</span>
					</p>
					<h2 class="level2">
						<span>3. peatükk </span>VALIMISRINGKONNAD JA -JAOSKONNAD<a name="ptk3"> </a>
					</h2>
					<h3>
						<strong>§ 6.</strong><a name="para7"> </a>Valimisringkonnad
					</h3>
					<p>
						<a name="lg21"> </a> Riigikogu valimised toimuvad 12-s mitmemandaadilises valimisringkonnas:<br />valimisringkond nr 1 – Tallinna Haabersti, Põhja-Tallinna ja Kristiine linnaosa;<br />valimisringkond
						nr 2 – Tallinna Kesklinna, Lasnamäe ja Pirita linnaosa;<br />valimisringkond nr 3 – Tallinna Mustamäe ja Nõmme linnaosa;<br />valimisringkond nr 4 – Harju- (v.a Tallinn) ja Raplamaa;<br />valimisringkond
						nr 5 – Hiiu-, Lääne- ja Saaremaa;<br />valimisringkond nr 6 – Lääne-Virumaa;<br />valimisringkond nr 7 – Ida-Virumaa;<br />valimisringkond nr 8 – Järva- ja Viljandimaa;<br />valimisringkond nr 9
						– Jõgeva- ja Tartumaa (v.a Tartu linn);<br />valimisringkond nr 10 – Tartu linn;<br />valimisringkond nr 11 – Võru-, Valga- ja Põlvamaa;<br />valimisringkond nr 12 – Pärnumaa.
					</p>
					<h3>
						<strong>§ 7.</strong><a name="para8"> </a>Mandaatide jaotamine valimisringkondade vahel
					</h3>
					<p>
						<a name="lg22"> </a>(1) Vabariigi Valimiskomisjon jaotab oma otsusega mandaadid valimisringkondade vahel järgmiselt:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>valijate koguarv jagatakse arvuga 101;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valimisringkonna valijate arv jagatakse käesoleva lõike punktis 1 nimetatud tehte tulemusena saadud arvuga;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>valimisringkond saab mandaate vastavalt käesoleva lõike punkti 2 kohase tehte tulemusena saadud arvu täisosale;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>käesoleva lõike punkti 3 alusel jaotamata jäänud mandaadid jaotatakse suurimate jääkide põhimõttel, lähtudes käesoleva lõike punktis 2 nimetatud
						tehete tulemusena saadud arvude murdosadest.
					</p>
					<p>
						<a name="lg23"> </a>(2) Valijate arv saadakse valimiste väljakuulutamise kuu esimese kuupäeva seisuga Eesti Rahvastikuregistri (edaspidi <i>rahvastikuregister</i>) andmete põhjal.
					</p>
					<p>
						<a name="lg24"> </a>(3) Regionaalminister esitab Vabariigi Valimiskomisjonile valijate arvu maakondade ja Tallinnas linnaosade kaupa kolme tööpäeva jooksul, arvates valimiste väljakuulutamisest.
					</p>
					<p>
						<a name="lg25"> </a>(4) Vabariigi Valimiskomisjon avalikustab käesoleva paragrahvi lõikes 1 nimetatud otsuse viivitamata.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/731362">RT I 2004, 22, 148</a> - jõust. 08.04.2004]
						</span>
					</p>
					<h3>
						<strong>§ 8.</strong><a name="para9"> </a>Valimisjaoskondade moodustamine
					</h3>
					<p>
						<a name="lg26"> </a>(1) Hääletamise korraldamiseks moodustatakse valimisringkonna territooriumil valimisjaoskonnad.
					</p>
					<p>
						<a name="lg27"> </a>(2) Valimisjaoskonnad moodustab valla- või linnavalitsus oma määrusega, milles määratakse kindlaks:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>valimisjaoskondade numeratsioon;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valimisjaoskondade piirid;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>hääletamisruumide asukohad;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>vähemalt üks valimisjaoskond, kus valijad saavad hääletada väljaspool oma elukohajärgset jaoskonda (§ 41 lg 2);<br />
						<a name=""> </a>5)<span class="tyhik"> </span>valimisjaoskond, kus saavad hääletada valijad, kelle elukoha andmed selles vallas või linnas on rahvastikuregistrisse kantud valla või linna,
						Tallinnas linnaosa täpsusega.
					</p>
					<p>
						<a name="lg28"> </a>(3) Valimisjaoskonnad on alalised. Riigikogu, kohaliku omavalitsuse volikogu ja Euroopa Parlamendi valimistel ning rahvahääletusel korraldatakse hääletamine samades
						valimisjaoskondades, kui valla- või linnavalitsus ei määra teisiti, muutes käesoleva paragrahvi lõikes 2 nimetatud määrust.
					</p>
					<p>
						<a name="lg29"> </a>(4) Käesoleva paragrahvi lõikes 2 nimetatud määrust võib valla- või linnavalitsus muuta hiljemalt 50. päeval enne valimispäeva, erakorralistel juhtudel pärast nimetatud
						tähtpäeva. Muudatustest teavitab valla- või linnavalitsus viivitamata Vabariigi Valimiskomisjoni ja rahvastikuregistri vastutavat töötlejat.
					</p>
					<p>
						<a name="lg30"> </a>(5) Valla- või linnavalitsus avalikustab käesoleva paragrahvi lõikes 2 loetletud andmed enne iga valimisi.
					</p>
					<p>
						<a name="lg31"> </a>(6) Maakonna valimiskomisjon avalikustab käesoleva paragrahvi lõikes 2 loetletud andmed eelhääletamise algusele eelneval nädalal.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>4. peatükk </span>VALIMISKOMISJONID<a name="ptk4"> </a>
					</h2>
					<h3>
						<strong>§ 9.</strong><a name="para10"> </a>Valimiskomisjonide liigid
					</h3>
					<p>
						<a name="lg32"> </a>(1) Riigikogu valimisi korraldavad järgmised valimiskomisjonid:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>Vabariigi Valimiskomisjon;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>maakonna valimiskomisjonid;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>jaoskonnakomisjonid.
					</p>
					<p>
						<a name="lg33"> </a>(2) Tallinnas ja Tartu linnas täidavad maakonna valimiskomisjoni ülesandeid linna valimiskomisjonid.
					</p>
					<h3>
						<strong>§ 10.</strong><a name="para11"> </a>Valimiskomisjoni volituste kestus
					</h3>
					<p>
						<a name="lg34"> </a>(1) Vabariigi Valimiskomisjoni volitused kestavad neli aastat.
					</p>
					<p>
						<a name="lg35"> </a>(2) Maakonna valimiskomisjoni ning Tallinna ja Tartu linna valimiskomisjoni volitused kestavad neli aastat.
					</p>
					<p>
						<a name="lg36"> </a>(3) Jaoskonnakomisjon moodustatakse enne korralist ja erakorralist Riigikogu valimist. Jaoskonnakomisjoni volitused kestavad kuni komisjoni uue koosseisu nimetamiseni.
					</p>
					<h3>
						<strong>§ 11.</strong><a name="para12"> </a>Valimiskomisjoni liige
					</h3>
					<p>
						<a name="lg37"> </a>(1) Valimiskomisjoni liige võib olla isik, kellel on hääletamisõigus käesoleva seaduse § 4 lõigete 1–3 kohaselt ning kelle valimiskomisjoni liikme volitusi ei ole viimase
						viie aasta jooksul Vabariigi Valimiskomisjoni otsusega lõpetatud. Valimiskomisjoni liige peab valdama eesti keelt.
					</p>
					<p>
						<a name="lg38"> </a>(2) Isik võib olla ühe valimiskomisjoni liige.
					</p>
					<p>
						<a name="lg39"> </a>(3) Valimiskomisjoni liikme volitused lõpevad ennetähtaegselt:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kui ilmneb, et tal puudub hääletamisõigus käesoleva seaduse § 4 lõigete 1–3 kohaselt;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>tema tagasiastumisega;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>tema surmaga;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>Vabariigi Valimiskomisjoni otsusega.
					</p>
					<p>
						<a name="lg40"> </a>(4) Isiku võib ennetähtaegselt valimiskomisjoni liikme kohustustest vabastada tema nimetanud ametiisik või organ oma põhistatud otsusega kas oma algatusel või
						valimiskomisjoni ettepanekul.
					</p>
					<p>
						<a name="lg41"> </a>(5) Valimiskomisjoni liikme volitused peatuvad:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>tema asumisega erakonna volitatud esindajaks;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>tema asumisega üksikkandidaadi volitatud esindajaks;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>tema registreerimiseks esitamisega Riigikogu liikmekandidaadiks;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>maakonna valimiskomisjoni või Vabariigi Valimiskomisjoni otsusega.
					</p>
					<p>
						<a name="lg42"> </a>(6) <span class="mm">[Kehtetu – <a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<p>
						<a name="lg43"> </a>(7) Valimiskomisjoni liikme volitused taastuvad:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>käesoleva paragrahvi lõike 5 punktides 1 ja 2 ettenähtud juhtudel – valimistulemuste väljakuulutamise päevast;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>käesoleva paragrahvi lõike 5 punktis 3 ettenähtud juhul – kandidaadi registreerimata jätmisele või kandideerimisest loobumisele järgnevast päevast
						või valimistulemuste väljakuulutamise päevast, kui kandidaat ei osutu valituks.
					</p>
					<p>
						<a name="lg44"> </a>(8) Valimiskomisjoni liige ei või agiteerida erakonna ega kandidaadi poolt ega vastu.
					</p>
					<p>
						<a name="lg45"> </a>(9) Valimiskomisjoni liige on oma ülesandeid täites sõltumatu. Valimiskomisjoni liige juhindub seadusest ja kõrgemalseisva valimiskomisjoni juhistest.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 12.</strong><a name="para13"> </a>Valimiskomisjoni töökorraldus
					</h3>
					<p>
						<a name="lg46"> </a>(1) Valimiskomisjoni töövorm on koosolek, mille kutsub kokku komisjoni esimees või tema äraolekul aseesimees, nende mõlema äraolekul valimiskomisjoni noorim liige.
					</p>
					<p>
						<a name="lg47"> </a>(2) Valimiskomisjon on otsustusvõimeline, kui selle koosolekust võtab osa vähemalt pool komisjoni koosseisust, sealhulgas esimees või aseesimees.
					</p>
					<p>
						<a name="lg48"> </a>(3) Valimiskomisjoni koosolek protokollitakse.
					</p>
					<p>
						<a name="lg49"> </a>(4) Valimiskomisjoni koosolek on avalik. Igaühel on õigus tutvuda valimiskomisjoni otsusega ja komisjoni koosoleku protokolliga.
					</p>
					<p>
						<a name="lg50"> </a>(5) Valimiskomisjon otsustab tema pädevuses olevaid asju poolthäälte enamusega. Komisjoni liikme eriarvamus kantakse koosoleku protokolli.
					</p>
					<p>
						<a name="lg51"> </a>(6) Kui valimiskomisjoni liikme volitused peatuvad või lõpevad, teatab esimees sellest esimesele asendusliikmele, kes asub täitma valimiskomisjoni liikme kohustusi.
					</p>
					<p>
						<a name="lg52"> </a>(7) Valimiskomisjoni otsuse alusel võivad valimistoimingutes osaleda ka asendusliige või muu isik.
					</p>
					<p>
						<a name="lg53"> </a>(8) Kui Vabariigi Valimiskomisjoni liige ei saa komisjoni koosolekust osa võtta, asendab teda asendusliige, kellel on kõik komisjoniliikme õigused ja kohustused, välja
						arvatud esimehe või aseesimehe õigused ja kohustused.
					</p>
					<p>
						<a name="lg54"> </a>(9) Valimiskomisjoni liikme või asendusliikme või komisjoni abistava isiku tööleping või teenistussuhe peatatakse valimiste korraldamise ajaks valimiskomisjoni ettepaneku
						alusel.
					</p>
					<h3>
						<strong>§ 13.</strong><a name="para14"> </a>Valimiskomisjoni abistamine
					</h3>
					<p>
						<a name="lg55"> </a>(1) Riigi- ja kohaliku omavalitsuse organ ning ameti- ja muu asutus on kohustatud oma pädevuse piires valimiskomisjone valimiste korraldamisel abistama.
					</p>
					<p>
						<a name="lg56"> </a>(2) Valimiskomisjonil on õigus pöörduda valimiste korraldamisega seonduvas küsimuses kirjalikult riigi- või kohaliku omavalitsuse organi või ameti- või muu asutuse poole.
						Valimiskomisjoni pöördumisele tuleb vastata kolme tööpäeva jooksul, arvates selle saamisest.
					</p>
					<h3>
						<strong>§ 14.</strong><a name="para15"> </a>Vabariigi Valimiskomisjoni moodustamine
					</h3>
					<p>
						<a name="lg57"> </a>(1) Vabariigi Valimiskomisjoni liikmed on:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>Riigikohtu esimehe nimetatud esimese astme kohtu kohtunik;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>Riigikohtu esimehe nimetatud teise astme kohtu kohtunik;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>õiguskantsleri nimetatud õiguskantsleri nõunik;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>riigikontrolöri nimetatud Riigikontrolli ametnik;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>riigi peaprokuröri nimetatud riigiprokurör;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>Riigikogu Kantselei direktori nimetatud Riigikogu Kantselei ametnik;<br />
						<a name=""> </a>7)<span class="tyhik"> </span>riigisekretäri nimetatud Riigikantselei ametnik.
					</p>
					<p>
						<a name="lg58"> </a>(2) Vabariigi Valimiskomisjoni liikmed nimetatakse hiljemalt kümnendal päeval enne komisjoni volituste lõppemist.
					</p>
					<p>
						<a name="lg59"> </a>(3) Vabariigi Valimiskomisjoni esimehe ja aseesimehe valib valimiskomisjon oma liikmete hulgast komisjoni esimesel koosolekul. Vabariigi Valimiskomisjoni esimese koosoleku
						kutsub kokku eelmise Vabariigi Valimiskomisjoni esimees või aseesimees hiljemalt seitsmendal päeval pärast komisjoni volituste algust.
					</p>
					<p>
						<a name="lg60"> </a>(4) Vabariigi Valimiskomisjoni liikmele nimetab tema ametisse nimetaja asendusliikme.
					</p>
					<p>
						<a name="lg61"> </a>(5) Riigikohtu esimees võib nimetada kohtuniku Vabariigi Valimiskomisjoni liikmeks üksnes nimetatava nõusolekul ning pärast kohtu esimehe arvamuse ärakuulamist.
					</p>
					<p>
						<a name="lg62"> </a>(6) Vabariigi Valimiskomisjoni asjaajamise ja tehnilise teenindamise tagab Riigikogu Kantselei.
					</p>
					<p>
						<a name="lg63"> </a>(7) <a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249501">Vabariigi Valimiskomisjon kehtestab oma töökorra</a> .
					</p>
					<p>
						<a name="lg64"> </a>(8) Vabariigi Valimiskomisjon registreeritakse riigi- ja kohaliku omavalitsuse asutuste riiklikus registris.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 15.</strong><a name="para16"> </a>Vabariigi Valimiskomisjoni pädevus
					</h3>
					<p>
						<a name="lg65"> </a>(1) Vabariigi Valimiskomisjoni ülesanne on kindlaks teha üleriigilised hääletamis- ja valimistulemused, tagada Riigikogu valimiste ühetaolisus, juhendada teisi
						valimiskomisjone ja valvata nende tegevuse järele ning täita muid seadustest tulenevaid ülesandeid.
					</p>
					<p>
						<a name="lg66"> </a>(2) Vabariigi Valimiskomisjonil on õigus:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>peatada või lõpetada jaoskonnakomisjoni või maakonna valimiskomisjoni liikme volitused, kui ta on rikkunud Riigikogu valimise seadust, Vabariigi
						Valimiskomisjoni määrust või kõrgemalseisva valimiskomisjoni juhist;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>teha ettekirjutus maakonna valimiskomisjoni või jaoskonnakomisjoni toimingu või maakonna valimiskomisjoni otsuse puuduste kõrvaldamiseks;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>peatada maakonna valimiskomisjoni või jaoskonnakomisjoni toiming või maakonna valimiskomisjoni otsuse kehtivus;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>tühistada maakonna valimiskomisjoni otsus või tunnistada jaoskonnakomisjoni või maakonna valimiskomisjoni toiming seadusevastaseks ning teha
						jaoskonnakomisjonile või maakonna valimiskomisjonile ettekirjutus seaduserikkumise kõrvaldamiseks;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>tunnistada hääletamistulemused valimisjaoskonnas, valimisringkonnas, maakonnas, Tallinnas, Tartu linnas või riigis kehtetuks ning korraldada
						kordushääletamine, kui seaduserikkumine mõjutas või võis hääletamistulemusi oluliselt mõjutada.
					</p>
					<p>
						<a name="lg67"> </a>(3) Vabariigi Valimiskomisjon annab määrusi käesoleva paragrahvi lõikes 4 ettenähtud juhtudel. Vabariigi Valimiskomisjoni määrusele kirjutab alla esimees. Määrus jõustub
						kolmandal päeval, arvates Riigi Teatajas avaldamisest.
					</p>
					<p>
						<a name="lg68"> </a>(4) Vabariigi Valimiskomisjon kehtestab oma määrusega:<br />
						<a name=""> </a>1)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249501">Vabariigi Valimiskomisjoni töökorra</a> ;<br />
						<a name=""> </a>2)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249486;12752700">kandidaatide registreerimiseks esitamise ja registreerimise korra</a>
						;<br />
						<a name=""> </a>3)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249477">kandidaatide registreerimise avalduse vormi, kandidaatide
							ringkonnanimekirja vormi, kandidaatide üleriigilise nimekirja vormi, kandideerimisavalduse vormi ja kandidaadi ankeedi vormi</a> ;<br />
						<a name=""> </a>4)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249392">valijate nimekirja vormi</a> ;<br />
						<a name=""> </a>5)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249435;12752672">välisriigis hääletamise korra</a> ;<br />
						<a name=""> </a>6)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249333;12752486">hääletamise korraldamise ning hääletamis- ja valimistulemuste
							kindlakstegemise korra</a> ;<br />
						<a name=""> </a>7)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249412">hääletamissedeli vormi</a> ;<br />
						<a name=""> </a>8)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249315">hääletamis- ja valimistulemuste protokollide vormid</a> ;<br />
						<a name=""> </a>9)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249365;12752759">vaatleja staatuse</a> ;<br />
						<a name=""> </a>10)<span class="tyhik"> </span><a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249088;12752481">valimiste korraldamiseks eraldatud raha kasutamise korra</a> ;<br />
						<a name=""> </a>11)<span class="tyhik"> </span><span class="mm">[kehtetu - <a href="https://www.riigiteataja.ee/akt/704851">RT I 2004, 6, 32</a> - jõust. 14.02.2004]
						</span>
					</p>
					<p>
						<a name="lg69"> </a>(5) Vabariigi Valimiskomisjoni pädevuses oleva üksikküsimuse lahendamiseks võtab Vabariigi Valimiskomisjon vastu otsuse. Otsusele kirjutab alla komisjoni esimees. Otsus
						jõustub allakirjutamisega.
					</p>
					<p>
						<a name="lg70"> </a>(6) Vabariigi Valimiskomisjoni määrus, otsus ja juhis on maakonna valimiskomisjonile ning jaoskonnakomisjonile kohustuslikud.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 16.</strong><a name="para17"> </a>Maakonna valimiskomisjoni moodustamine
					</h3>
					<p>
						<a name="lg71"> </a>(1) Maakonna valimiskomisjonil on kuni 13 liiget.
					</p>
					<p>
						<a name="lg72"> </a>(2) Maakonna valimiskomisjoni esimees on maasekretär. Maakonna valimiskomisjoni liikmed nimetab maavanem maasekretäri ettepanekul hiljemalt kümnendal päeval enne komisjoni
						volituste lõppemist. Maavanem nimetab maasekretäri ettepanekul ka kuni neli asendusliiget, kes komisjoni volituste ajal maavanema määratud järjekorras asuvad nende komisjoniliikmete asemele,
						kelle volitused on peatunud või lõppenud.
					</p>
					<p>
						<a name="lg73"> </a>(3) Tallinna ja Tartu linna valimiskomisjoni esimees on linnasekretär. Linna valimiskomisjoni liikmed nimetab linnavolikogu linnasekretäri ettepanekul hiljemalt kümnendal
						päeval enne komisjoni volituste lõppemist. Volikogu nimetab ka kuni neli asendusliiget, kes komisjoni volituste ajal volikogu määratud järjekorras asuvad nende komisjoniliikmete asemele, kelle
						volitused on peatunud või lõppenud.
					</p>
					<p>
						<a name="lg74"> </a>(4) Maakonna valimiskomisjoni aseesimehe valib komisjon oma liikmete hulgast.
					</p>
					<p>
						<a name="lg75"> </a>(5) Maakonna valimiskomisjoni ning Tallinna ja Tartu linna valimiskomisjoni asjaajamise ja tehnilise teenindamise tagavad vastavalt maavalitsus ning Tallinna ja Tartu
						linnavalitsused.
					</p>
					<h3>
						<strong>§ 17.</strong><a name="para18"> </a>Maakonna valimiskomisjoni pädevus
					</h3>
					<p>
						<a name="lg76"> </a>(1) Maakonna valimiskomisjoni ülesanne on kindlaks teha maakonna hääletamistulemused, juhendada jaoskonnakomisjone ja valvata nende tegevuse järele ning täita muid
						käesolevast seadusest tulenevaid ülesandeid.
					</p>
					<p>
						<a name="lg77"> </a>(2) Maakonna valimiskomisjonil on õigus:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>peatada jaoskonnakomisjoni liikme volitused, kui ta on rikkunud Riigikogu valimise seadust, Vabariigi Valimiskomisjoni määrust või kõrgemalseisva
						valimiskomisjoni juhist;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>teha ettepanek Vabariigi Valimiskomisjonile Riigikogu valimise seadust, Vabariigi Valimiskomisjoni määrust või kõrgemalseisva valimiskomisjoni
						juhist rikkunud jaoskonnakomisjoni liikme volituste lõpetamiseks;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>teha ettekirjutus jaoskonnakomisjoni toimingu puuduste kõrvaldamiseks;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>peatada jaoskonnakomisjoni toiming;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>tunnistada jaoskonnakomisjoni toiming seadusevastaseks;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>teha Vabariigi Valimiskomisjonile ettepanek tunnistada hääletamistulemused valimisjaoskonnas kehtetuks ning korraldada valimisjaoskonnas
						kordushääletamine, kui seaduserikkumine mõjutas või võis hääletamistulemusi oluliselt mõjutada.
					</p>
					<p>
						<a name="lg78"> </a>(3) Maakonna valimiskomisjoni pädevuses oleva üksikküsimuse lahendamiseks võtab maakonna valimiskomisjon vastu otsuse. Otsusele kirjutab alla komisjoni esimees. Otsus jõustub
						allakirjutamisega.
					</p>
					<p>
						<a name="lg79"> </a>(4) Maakonna valimiskomisjoni otsus ja juhis on jaoskonnakomisjonile kohustuslikud.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 18.</strong><a name="para19"> </a>Jaoskonnakomisjoni moodustamine
					</h3>
					<p>
						<a name="lg80"> </a>(1) Jaoskonnakomisjonil on kuni üheksa liiget.
					</p>
					<p>
						<a name="lg81"> </a>(2) Kohaliku omavalitsuse volikogu (edaspidi <i>volikogu</i>) nimetab oma otsusega valla- või linnasekretäri ettepanekul ning poliitilise tasakaalustatuse põhimõtet
						arvestades jaoskonnakomisjoni esimehe ja liikmed hiljemalt 20. päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg82"> </a>(3) Pooled jaoskonnakomisjoni liikmetest esitab valla- või linnasekretär ning ülejäänud liikmed esitavad valimistel osalevad erakonnad.
					</p>
					<p>
						<a name="lg83"> </a>(4) Valimistel osalev erakond võib esitada ühe jaoskonnakomisjoni liikmekandidaadi valla- või linnasekretärile hiljemalt 45. päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg84"> </a>(5) Jaoskonnakomisjoni liikmeks nimetamiseks peab olema isiku nõusolek.
					</p>
					<p>
						<a name="lg85"> </a>(6) Kui erakonnad kandidaate ei esita või kui nende esitatud kandidaatide arv on väiksem, kui erakondadel on kohti jaoskonnakomisjonis, nimetab volikogu ülejäänud liikmed
						valla- või linnasekretäri ettepanekul.
					</p>
					<p>
						<a name="lg86"> </a>(7) Kui erakondade esitatud jaoskonnakomisjoni liikmekandidaate on rohkem, kui erakondadel on kohti jaoskonnakomisjonis, nimetatakse kõik ülejäänud kandidaadid
						jaoskonnakomisjoni asendusliikmeteks.
					</p>
					<p>
						<a name="lg87"> </a>(8) Volikogu nimetab valla- või linnasekretäri ettepanekul ning käesoleva paragrahvi lõikes 7 ettenähtut järgides ka vähemalt kaks asendusliiget, kes komisjoni volituste ajal
						volikogu määratud järjekorras asuvad nende komisjoniliikmete asemele, kelle volitused on peatunud või lõppenud.
					</p>
					<p>
						<a name="lg88"> </a>(9) Jaoskonnakomisjoni aseesimehe valib komisjon oma liikmete hulgast.
					</p>
					<p>
						<a name="lg89"> </a>(10) Jaoskonnakomisjoni asjaajamise ja tehnilise teenindamise tagab valla- või linnavalitsus.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 19.</strong><a name="para20"> </a>Jaoskonnakomisjoni pädevus
					</h3>
					<p>
						<a name="lg90"> </a> Jaoskonnakomisjoni ülesanne on korraldada hääletamine ja teha kindlaks hääletamistulemused valimisjaoskonnas ning täita muid käesolevast seadusest tulenevaid ülesandeid.
					</p>
					<h2 class="level2">
						<span>5. peatükk </span>VALIJATE ARVESTUS<a name="ptk5"> </a>
					</h2>
					<h3>
						<strong>§ 20.</strong><a name="para21"> </a>Valijate arvestuse pidamine
					</h3>
					<p>
						<a name="lg91"> </a>(1) Valijate arvestust peetakse rahvastikuregistris.
					</p>
					<p>
						<a name="lg92"> </a>(2) Rahvastikuregistri pidamise korra näeb ette seadus.
					</p>
					<p>
						<a name="lg93"> </a>(3) Valijate arvestust peetakse isiku kohta rahvastikuregistrisse kantud järgmiste andmete alusel:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>sünniaeg;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>isikukood;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>kodakondsuse andmed;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>teovõimetuks tunnistamise andmed;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>elukoha andmed.
					</p>
					<h3>
						<strong>§ 21.</strong><a name="para22"> </a>Valijakaart
					</h3>
					<p>
						<a name="lg94"> </a>(1) Rahvastikuregistri vastutav töötleja korraldab valijakaardi koostamise ja saatmise valijale hiljemalt 20. päeval enne valimispäeva. Valijakaarti ei saadeta valijale,
						kelle elukoha andmed on kohaliku omavalitsuse üksuse algatusel rahvastikuregistrisse kantud valla või linna, Tallinnas linnaosa täpsusega.
					</p>
					<p>
						<a name="lg95"> </a>(2) Valijakaardile kantakse:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>valija ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valija sünniaasta;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>valija elukoha aadress;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>selle valla või linna nimi ning valimisjaoskonna number, mille valijate nimekirja valija kantakse;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>hääletamise aeg ja koht eelhääletamise päevadel ja valimispäeval.
					</p>
					<p>
						<a name="lg96"> </a>(3) Valija, kes 15. päeval enne valimispäeva ei ole valijakaarti saanud või kelle valijakaardile kantud andmetes on vigu, võib pöörduda avaldusega valla- või linnasekretäri
						poole selgituse saamiseks või vigade parandamiseks. Valla- või linnasekretär vaatab avalduse koos valijakaardi koostanud isikuga viivitamata läbi ja vastab avaldusele kirjalikult kolme tööpäeva
						jooksul, arvates avalduse saamise päevast.
					</p>
					<h3>
						<strong>§ 22.</strong><a name="para23"> </a>Valijate nimekiri
					</h3>
					<p>
						<a name="lg97"> </a>(1) Rahvastikuregistri vastutav töötleja korraldab rahvastikuregistri andmete alusel iga valimisjaoskonna valijate nimekirja koostamise ja trükkimise ning selle
						jaoskonnakomisjonidele kättetoimetamise hiljemalt seitsmendaks päevaks enne valimispäeva. Valijate elektroonilised nimekirjad edastatakse Vabariigi Valimiskomisjonile hiljemalt seitsmendaks
						päevaks enne valimispäeva.
					</p>
					<p>
						<a name="lg98"> </a>(2) Valijate nimekirja koostamise aluseks on käesoleva seaduse § 20 lõikes 3 ettenähtud andmed valimispäevale eelneva 30. päeva seisuga. Valijate nimekirja koostamisel
						võetakse arvesse ka käesoleva seaduse § 20 lõike 3 punktides 1–5 nimetatud andmetes pärast valimispäevale eelnevat 30. päeva tehtud muudatused. Elukoha aadressiandmetes pärast valimispäevale
						eelnevat 30. päeva tehtud muudatusi arvesse ei võeta.
					</p>
					<p>
						<a name="lg99"> </a>(3) Valijate nimekirja ei kanta isikut, kelle kohus on karistusregistri andmetel süüdi mõistnud kuriteos ja kes valimispäevale eelneva 30. päeva seisuga kannab valimispäevani
						vanglakaristust.
					</p>
					<p>
						<a name="lg100"> </a>(4) Valija kantakse selle valimisjaoskonna valijate nimekirja, mille territooriumil asub tema rahvastikuregistrisse kantud elukoht 30. päeval enne valimispäeva. Kui valija
						elukoha andmed on kantud rahvastikuregistrisse valla või linna, Tallinnas linnaosa täpsusega, kantakse valija käesoleva seaduse § 8 lõike 2 punkti 5 alusel määratud valimisjaoskonna valijate
						nimekirja.
					</p>
					<p>
						<a name="lg101"> </a>(5) Valijate nimekirja kantakse valija kohta järgmised andmed:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>isikukood;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>elukoha aadress.
					</p>
					<p>
						<a name="lg102"> </a>(6) Valijad kantakse valijate nimekirja nende perekonnanimede tähestikulises järjekorras.
					</p>
					<p>
						<a name="lg103"> </a>(7) Valijate nimekirja koostaja kirjutab valijate nimekirjale alla hiljemalt seitsmendal päeval enne valimispäeva ning jaoskonnakomisjoni esimees valimispäeval pärast
						hääletamise lõppemist. Elektrooniliselt hääletanud valijate nimekirjale kirjutab pärast hääletamise lõppemist alla Vabariigi Valimiskomisjoni esimees.
					</p>
					<p>
						<a name="lg104"> </a>(8) Valijate nimekirju säilitatakse alaliselt arhiivis.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 23.</strong><a name="para24"> </a>Valijate nimekirja avalikkus
					</h3>
					<p>
						<a name="lg105"> </a>(1) Valija võib kontrollida enda kohta valijate nimekirja kantud andmete õigsust.
					</p>
					<p>
						<a name="lg106"> </a>(2) Pärast valimispäeva võivad valijate nimekirjaga põhjendatud huvi korral selleks vajalikus ulatuses tutvuda erakondade volitatud esindajad ning üksikkandidaadid ja nende
						volitatud esindajad, samuti võib neid kasutada teaduslikul eesmärgil.
					</p>
					<h3>
						<strong>§ 24.</strong><a name="para25"> </a>Valijate nimekirja kantud andmete õigsuse kontrollimine ja vea parandamine
					</h3>
					<p>
						<a name="lg107"> </a>(1) Kui valija leiab, et tema kohta valijate nimekirja kantud andmetes on vigu, esitab ta vigade parandamise avalduse jaoskonnakomisjonile, kes edastab selle viivitamata
						valla- või linnasekretärile.
					</p>
					<p>
						<a name="lg108"> </a>(2) Valla- või linnasekretär vaatab avalduse koos valijate nimekirja koostajaga viivitamata läbi, vastab avaldajale ning teavitab avalduse läbivaatamise tulemustest
						jaoskonnakomisjoni.
					</p>
					<p>
						<a name="lg109"> </a>(3) Vea valijate nimekirjas parandab jaoskonnakomisjon valla- või linnasekretäri teatise alusel.
					</p>
					<p>
						<a name="lg110"> </a>(4) Kui jaoskonnakomisjonile esitatud dokumentidest nähtub üheselt, et valijate nimekirjas on viga, võib selle parandada jaoskonnakomisjon ise. Vea parandamisest tuleb
						viivitamata teatada valla- või linnasekretärile.
					</p>
					<h3>
						<strong>§ 25.</strong><a name="para26"> </a>Valijate nimekirjas muudatuste tegemine
					</h3>
					<p>
						<a name="lg111"> </a>(1) Valijate nimekirjas tehakse muudatusi üksnes juhul, kui:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>valijate nimekirja tuleb kanda isik, keda ei ole üheski valijate nimekirjas, kuid kellel käesoleva seaduse kohaselt on õigus hääletamisest osa
						võtta;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valijate nimekirjast tuleb kustutada isik, kellel ei ole õigust hääletamisest osa võtta.
					</p>
					<p>
						<a name="lg112"> </a>(2) Valijate nimekirjas muudatuse tegemiseks esitab isik rahvastikuregistrisse kandmiseks või valijate arvestuse aluseks olevate registriandmete muutmiseks avalduse valla-
						või linnasekretärile. Valla- või linnasekretär vaatab avalduse koos valijate nimekirja koostajaga läbi ja vastab isikule viivitamata.
					</p>
					<p>
						<a name="lg113"> </a>(3) Kui isik kantakse rahvastikuregistrisse või kui muudetakse valijate arvestuse aluseks olevaid registriandmeid selliselt, et see toob kaasa isiku kandmise valijate
						nimekirja, teavitab valla- või linnasekretär sellest jaoskonnakomisjoni viivitamata.
					</p>
					<p>
						<a name="lg114"> </a>(4) Muudatusi valijate nimekirjas teeb jaoskonnakomisjon valla- või linnasekretäri teatise alusel.
					</p>
					<p>
						<a name="lg115"> </a>(5) Kui valla- või linnasekretär jätab käesoleva paragrahvi lõikes 2 nimetatud avalduse rahuldamata, võib avaldaja esitada valla- või linnasekretäri toimingu peale kaebuse
						oma elukohajärgsele halduskohtule. Kaebus esitatakse valla- või linnasekretärile, kes edastab selle 24 tunni jooksul asukohajärgsele halduskohtule koos omapoolsete kirjalike selgitustega.
					</p>
					<p>
						<a name="lg116"> </a>(6) Halduskohus peab kaebuse läbi vaatama ja tegema otsuse kolme tööpäeva jooksul, arvates kaebuse saamise päevast.
					</p>
					<p>
						<a name="lg117"> </a>(7) Halduskohus teeb ühe järgmistest otsustest:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>jätta kaebus rahuldamata;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kaebus rahuldada ning teha valla- või linnasekretärile ettekirjutus korraldada isiku kandmine rahvastikuregistrisse või muuta valijate arvestuse
						aluseks olevaid registriandmeid.
					</p>
					<p>
						<a name="lg118"> </a>(8) Kui halduskohus kaebuse rahuldab, kantakse isik viivitamata rahvastikuregistrisse või muudetakse tema andmeid ning see tehakse jaoskonnakomisjonile viivitamata
						teatavaks.
					</p>
					<h2 class="level2">
						<span>6. peatükk </span>KANDIDAATIDE REGISTREERIMISEKS ESITAMINE JA REGISTREERIMINE<a name="ptk6"> </a>
					</h2>
					<h3>
						<strong>§ 26.</strong><a name="para27"> </a>Erakond
					</h3>
					<p>
						<a name="lg119"> </a>(1) Riigikogu valimistel võib osaleda erakond, kes on kantud mittetulundusühingute ja sihtasutuste registrisse hiljemalt kandidaatide registreerimiseks esitamise viimasel
						päeval.
					</p>
					<p>
						<a name="lg120"> </a>(2) Justiitsminister saadab Vabariigi Valimiskomisjonile erakondade nimekirja kolme tööpäeva jooksul pärast valimiste väljakuulutamist. Nimekirja kantakse erakonnad, kes on
						mittetulundusühingute ja sihtasutuste registris valimiste väljakuulutamise päeval.
					</p>
					<p>
						<a name="lg121"> </a>(3) Erakond osaleb Riigikogu valimistel oma nime all.
					</p>
					<p>
						<a name="lg122"> </a>(4) Erakond esitab kandidaatide registreerimiseks esitamisel Vabariigi Valimiskomisjonile kirjaliku teatise, milles on erakonna volitatud esindajate nimed, isikukoodid,
						aadressid ja sidevahendite numbrid. Teatisele kirjutab alla mittetulundusühingute seaduse (RT I 1996, 42, 811; 1998, 96, 1515; 1999, 10, 155; 23, 355; 67, 658; 2000, 55, 365; 88, 576; 2001, 56,
						336; 93, 565) või erakonna põhikirja kohaselt erakonda esindama õigustatud isik. Kui erakonda ei ole käesoleva paragrahvi lõikes 2 märgitud nimekirjas, esitab erakond tõendi ka selle kohta, et
						ta on kantud mittetulundusühingute ja sihtasutuste registrisse.
					</p>
					<p>
						<a name="lg123"> </a>(5) Erakond võib volitada ennast esindama kuni kaks isikut.
					</p>
					<p>
						<a name="lg124"> </a>(6) Justiitsminister saadab Vabariigi Valimiskomisjonile kahe päeva jooksul pärast kandidaatide registreerimiseks esitamise viimast päeva elektroonilisel kujul
						mittetulundusühingute ja sihtasutuste registrisse kuuluvate erakondade liikmete nimekirjad kandidaatide registreerimiseks esitamise viimase päeva seisuga. Nimekirjades on liikmete nimed,
						isikukoodid ning erakonna liikmeks astumise päev.
					</p>
					<h3>
						<strong>§ 27.</strong><a name="para28"> </a>Üksikkandidaat
					</h3>
					<p>
						<a name="lg125"> </a>(1) Üksikkandidaadina registreerimiseks võib end esitada ning registreerimiseks vajalikke toiminguid teha iga kandideerimisõiguslik isik (§ 4 lg 4–6). Teise isiku võib
						üksikkandidaadina registreerimiseks esitada ning registreerimiseks vajalikke toiminguid teha sellekohase volikirja alusel isik, kellel on hääletamisõigus käesoleva seaduse § 4 lõigete 1–3
						kohaselt.
					</p>
					<p>
						<a name="lg126"> </a>(2) Üksikkandidaadi võib registreerimiseks esitada ainult ühes valimisringkonnas.
					</p>
					<h3>
						<strong>§ 28.</strong><a name="para29"> </a>Kandideerimisdokumendid
					</h3>
					<p>
						<a name="lg127"> </a>(1) Kandideerimisdokumendid on:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kandideerimisavaldus;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kandidaadi ankeet.
					</p>
					<p>
						<a name="lg128"> </a>(2) Kandideerimisavalduses isik:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>väljendab oma soovi kandideerida erakonna nimekirjas või üksikkandidaadina;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kinnitab, et ta vastab käesolevas seaduses Riigikogu liikmekandidaadile esitatud nõuetele.
					</p>
					<p>
						<a name="lg129"> </a>(3) Kandidaadi ankeedis tuleb esitada järgmised andmed:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>isikukood;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>erakondlik kuuluvus;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>elukoha aadress;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>sidevahendite numbrid.
					</p>
					<p>
						<a name="lg130"> </a>(4) Kandidaadi ankeedis võib esitada järgmised andmed:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>sünnikoht;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>haridus ja eriala ning õppeasutuse nimetus ja lõpetamise aeg;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>teaduskraad;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>töökoht;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>amet.
					</p>
					<p>
						<a name="lg131"> </a>(5) Vabariigi Valimiskomisjon ei avalda kandidaadi isikukoodi, elukoha aadressi ega sidevahendite numbreid.
					</p>
					<p>
						<a name="lg132"> </a>(6) Kandidaat kasutab kandideerimisel oma nimena üksnes ees- ja perekonnanime.
					</p>
					<h3>
						<strong>§ 29.</strong><a name="para30"> </a>Kandidaatide nimekiri
					</h3>
					<p>
						<a name="lg133"> </a>(1) Erakond koostab:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kandidaatide ringkonnanimekirjad;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kandidaatide üleriigilise nimekirja.
					</p>
					<p>
						<a name="lg134"> </a>(2) Registreerimiseks esitatud kandidaadid peavad olema käesoleva paragrahvi lõikes 1 nimetatud mõlemas nimekirjas.
					</p>
					<p>
						<a name="lg135"> </a>(3) Kandidaatide arv ringkonnanimekirjas võib ületada mandaatide arvu ringkonnas kuni kahe kandidaadi võrra.
					</p>
					<p>
						<a name="lg136"> </a>(4) Isik võib kandideerida ainult ühes valimisringkonnas. Kandideerimine ei ole seotud isiku elukohajärgse valimisringkonnaga.
					</p>
					<p>
						<a name="lg137"> </a>(5) Isik võib kandideerida ainult ühe erakonna kandidaatide nimekirjas. Kandidaatide nimekirjas ei või kandideerida üksikkandidaadina registreerimiseks esitatud isik või
						teise erakonna liige.
					</p>
					<p>
						<a name="lg138"> </a>(6) Erakond võib ühes valimisringkonnas registreerimiseks esitada ainult ühe kandidaatide nimekirja.
					</p>
					<p>
						<a name="lg139"> </a>(7) Kandidaatide järjestuse nimekirjas määrab erakond.
					</p>
					<p>
						<a name="lg140"> </a>(8) Kandidaatide ringkonnanimekirjale ja kandidaatide üleriigilisele nimekirjale kirjutavad alla erakonna kõik volitatud esindajad.
					</p>
					<h3>
						<strong>§ 30.</strong><a name="para31"> </a>Kandidaatide registreerimiseks esitamine
					</h3>
					<p>
						<a name="lg141"> </a>(1) Kandidaatide registreerimiseks esitamine algab mandaatide jaotamisele järgneval tööpäeval. Erakond võib esitada oma kandidaadid pärast käesoleva seaduse § 26 lõikes 4
						nimetatud teatise esitamist.
					</p>
					<p>
						<a name="lg142"> </a>(2) Kandidaatide registreerimiseks esitamine lõpeb valimispäevale eelneval 45. päeval kell 18.00.
					</p>
					<p>
						<a name="lg143"> </a>(3) Kandidaatide registreerimiseks esitab erakond Vabariigi Valimiskomisjonile:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kandidaatide registreerimise avalduse;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kandidaatide ringkonnanimekirjad;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kandidaatide üleriigilise nimekirja;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>kautsjoni tasumist tõendava maksekorralduse koopia;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>iga kandidaadi kandideerimisdokumendid (§ 28 lg 1).
					</p>
					<p>
						<a name="lg144"> </a>(4) Üksikkandidaat esitab Vabariigi Valimiskomisjonile:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kandidaadi registreerimise avalduse;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kautsjoni tasumist tõendava maksekorralduse koopia;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kandideerimisdokumendid (§ 28 lg 1).
					</p>
					<p>
						<a name="lg145"> </a>(5) Erakond või üksikkandidaat kannab enne kandidaatide registreerimiseks esitamist Vabariigi Valimiskomisjoni arvele kautsjonina summa, mille suurus on valimiste
						väljakuulutamise aastal Vabariigi Valitsuse kehtestatud kuupalga kaks alammäära iga registreerimiseks esitatud isiku kohta.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 31.</strong><a name="para32"> </a>Dokumentide vastuvõtmine ja tagastamine
					</h3>
					<p>
						<a name="lg146"> </a>(1) Vabariigi Valimiskomisjon peab kandidaatide registreerimiseks esitamise kohta arvestust.
					</p>
					<p>
						<a name="lg147"> </a>(2) Kandidaatide registreerimise dokumendid annab üle erakonna volitatud esindaja. Üksikkandidaadi registreerimise dokumendid annab üle üksikkandidaat või tema volitatud
						esindaja.
					</p>
					<p>
						<a name="lg148"> </a>(3) Kui Vabariigi Valimiskomisjonile ei ole esitatud kõiki nõutavaid dokumente, esitatud dokumentides on vigu, neis on andmeid puudu või nad ei ole Vabariigi
						Valimiskomisjoni kehtestatud vormi kohased, teeb dokumentide vastuvõtja dokumentide esitajale ettepaneku esitada nõutavad dokumendid või andmed või vormikohased dokumendid või parandada vead.
						Kõik esitatud dokumendid tagastatakse.
					</p>
					<p>
						<a name="lg149"> </a>(4) Kui erakond või üksikkandidaat soovib kandidaatide registreerimise dokumentides teha muudatusi, tagastab Vabariigi Valimiskomisjon kõik esitatud dokumendid ning nende
						uuesti esitamisel loetakse dokumendid esmakordselt esitatuks.
					</p>
					<p>
						<a name="lg150"> </a>(5) Kui kandidaat kustutatakse registreerimiseks esitatud kandidaatide nimekirjast isikliku avalduse alusel, tagastab Vabariigi Valimiskomisjon talle kandideerimisdokumendid
						ja teavitab sellest erakonna või üksikkandidaadi volitatud esindajat. Erakond kandidaatide registreerimise dokumente uuesti esitama ei pea.
					</p>
					<p>
						<a name="lg151"> </a>(6) Kui erakond või üksikkandidaat esitab dokumendid valimispäevale eelneval 45. päeval enne kella 18.00 ning selgub, et ei ole esitatud kõiki nõutavaid dokumente, et
						dokumentides on andmeid puudu või et nad ei ole Vabariigi Valimiskomisjoni kehtestatud vormi kohased või esitatud dokumentides on vigu, mida ei ole võimalik kohe parandada, võetakse dokumendid
						vastu. Dokumentide vastuvõtja teeb dokumentide esitajale ettepaneku esitada puuduvad dokumendid või andmed või Vabariigi Valimiskomisjoni kehtestatud vormi kohased dokumendid või parandada vead.
						Sellisel juhul peab erakond või üksikkandidaat nõutava toimingu tegema hiljemalt valimispäevale eelneval 43. päeval enne kella 18.00.
					</p>
					<h3>
						<strong>§ 32.</strong><a name="para33"> </a>Kandidaatide registreerimine
					</h3>
					<p>
						<a name="lg152"> </a>(1) Vabariigi Valimiskomisjon registreerib kõik käesoleva seaduse nõuete kohaselt registreerimiseks esitatud isikud nende registreerimiseks esitamise järjekorras pärast
						kandidaatide registreerimiseks esitamise tähtaja lõppemist hiljemalt 40. päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg153"> </a>(2) Kandidaadile antakse registreerimisnumber. Registreerimisnumbrid algavad 101-st ja need antakse kandidaatidele erakondade ringkonnanimekirjade kaupa. Üksikkandidaatidele
						antakse registreerimisnumbrid pärast erakondade kandidaatidele numbrite andmist. Numbrite andmise järjekord erakondade vahel ning üksikkandidaatide vahel selgitatakse liisu heitmisega.
					</p>
					<p>
						<a name="lg154"> </a>(3) Kui käesoleva seaduse § 31 lõikes 6 nimetatud tähtaja jooksul ei tee erakond või üksikkandidaat Vabariigi Valimiskomisjoni nõutud toiminguid, jätab valimiskomisjon
						registreerimata:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kõik erakonna poolt registreerimiseks esitatud kandidaadid, kui puuduvad käesoleva seaduse § 30 lõike 3 punktides 1, 2, 3 või 4 nimetatud
						dokumendid, neis on vigu või need ei ole vormikohased;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kandidaadi, kelle dokumente või andmeid on puudu, kelle dokumentides on vigu või kelle dokumendid ei ole vormikohased.
					</p>
					<p>
						<a name="lg155"> </a>(4) Kandidaadi registreerimata jätmise kohta võtab Vabariigi Valimiskomisjon vastu põhistatud otsuse.
					</p>
					<p>
						<a name="lg156"> </a>(5) Vabariigi Valimiskomisjon tühistab kandidaadi registreerimise otsuse, kui:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kandidaat loobub kandideerimast kirjaliku avalduse alusel, mille ta võib esitada kolme päeva jooksul pärast registreerimist;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kandidaat sureb;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>tõendatakse, et kandidaat ei vasta käesoleva seaduse § 4 lõigetes 4–6 ning § 29 lõikes 5 ettenähtud nõuetele.
					</p>
					<p>
						<a name="lg157"> </a>(6) Vabariigi Valimiskomisjon registreerib varem registreerimata jäetud isiku pärast käesoleva paragrahvi lõikes 1 nimetatud tähtaega, kui ta leiab, et isik vastab käesoleva
						seaduse § 4 lõigetes 4–6 ning § 29 lõikes 5 ettenähtud nõuetele või kui Riigikohtu otsusega on tühistatud Vabariigi Valimiskomisjoni otsus, millega kandidaat jäeti registreerimata.
					</p>
					<p>
						<a name="lg158"> </a>(7) Registreerimisotsuse võib tühistada ja registreerimata jäetud isiku registreerida hiljemalt eelhääletamise algusele eelneval päeval.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/807285">RT I 2004, 71, 501</a> - jõust. 29.10.2004]
						</span>
					</p>
					<h3>
						<strong>§ 33.</strong><a name="para34"> </a>Valimisringkonna kandidaatide koondnimekiri
					</h3>
					<p>
						<a name="lg159"> </a>(1) Vabariigi Valimiskomisjon koostab pärast kandidaatide registreerimist valimisringkonna kandidaatide koondnimekirja.
					</p>
					<p>
						<a name="lg160"> </a>(2) Valimisringkonna kandidaatide koondnimekirja kantakse kandidaadid erakondade ringkonnanimekirjade kaupa registreerimisnumbrite järjekorras. Ringkonnanimekirja ette
						märgitakse selle esitanud erakonna nimi. Üksikkandidaadid kantakse valimisringkonna kandidaatide koondnimekirja pärast erakondade ringkonnanimekirju registreerimisnumbrite järjekorras.
					</p>
					<p>
						<a name="lg161"> </a>(3) Valimisringkonna kandidaatide koondnimekirja märgitakse iga kandidaadi kohta tema registreerimisnumber ja nimi. Kui ühes valimisringkonnas kandideerib mitu samanimelist
						kandidaati, märgitakse koondnimekirja ka nende sünniaeg.
					</p>
					<p>
						<a name="lg162"> </a>(4) Vabariigi Valimiskomisjon teavitab kõigist valimisringkonna kandidaatide koondnimekirja parandustest ja muudatustest valimiskomisjone, välisriigis hääletamist
						korraldavaid välisesindusi ja laevade kapteneid, kes teevad asjakohased muudatused ja parandused kandidaatide koondnimekirja. Kandidaatide koondnimekirju ei muudeta pärast eelhääletamise algust.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/807285">RT I 2004, 71, 501</a> - jõust. 29.10.2004]
						</span>
					</p>
					<h2 class="level2">
						<span>7. peatükk </span>HÄÄLETAMISE KORD<a name="ptk7"> </a>
					</h2>
					<h3>
						<strong>§ 34.</strong><a name="para35"> </a>Hääletamisruum
					</h3>
					<p>
						<a name="lg163"> </a>(1) Hääletamine valimisjaoskonnas korraldatakse valla- või linnavalitsuse määratud hääletamisruumis. Hääletamiseks valimispäeval ja eelhääletamise päevadel võib määrata
						erinevad hääletamisruumid.
					</p>
					<p>
						<a name="lg164"> </a>(2) Hääletamisruumis on hääletamissedelite väljaandmise kohad, hääletamiskabiinid ja hääletamiskast. Valimisjaoskonnas, kus korraldatakse väljaspool elukohajärgset
						valimisjaoskonda hääletamist, on eelhääletamise ajal hääletamisruumis eraldi hääletamiskabiin ja hääletamiskast väljaspool elukohajärgset valimisjaoskonda hääletavate valijate jaoks.
						Hääletamisruumis on välja pandud selle valimisringkonna kandidaatide koondnimekiri ja kandidaatide üleriigilised nimekirjad.
					</p>
					<p>
						<a name="lg165"> </a>(3) Hääletamisruumis peab korda jaoskonnakomisjon. Jaoskonnakomisjoni liikme seaduslikud suulised korraldused on kohustuslikud kõigile hääletamisruumis viibivatele
						isikutele.
					</p>
					<h3>
						<strong>§ 35.</strong><a name="para36"> </a>Hääletamiskabiin
					</h3>
					<p>
						<a name="lg166"> </a>(1) Hääletamiskabiin peab võimaldama salajast hääletamist.
					</p>
					<p>
						<a name="lg167"> </a>(2) Hääletamiskabiinis on laud ja kirjutusvahend. Hääletamiskabiini seinal on selle valimisringkonna kandidaatide koondnimekiri, välja arvatud kabiinis, mis on ette nähtud
						väljaspool elukohajärgset valimisjaoskonda hääletavatele valijatele.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 36.</strong><a name="para37"> </a>Hääletamiskast
					</h3>
					<p>
						<a name="lg168"> </a>(1) Jaoskonnakomisjon kontrollib hääletamiskasti ja pitseerib selle enne hääletamise algust. Enne eelhääletamise algust pitseeritud hääletamiskasti kasutatakse üksnes
						eelhääletamisel.
					</p>
					<p>
						<a name="lg169"> </a>(2) Hääletamiskasti ava on kaetud. See avatakse üksnes hääletamissedeli kasti laskmiseks.
					</p>
					<p>
						<a name="lg170"> </a>(3) Eelhääletamise päevadel pitseerib jaoskonnakomisjon pärast hääletamise lõppemist eelhääletamisel kasutatud hääletamiskasti ava.
					</p>
					<h3>
						<strong>§ 37.</strong><a name="para38"> </a>Hääletamissedel
					</h3>
					<p>
						<a name="lg171"> </a>(1) <a href="https://www.riigiteataja.ee/akt/./dyn=1045561&amp;id=249412">Hääletamissedeli vormi kehtestab Vabariigi Valimiskomisjon</a> .
					</p>
					<p>
						<a name="lg172"> </a>(2) Vabariigi Valimiskomisjon korraldab hääletamissedelite valmistamise ning jaoskonnakomisjonidele kättetoimetamise.
					</p>
					<p>
						<a name="lg173"> </a>(3) Pärast hääletamissedelite kättesaamist paneb jaoskonnakomisjon sedelitele jaoskonnakomisjoni pitsati jäljendi. Välisriigis ja laeval hääletamisel kasutatavatele
						sedelitele paneb pitsati jäljendi Vabariigi Valimiskomisjon.
					</p>
					<h3>
						<strong>§ 38.</strong><a name="para39"> </a>Hääletamise aeg
					</h3>
					<p>
						<a name="lg174"> </a>(1) Valimispäeval algab hääletamine kell 9.00 ja lõpeb kell 20.00.
					</p>
					<p>
						<a name="lg175"> </a>(2) Eelhääletamine toimub:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kolmeteistkümnendast päevast kuni üheksanda päevani enne valimispäeva maakonna valimiskomisjoni määratud valimisjaoskonnas. Hääletamine algab kell
						12.00 ja lõpeb kell 20.00;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kuuendast päevast kuni neljanda päevani enne valimispäeva kõigis valimisjaoskondades. Hääletamine algab kell 12.00 ja lõpeb kell 20.00;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kuuendast päevast kuni neljanda päevani enne valimispäeva elektrooniliselt. Hääletamine algab kuuendal päeval enne valimispäeva kell 9.00 ja kestab
						ööpäevaringselt kuni hääletamise lõpuni neljandal päeval enne valimispäeva kell 20.00.
					</p>
					<p>
						<a name="lg176"> </a>(3) Kodus hääletamine korraldatakse käesolevas seaduses ettenähtud juhtudel valimispäeval.
					</p>
					<p>
						<a name="lg177"> </a>(4) Kinnipidamiskohas hääletamine korraldatakse käesolevas seaduses ettenähtud juhtudel käesoleva paragrahvi lõike 2 punktis 2 ettenähtud päevadel.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 39.</strong><a name="para40"> </a>Hääletamine
					</h3>
					<p>
						<a name="lg178"> </a>(1) Valija hääletab selles valimisjaoskonnas, mille valijate nimekirja ta on kantud, välja arvatud käesoleva seaduse §-des 41–45, 47 ning 8. peatükis ettenähtud juhtudel.
					</p>
					<p>
						<a name="lg179"> </a>(2) Hääletamissedeli saamiseks esitab valija jaoskonnakomisjonile isikut tõendava dokumendi. Hääletamissedeli saamise kohta annab valija allkirja valijate nimekirja.
					</p>
					<p>
						<a name="lg180"> </a>(3) Valija täidab hääletamissedeli hääletamiskabiinis.
					</p>
					<p>
						<a name="lg181"> </a>(4) Valija kirjutab hääletamissedelile selleks ettenähtud kohta ühe oma elukohajärgse valimisringkonna kandidaadi registreerimisnumbri, kelle poolt ta hääletab.
					</p>
					<p>
						<a name="lg182"> </a>(5) Valija täidab hääletamissedeli ise. Kui valija füüsilise puude tõttu ei ole võimeline hääletamissedelit ise täitma, võib seda tema palvel ja tema juuresolekul teha teine
						valija, kuid mitte tema elukohajärgse valimisringkonna kandidaat.
					</p>
					<p>
						<a name="lg183"> </a>(6) Valija ei või hääletamissedelit hääletamisruumist välja viia. Kui valija rikub hääletamissedeli, on tal õigus saada jaoskonnakomisjonilt uus sedel. Valija peab rikutud
						või kasutamata hääletamissedeli jaoskonnakomisjonile tagastama.
					</p>
					<p>
						<a name="lg184"> </a>(7) Pärast hääletamissedeli täitmist murrab valija sedeli kokku ning annab selle jaoskonnakomisjoni liikmele, kes paneb kokkumurtud hääletamissedeli välisküljele
						jaoskonnakomisjoni pitsati jäljendi.
					</p>
					<p>
						<a name="lg185"> </a>(8) Valija laseb hääletamissedeli hääletamiskasti ise. Kui valija füüsilise puude tõttu ei ole võimeline hääletamissedelit ise hääletamiskasti laskma, võib seda tema palvel
						teha teine valija tema juuresolekul.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 40.</strong><a name="para41"> </a>Eelhääletamine
					</h3>
					<p>
						<a name="lg186"> </a>(1) Eelhääletamine toimub käesoleva seaduse §-s 39 ettenähtud korras.
					</p>
					<p>
						<a name="lg187"> </a>(2) Eelhääletamise õigus on valijate nimekirjas oleval valijal, kes eelhääletamise päevaks on vähemalt 18-aastane.
					</p>
					<p>
						<a name="lg188"> </a>(3) Eelhääletamist korraldavad vähemalt kolm jaoskonnakomisjoni liiget.
					</p>
					<p>
						<a name="lg189"> </a>(4) Jaoskonnakomisjoni liige märgib hääletanud valija kohta valijate nimekirja hääletamise kuupäeva.
					</p>
					<p>
						<a name="lg190"> </a>(5) Jaoskonnakomisjon hoiab hääletamiskasti ja valimisdokumente eelhääletamise päevadel ja sellele järgnevatel päevadel selliselt, et neile pääsevad ligi üksnes
						jaoskonnakomisjoni liikmed.
					</p>
					<h3>
						<strong>§ 41.</strong><a name="para42"> </a>Väljaspool elukohajärgset valimisjaoskonda toimuva eelhääletamise erisused
					</h3>
					<p>
						<a name="lg191"> </a>(1) Valijal on eelhääletamise päevadel (§ 38 lõige 2) võimalik hääletada väljaspool oma elukohajärgset valimisjaoskonda maakonna valimiskomisjoni või valla- või
						linnavalitsuse poolt määratud valimisjaoskonnas.
					</p>
					<p>
						<a name="lg192"> </a>(2) Väljaspool elukohajärgset valimisjaoskonda toimuvat hääletamist korraldab valla- või linnavalitsuse määratud jaoskonnakomisjon. Valla- või linnavalitsus võib määrata
						jaoskonnakomisjoni, kes korraldab lisaks eelhääletamisele hääletamist ainult valija asukohas (§ 43) või ainult kinnipidamiskohas (§ 45).
					</p>
					<p>
						<a name="lg193"> </a>(3) Maakonna valimiskomisjon, välja arvatud Harju Maakonna Valimiskomisjon ja Tartu Maakonna Valimiskomisjon, määrab oma otsusega hiljemalt 45. päeval enne valimispäeva
						vähemalt ühe maakonnakeskuses paikneva valimisjaoskonna, kus valijad saavad hääletada väljaspool oma elukohajärgset jaoskonda käesoleva seaduse § 38 lõike 2 punktis 1 ettenähtud päevadel.
						Tallinnas ja Tartu linnas määrab vastava valimisjaoskonna linna valimiskomisjon. Maakonna valimiskomisjon avalikustab oma otsuse hiljemalt eelhääletamise algusele eelneval nädalal.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 42.</strong><a name="para43"> </a>Väljaspool elukohajärgset valimisjaoskonda toimuv eelhääletamine hääletamisruumis
					</h3>
					<p>
						<a name="lg194"> </a>(1) Väljaspool oma elukohajärgset valimisjaoskonda hääletamisruumis hääletada sooviv valija esitab jaoskonnakomisjoni liikmele isikut tõendava dokumendi ning ta kantakse
						väljaspool elukohajärgset valimisjaoskonda hääletajate nimekirja.
					</p>
					<p>
						<a name="lg195"> </a>(2) Jaoskonnakomisjoni liige annab valijale hääletamissedeli, kaks ümbrikku ja valija elukohajärgse valimisringkonna kandidaatide koondnimekirja. Valija annab
						hääletamissedeli saamise kohta allkirja väljaspool elukohajärgset valimisjaoskonda hääletavate valijate nimekirja.
					</p>
					<p>
						<a name="lg196"> </a>(3) Valija täidab hääletamissedeli käesoleva seaduse § 39 lõigetes 3–6 ettenähtut järgides.
					</p>
					<p>
						<a name="lg197"> </a>(4) Valija paneb sedeli ühte jaoskonnakomisjoni liikme antud ümbrikku. Viimase paneb valija jaoskonnakomisjoni liikme antud teise ümbrikku. Välimisele ümbrikule kirjutab
						valija või jaoskonnakomisjoni liige valija nime, isikukoodi ja valija elukoha aadressi. Ümbriku laseb valija väljaspool elukohajärgset valimisjaoskonda hääletavate valijate sedelitele ettenähtud
						hääletamiskasti.
					</p>
					<h3>
						<strong>§ 43.</strong><a name="para44"> </a>Väljaspool elukohajärgset valimisjaoskonda valija asukohas toimuv eelhääletamine
					</h3>
					<p>
						<a name="lg198"> </a>(1) Kui väljaspool elukohajärgset valimisjaoskonda hääletada sooviv valija terviseseisundi või muu mõjuva põhjuse tõttu ei saa hääletada valimisjaoskonnas asuvas
						hääletamisruumis, võib ta kuni eelhääletamise viimase päeva kella 16.00-ni esitada kirjaliku taotluse oma asukohas hääletamiseks asukohajärgsele valla- või linnavalitsusele või käesoleva seaduse
						§ 41 lõikes 2 ettenähtud jaoskonnakomisjonile. Jaoskonnakomisjon registreerib taotluse. Valla- või linnavalitsus registreerib taotluse ja edastab selle vastavale jaoskonnakomisjonile.
					</p>
					<p>
						<a name="lg199"> </a>(2) Hääletamist korraldavad vähemalt kaks jaoskonnakomisjoni liiget käesoleva seaduse § 39 lõigetes 4–6 ning § 42 lõigetes 1, 2 ja 4 ettenähtut järgides.
					</p>
					<h3>
						<strong>§ 44.</strong><a name="para45"> </a>Elektrooniline hääletamine
					</h3>
					<p>
						<a name="lg200"> </a>(1) Valija saab käesoleva seaduse § 38 lõike 2 punktis 3 ettenähtud päevadel hääletada elektrooniliselt Vabariigi Valimiskomisjoni veebilehel. Valija hääletab ise.
					</p>
					<p>
						<a name="lg201"> </a>(2) Valija tõendab oma isikut isikutunnistusele kantud digitaalset tuvastamist võimaldava sertifikaadi alusel.
					</p>
					<p>
						<a name="lg202"> </a>(3) Pärast valija isiku tuvastamist kuvatakse veebilehel valijale tema elukohajärgse valimisringkonna kandidaatide koondnimekiri.
					</p>
					<p>
						<a name="lg203"> </a>(4) Valija märgistab oma elukohajärgse valimisringkonna selle kandidaadi nime, kelle poolt ta hääletab, ning kinnitab hääletamist digitaalallkirja andmisega
						isikutunnistusele kantud digitaalallkirjastamist võimaldava sertifikaadi alusel.
					</p>
					<p>
						<a name="lg204"> </a>(5) Valija saab veebilehel teate hääle vastuvõtmise kohta.
					</p>
					<p>
						<a name="lg205"> </a>(6) Valijal on õigus oma elektrooniliselt antud häält muuta:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>hääletades uuesti elektrooniliselt käesoleva seaduse § 38 lõike 2 punktis 3 ettenähtud ajal;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>hääletades hääletamissedeliga kuuendast päevast kuni neljanda päevani enne valimispäeva käesoleva seaduse §-s 40–43, 45 või 47 ettenähtud korras.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 45.</strong><a name="para46"> </a>Hääletamine kinnipidamiskohas
					</h3>
					<p>
						<a name="lg206"> </a>(1) Kinnipidamiskohas korraldatakse hääletamine käesoleva seaduse § 38 lõike 2 punktis 2 ettenähtud päevadel.
					</p>
					<p>
						<a name="lg207"> </a>(2) Kinnipidamiskoha administratsioon esitab taotluse hääletamise korraldamiseks käesoleva seaduse § 41 lõikes 2 ettenähtud jaoskonnakomisjonile.
					</p>
					<p>
						<a name="lg208"> </a>(3) Hääletamist korraldavad vähemalt kaks jaoskonnakomisjoni liiget käesoleva seaduse § 39 lõigetes 4–6 ning § 42 lõigetes 1, 2 ja 4 ettenähtut järgides.
					</p>
					<p>
						<a name="lg209"> </a>(4) Hääletamistulemuste kindlakstegemisel arvestatakse kinnipidamiskohas eelhääletanud valijate hääli käesoleva seaduse §-s 48 ettenähtut järgides.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/704851">RT I 2004, 6, 32</a> - jõust. 14.02.2004]
						</span>
					</p>
					<h3>
						<strong>§ 46.</strong><a name="para47"> </a>Kodus hääletamine
					</h3>
					<p>
						<a name="lg210"> </a>(1) Kui valija terviseseisundi või mõne muu mõjuva põhjuse tõttu ei saa hääletada hääletamisruumis, võib ta taotleda kodus hääletamist.
					</p>
					<p>
						<a name="lg211"> </a>(2) Kodus hääletamise korraldamiseks esitab valija elukohajärgsele valla- või linnavalitsusele või jaoskonnakomisjonile kuni valimispäeva kella 16.00-ni kirjaliku taotluse,
						mille jaoskonnakomisjon registreerib. Kui taotlus esitatakse valla- või linnavalitsusele, registreerib see taotluse ja edastab asjaomasele jaoskonnakomisjonile.
					</p>
					<p>
						<a name="lg212"> </a>(3) Kodus hääletamist korraldavad vähemalt kaks jaoskonnakomisjoni liiget. Nimetatud liikmete määramisel lähtutakse põhimõttest, et nad ei ole sama erakonna liikmed või sama
						erakonna ettepanekul jaoskonnakomisjoni liikmeks esitatud. Kodus hääletamist korraldatakse käesoleva seaduse § 39 lõigetes 1, 2, 4, 5, 6 ja 8 ettenähtut järgides.
					</p>
					<p>
						<a name="lg213"> </a>(4) Kodus hääletav valija annab hääletamissedeli saamise kohta allkirja kodus hääletavate valijate nimekirja.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 47.</strong><a name="para48"> </a>Välisriigis elava valija hääletamine Eestis
					</h3>
					<p>
						<a name="lg214"> </a>(1) Välisriigis elav valija, kes on kantud alaliselt välisriigis elavate valijate nimekirja ja kes ei ole hääletanud 8. peatükis ettenähtud korras, võib hääletada
						eelhääletamise ajal käesoleva seaduse § 41 lõike 2 esimeses lauses või § 41 lõikes 3 ettenähtud korras määratud mis tahes valimisjaoskonnas.
					</p>
					<p>
						<a name="lg215"> </a>(2) Hääletamissedeli saamiseks esitab valija jaoskonnakomisjonile isikut tõendava dokumendi ning ta kantakse väljaspool elukohajärgset jaoskonda hääletavate valijate
						nimekirja.
					</p>
					<p>
						<a name="lg216"> </a>(3) Jaoskonnakomisjoni liige annab valijale hääletamissedeli, kaks ümbrikku ja tema valimisringkonna kandidaatide koondnimekirja. Valija annab hääletamissedeli saamise kohta
						allkirja väljaspool elukohajärgset valimisjaoskonda hääletavate valijate nimekirja.
					</p>
					<p>
						<a name="lg217"> </a>(4) Valija täidab hääletamissedeli käesoleva seaduse § 39 lõigetes 3–6 ettenähtut järgides.
					</p>
					<p>
						<a name="lg218"> </a>(5) Valija paneb sedeli ühte jaoskonnakomisjoni liikme antud ümbrikku. Viimase paneb valija jaoskonnakomisjoni liikme antud teise ümbrikku. Välimisele ümbrikule kirjutab
						valija või jaoskonnakomisjoni liige valija nime, isikukoodi, elukoha aadressi ja valimisringkonna numbri. Ümbriku laseb valija väljaspool elukohajärgset valimisjaoskonda hääletavate valijate
						sedelitele ettenähtud hääletamiskasti.
					</p>
					<p>
						<a name="lg219"> </a>(6) Käesoleva paragrahvi lõikes 1 ettenähtud korras antud hääli arvestatakse hääletamistulemuste kindlakstegemisel käesoleva seaduse § 48 lõigetes 1 ja 2 ning § 55 lõigetes
						2–6 ettenähtut järgides.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/704851">RT I 2004, 6, 32</a> - jõust. 14.02.2004]
						</span>
					</p>
					<h3>
						<strong>§ 48.</strong><a name="para49"> </a>Eelhääletamise ajal väljaspool elukohajärgset valimisjaoskonda antud häälte arvestamine
					</h3>
					<p>
						<a name="lg220"> </a>(1) Jaoskonnakomisjon pakib väljaspool elukohajärgset valimisjaoskonda hääletanud valijate hääletamissedelitega ümbrikud maakondade kaupa, Tallinna ja Tartu linna kaupa ning
						edastab need oma asukohajärgsele maakonna valimiskomisjonile.
					</p>
					<p>
						<a name="lg221"> </a>(2) Maakonna valimiskomisjon edastab käesoleva paragrahvi lõikes 1 nimetatud hääletamissedelitega ümbrikud Vabariigi Valimiskomisjoni kaudu asjaomastele maakonna
						valimiskomisjonidele hiljemalt teisel päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg222"> </a>(3) Käesoleva paragrahvi lõikes 2 ettenähtud korras teistelt maakonna valimiskomisjonidelt saadud hääletamissedelitega ümbrikud edastab maakonna valimiskomisjon asjaomastele
						jaoskonnakomisjonidele hiljemalt valimispäevale eelneval päeval.
					</p>
					<p>
						<a name="lg223"> </a>(4) Saanud hääletamissedelitega ümbrikud käesoleva paragrahvi lõikes 3 ettenähtud korras, kontrollib jaoskonnakomisjon, kas valija on kantud valimisjaoskonna valijate
						nimekirja ja kas valija ei ole hääletanud mitu korda. Kontrollimise juures peab olema vähemalt kolm jaoskonnakomisjoni liiget.
					</p>
					<p>
						<a name="lg224"> </a>(5) Kui valija ei ole kantud valimisjaoskonna valijate nimekirja või on hääletanud väljaspool elukohajärgset valimisjaoskonda mitu korda, jätab jaoskonnakomisjon kõik valija
						hääletamissedeliga ümbrikud arvestamata.
					</p>
					<p>
						<a name="lg225"> </a>(6) Kui valija on hääletanud ühe korra, teeb jaoskonnakomisjoni liige valijate nimekirja märke eelhääletamise kohta.
					</p>
					<p>
						<a name="lg226"> </a>(7) Pärast käesoleva paragrahvi lõigetes 4–6 ettenähtud toiminguid avab jaoskonnakomisjon välimised ümbrikud ning laseb sisemised hääletamissedelitega ümbrikud
						eelhääletamisel kasutatud hääletamiskasti ja pitseerib hääletamiskasti ava uuesti.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 48<sup>1</sup>.
						</strong><a name="para50"> </a>Elektrooniliselt antud häälte arvestamine
					</h3>
					<p>
						<a name="lg227"> </a>(1) Mitme elektrooniliselt antud hääle puhul (§ 44 lõige 6) arvestatakse valija viimasena antud häält.
					</p>
					<p>
						<a name="lg228"> </a>(2) Pärast elektroonilise hääletamise lõppu koostab Vabariigi Valimiskomisjon valimisjaoskondade kaupa elektrooniliselt hääletanud valijate nimekirja ning edastab selle
						maakonna valimiskomisjonidele hiljemalt teisel päeval enne valimispäeva. Maakonna valimiskomisjon edastab nimekirja jaoskonnakomisjonidele hiljemalt valimispäevale eelneval päeval.
					</p>
					<p>
						<a name="lg229"> </a>(3) Kui valija on hääletanud elektrooniliselt, teeb jaoskonnakomisjoni liige valijate nimekirja märke elektroonilise hääletamise kohta.
					</p>
					<p>
						<a name="lg230"> </a>(4) Kui valija on hääletanud nii elektrooniliselt kui ka hääletamissedeliga, arvestatakse valija hääletamissedelit. Jaoskonnakomisjon saadab Vabariigi Valimiskomisjonile
						asjakohase teatise, mille alusel Vabariigi Valimiskomisjon tühistab valija elektrooniliselt antud hääle.
					</p>
					<p>
						<a name="lg231"> </a>(5) Kui valija on hääletanud mitu korda väljaspool elukohajärgset valimisjaoskonda ja elektrooniliselt, jäetakse kõik valija hääletamissedeliga ümbrikud ja elektrooniliselt
						antud hääl arvestamata. Jaoskonnakomisjon saadab Vabariigi Valimiskomisjonile asjakohase teatise, mille alusel Vabariigi Valimiskomisjon tühistab valija elektrooniliselt antud hääle.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>8. peatükk </span>HÄÄLETAMINE VÄLISRIIGIS<a name="ptk8"> </a>
					</h2>
					<h3>
						<strong>§ 49.</strong><a name="para51"> </a>Hääletamise ettevalmistamine
					</h3>
					<p>
						<a name="lg232"> </a>(1) Välisriigis alaliselt elavate valijate ja seal ajutiselt viibivate valijate hääletamist välisriigis viivad läbi Eesti välisesindused.
					</p>
					<p>
						<a name="lg233"> </a>(2) Vabariigi Valitsus võib oma korraldusega määrata hääletamist läbi viima aukonsulaadi, mille aukonsul on Eesti kodanik. Sellisel juhul teeb käesolevas peatükis ettenähtud
						toiminguid aukonsulaat.
					</p>
					<p>
						<a name="lg234"> </a>(3) Hääletamist korraldab välisesinduse juht või tema määratud ametnik. Käesoleva paragrahvi lõikes 2 ettenähtud juhul korraldab hääletamist aukonsul või tema määratud isik.
						Hääletamise korraldajaks peab olema isik, kellel on hääletamisõigus käesoleva seaduse § 4 lõigete 1 ja 2 kohaselt.
					</p>
					<p>
						<a name="lg235"> </a>(4) Rahvastikuregistri vastutav töötleja korraldab välisriigis alaliselt elavate valijate nimekirja edastamise välisesindustele. Valijate nimekirja kantakse järgmised
						andmed:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>isikukood;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>elukoha aadressiandmed, kui need on teada;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>selle valimisringkonna number, mille kandidaatide koondnimekiri valijale saadetakse.
					</p>
					<p>
						<a name="lg236"> </a>(5) Kui välisriigis alaliselt elava või seal ajutiselt viibiva valija aadress on teada, saadab välisesindus talle valijakaardi kirja teel või elektronpostiga hiljemalt 85.
						päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg237"> </a>(6) Valijakaardile kantakse:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>valija ees- ja perekonnanimi;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valija sünniaeg;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>valija aadress;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>välisesinduse aadress;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>kirja teel hääletamise taotluse esitamise, kirja teel hääletamise ja välisesinduses hääletamise kord;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>kirja teel hääletamise taotluse välisesindusele laekumise tähtpäev;<br />
						<a name=""> </a>7)<span class="tyhik"> </span>kirja teel saadetava hääletamissedeli välisesindusele laekumise tähtpäev;<br />
						<a name=""> </a>8)<span class="tyhik"> </span>välisesinduses hääletamise aeg;<br />
						<a name=""> </a>9)<span class="tyhik"> </span>elektroonilise hääletamise aeg.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 50.</strong><a name="para52"> </a>Hääletamistaotluste esitamine
					</h3>
					<p>
						<a name="lg238"> </a>(1) Kui valija soovib hääletada kirja teel, saadab ta oma asukohariigi Eesti välisesindusele sellekohase taotluse. Kui valija asukohariigis Eesti välisesindust ei ole,
						saadab valija taotluse lähimale Eesti välisesindusele.
					</p>
					<p>
						<a name="lg239"> </a>(2) Valija, kes on kantud alaliselt välisriigis elavate valijate nimekirja:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>lisab taotlusele isikut tõendava dokumendi isikuandmete lehekülje koopia;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>märgib taotluses välisriigis oleva elukoha aadressi.
					</p>
					<p>
						<a name="lg240"> </a>(3) Valija, keda ei ole alaliselt välisriigis elavate valijate nimekirjas:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>lisab taotlusele koopiad dokumentidest, mis tõendavad tema isikut ja seda, et tal on hääletamisõigus käesoleva seaduse § 4 lõigete 1 ja 2 kohaselt;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>märgib välisriigis oleva elukoha aadressi;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>märgib, kus oli tema viimane elukoht Eestis (maakond, Tallinna linnaosa või Tartu linn). Kui alaliselt välisriigis elaval valijal ei ole Eestis
						elukohta olnud, märgib ta oma vanemate või vanavanemate viimase elukoha Eestis.
					</p>
					<p>
						<a name="lg241"> </a>(4) Ajutiselt välisriigis viibiv valija märgib taotluses lisaks käesoleva paragrahvi lõike 2 punktides 1 ja 2 ettenähtud andmetele ka oma elukoha aadressi Eestis.
					</p>
					<p>
						<a name="lg242"> </a>(5) Taotlused peavad olema laekunud välisesindusele hiljemalt 30. päeval enne valimispäeva.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 51.</strong><a name="para53"> </a>Valimisdokumentide saatmine valijale
					</h3>
					<p>
						<a name="lg243"> </a>(1) Taotluse õigeaegselt saatnud valijale, kes vastab käesoleva seaduse nõuetele, saadab välisesindus esimesel võimalusel:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>hääletamissedeli;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valimisringkonna kandidaatide koondnimekirja vastavalt alaliselt välisriigis elavate valijate nimekirja andmetele või käesoleva seaduse § 50 lõike 3
						punkti 3 või lõike 4 kohaselt;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kaks ümbrikku.
					</p>
					<p>
						<a name="lg244"> </a>(2) Kui alaliselt välisriigis elav valija on märkinud oma või vanemate või vanavanemate viimase elukohana Eestis Tallinna linnaosa täpsustamata, saadetakse talle
						valimisringkonna nr 1 kandidaatide koondnimekiri.
					</p>
					<p>
						<a name="lg245"> </a>(3) Kui alaliselt välisriigis elav valija on oma või vanemate või vanavanemate viimase elukohana Eestis märkinud Petseri maakonna, saadetakse talle valimisringkonna nr 11
						kandidaatide koondnimekiri.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 52.</strong><a name="para54"> </a>Kirja teel hääletamine
					</h3>
					<p>
						<a name="lg246"> </a>(1) Valija täidab hääletamissedeli käesolevas seaduses ettenähtut järgides. Valija paneb täidetud sedeli ühte välisesinduse saadetud ümbrikku. Viimase paneb valija
						välisesinduse saadetud teise ümbrikku. Välimisele ümbrikule kirjutab valija oma nime, isikukoodi ja valimisringkonna numbri. Ajutiselt välisriigis viibiv valija kirjutab välimisele ümbrikule ka
						oma elukoha aadressi Eestis. Seejärel saadab valija hääletamissedeli välisesindusele.
					</p>
					<p>
						<a name="lg247"> </a>(2) Kirja teel saadetavad hääletamissedelid peavad olema välisesindusele laekunud välisesinduse määratud päeval, mis peab olema määratud arvestusega, et hääletamissedelid
						laekuksid Vabariigi Valimiskomisjonile hiljemalt neljandal päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg248"> </a>(3) Välisesindus koostab kirja teel hääletanud valijate nimekirja ning edastab selle Vabariigi Valimiskomisjonile arvestusega, et nimekiri laekuks Vabariigi
						Valimiskomisjonile hiljemalt neljandal päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg249"> </a>(4) Kirja teel hääletamise korral kannab käesoleva seaduse § 50 lõikes 1 ja käesoleva paragrahvi lõikes 1 nimetatud toimingutega seotud kulud valija.
					</p>
					<h3>
						<strong>§ 53.</strong><a name="para55"> </a>Elektrooniline hääletamine välisriigis
					</h3>
					<p>
						<a name="lg250"> </a>(1) Alaliselt välisriigis elavate valijate nimekirja kantud või ajutiselt välisriigis viibiv valija võib hääletada Vabariigi Valimiskomisjoni veebilehel.
					</p>
					<p>
						<a name="lg251"> </a>(2) Elektrooniline hääletamine toimub käesoleva seaduse § 38 lõike 2 punktis 3 ettenähtud ajal ja §-s 44 ettenähtud korras.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 54.</strong><a name="para56"> </a>Hääletamine välisesinduses
					</h3>
					<p>
						<a name="lg252"> </a>(1) Kui valija ei esita kirja teel hääletamise taotlust välisesindusele käesoleva seaduse § 50 lõikes 5 ettenähtud tähtaja jooksul või ei saada hääletamissedelit
						välisesindusele § 52 lõikes 2 ettenähtud tähtpäevaks, võib ta hääletada välisesinduses viimase määratud ajal.
					</p>
					<p>
						<a name="lg253"> </a>(2) Välisesinduses hääletamist peab välisesindus võimaldama vähemalt kahel päeval ajavahemikus 15. päevast kuni 10. päevani enne valimispäeva.
					</p>
					<p>
						<a name="lg254"> </a>(3) Välisesinduses täidab valija hääletamissedeli käesolevas seaduses ettenähtut järgides. Seejärel paneb valija täidetud sedeli ümbrikku. Viimase paneb valija teise
						ümbrikku. Välimisele ümbrikule kirjutab valija või hääletamist korraldav isik valija nime, isikukoodi ja valimisringkonna numbri. Ajutiselt välisriigis viibiv valija kirjutab välimisele
						ümbrikule ka oma elukoha aadressi Eestis.
					</p>
					<p>
						<a name="lg255"> </a>(4) Välisesinduses hääletav valija annab hääletamissedeli saamise kohta allkirja välisesinduses hääletavate valijate nimekirja.
					</p>
					<h3>
						<strong>§ 55.</strong><a name="para57"> </a>Hääletamissedelite arvestamine hääletamistulemuste kindlakstegemisel
					</h3>
					<p>
						<a name="lg256"> </a>(1) Välisesindusele laekunud hääletamissedeleid arvestatakse hääletamistulemuste kindlakstegemisel, kui need laekuvad Vabariigi Valimiskomisjonile hiljemalt neljandal päeval
						enne valimispäeva.
					</p>
					<p>
						<a name="lg257"> </a>(2) Saanud alaliselt välisriigis elavate valijate hääletamissedelitega ümbrikud, kontrollib Vabariigi Valimiskomisjon, kas alaliselt välisriigis elav valija ei ole
						hääletanud mitu korda ja kas Eestis hääletanud alaliselt välisriigis elav valija on kantud välisriigis alaliselt elavate valijate nimekirja.
					</p>
					<p>
						<a name="lg258"> </a>(3) Kui alaliselt välisriigis elav valija on hääletanud hääletamissedeliga mitu korda või kui ta ei ole kantud välisriigis alaliselt elavate valijate nimekirja, jätab
						Vabariigi Valimiskomisjon kõik valija hääletamissedeliga ümbrikud arvestamata. Kui valija on hääletanud nii elektrooniliselt kui ka hääletamissedeliga, arvestatakse valija hääletamissedelit. Kui
						valija on hääletanud mitu korda hääletamissedeliga ja elektrooniliselt, jäetakse kõik valija hääletamissedeliga ümbrikud ja elektrooniliselt antud hääl arvestamata.
					</p>
					<p>
						<a name="lg259"> </a>(4) Vabariigi Valimiskomisjon määrab iga valimisringkonna kohta ühe maakonna valimiskomisjoni, kes teeb kindlaks välisriigis alaliselt elavate valijate hääletamistulemused.
					</p>
					<p>
						<a name="lg260"> </a>(5) Vabariigi Valimiskomisjon edastab alaliselt välisriigis elavate valijate hääletamissedelid käesoleva paragrahvi lõikes 4 määratud valimiskomisjonile hiljemalt teisel
						päeval enne valimispäeva.
					</p>
					<p>
						<a name="lg261"> </a>(6) Ümbrikud alaliselt välisriigis elavate valijate hääletamissedelitega jäävad maakonna valimiskomisjonile ning need avatakse valimispäeval hääletamistulemuste
						kindlakstegemiseks.
					</p>
					<p>
						<a name="lg262"> </a>(7) Ajutiselt välisriigis viibivate valijate hääletamissedelitega ümbrikud edastab Vabariigi Valimiskomisjon vastavatele jaoskonnakomisjonidele hiljemalt valimispäevale
						eelneval päeval, kus sedeleid arvestatakse hääletamistulemuste kindlakstegemisel vastavalt käesoleva seaduse § 48 lõigetes 4–7 ettenähtule.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 56.</strong><a name="para58"> </a>Hääletamine rahvusvahelistes või välisriigi vetes asuval Eesti riigilippu kandval laeval
					</h3>
					<p>
						<a name="lg263"> </a>(1) Kui Eesti riigilippu kandev laev, millel on valijaid, asub eelhääletamise päevadel ja valimispäeval rahvusvahelistes või välisriigi vetes, võib selle laeva kapten
						esitada Vabariigi Valimiskomisjonile taotluse laeval hääletamise korraldamiseks.
					</p>
					<p>
						<a name="lg264"> </a>(2) Hääletamise laeval korraldab laeva kapten käesolevas seaduses ettenähtut järgides. Valija hääletab laeval käesoleva seaduse § 42 lõigetes 3 ja 4 ettenähtut järgides.
						Laeval antud hääled arvestatakse hääletamistulemuste kindlakstegemisel käesoleva seaduse § 55 lõigetes 1 ja 7 ning § 48 lõigetes 4–7 ettenähtut järgides.
					</p>
					<h2 class="level2">
						<span>9. peatükk </span>HÄÄLETAMIS- JA VALIMISTULEMUSTE KINDLAKSTEGEMINE<a name="ptk9"> </a>
					</h2>
					<h3>
						<strong>§ 57.</strong><a name="para59"> </a>Hääletamistulemuste kindlakstegemine jaoskonnakomisjonis
					</h3>
					<p>
						<a name="lg265"> </a>(1) Jaoskonnakomisjon avab valimispäeval kasutatud hääletamiskastid pärast hääletamise lõppemist. Avamise juures peab olema üle poole jaoskonnakomisjoni koosseisust.
					</p>
					<p>
						<a name="lg266"> </a>(2) Enne hääletamiskastide avamist peab jaoskonnakomisjon üle lugema ja kustutama kõik valijatele välja andmata jäänud, samuti valijate tagastatud rikutud hääletamissedelid.
						Hääletamissedelid kustutatakse sedeli nurga äralõikamisega.
					</p>
					<p>
						<a name="lg267"> </a>(3) Enne hääletamiskastide avamist teeb jaoskonnakomisjon valijate nimekirja alusel kindlaks valijate arvu ning hääletamissedeli saamise kohta antud allkirjade ja märkuste
						alusel esialgse hääletamisest osavõtnute arvu ning edastab need viivitamata Vabariigi Valimiskomisjonile. Arvestada tuleb valijate nimekirja märkusi väljaspool elukohta eelhääletanud,
						elektrooniliselt hääletanud ja kodus hääletanud valijate kohta. Valijate arv kantakse vormikohasesse protokolli.
					</p>
					<p>
						<a name="lg268"> </a>(4) Hääletamiskasti avades kontrollitakse sellel oleva pitsati jäljendi seisukorda.
					</p>
					<p>
						<a name="lg269"> </a>(5) Kodus hääletanute hääletamissedelite välisküljele pannakse jaoskonnakomisjoni pitsati jäljend ning sedelid pannakse hääletamisruumis hääletanute hääletamissedelite
						hulka.
					</p>
					<p>
						<a name="lg270"> </a>(6) Väljaspool elukohajärgset valimisjaoskonda hääletanute hääletamissedelite välisküljele pannakse jaoskonnakomisjoni pitsati jäljend ning need sedelid pannakse koos
						eelhääletanute hääletamissedelitega pärast § 58 lõikes 4 nimetatud kokkuvõtte koostamist valimispäeval hääletanute sedelite hulka.
					</p>
					<p>
						<a name="lg271"> </a>(7) Jaoskonnakomisjon teeb kindlaks hääletamiskastides olnud sedelite arvu, sealhulgas kehtetute sedelite arvu, ning kandidaatidele ja erakondadele antud häälte arvu ning
						kannab need vormikohasesse protokolli.
					</p>
					<p>
						<a name="lg272"> </a>(8) Kehtetuks tunnistatakse hääletamissedel:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>millel ei ole jaoskonnakomisjoni pitsati kaht jäljendit,<br />
						<a name=""> </a>2)<span class="tyhik"> </span>millele ei ole kirjutatud ühegi kandidaadi registreerimisnumbrit või millele on neid kirjutatud rohkem kui üks,<br />
						<a name=""> </a>3)<span class="tyhik"> </span>millele kirjutatud numbriga kandidaat ei kandideeri selles valimisringkonnas,<br />
						<a name=""> </a>4)<span class="tyhik"> </span>millele kirjutatud kandidaadi registreerimisnumber on parandatud või<br />
						<a name=""> </a>5)<span class="tyhik"> </span>millele kirjutatud kandidaadi registreerimisnumber ei ole loetav.
					</p>
					<p>
						<a name="lg273"> </a>(9) Kui hääletamissedelile ei ole kirjutatud ühegi kandidaadi registreerimisnumbrit, kuid valija tahe on üheselt arusaadav, loetakse hääletamissedel kehtivaks.
					</p>
					<p>
						<a name="lg274"> </a>(10) Hääletamistulemuste kindlakstegemise kohta koostatakse vormikohane protokoll. Protokollile kirjutab alla komisjoni esimees. Protokolli märgitakse selle koostamise
						kuupäev ja kellaaeg.
					</p>
					<p>
						<a name="lg275"> </a>(11) Pärast hääletamistulemuste kindlakstegemist pakitakse kehtivad sedelid kandidaatide kaupa. Eraldi pakkidesse pannakse kehtetud sedelid, valijatele välja andmata jäänud
						sedelid ja valijate tagastatud rikutud sedelid. Pakile märgitakse, millise valimisjaoskonna sedelid, millised ja kui palju neid pakis on. Märkele kirjutab alla jaoskonnakomisjoni esimees.
					</p>
					<p>
						<a name="lg276"> </a>(12) Hääletamissedelid, valijate nimekirjad, hääletamistulemuste protokollid ja komisjoniliikmete eriarvamused edastatakse viivitamata maakonna valimiskomisjonile.
					</p>
					<p>
						<a name="lg277"> </a>(13) Hääletamistulemused tehakse jaoskonnakomisjonis kindlaks avalikult.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 58.</strong><a name="para60"> </a>Eelhääletamisel antud häälte lugemine
					</h3>
					<p>
						<a name="lg278"> </a>(1) Jaoskonnakomisjon avab eelhääletamisel kasutatud hääletamiskasti häälte lugemiseks valimispäeval pärast kella 19.00. Avamise juures peavad olema vähemalt kolm komisjoni
						liiget või asendusliiget.
					</p>
					<p>
						<a name="lg279"> </a>(2) Eelhääletamisel antud hääled loetakse hääletamisruumist eraldi ruumis.
					</p>
					<p>
						<a name="lg280"> </a>(3) Väljaspool elukohajärgset valimisjaoskonda hääletanute hääletamissedeleid sisaldavad sisemised ümbrikud avatakse ning neid arvestatakse eelhääletamise tulemuste
						kokkuvõtete tegemisel ja hoitakse eraldi teistest hääletamissedelitest kuni neile jaoskonnakomisjoni pitsati jäljendi panemiseni.
					</p>
					<p>
						<a name="lg281"> </a>(4) Eelhääletamise tulemuste kohta koostatakse kokkuvõte, millele kirjutab alla komisjoni esimees. Eelhääletamise tulemused edastatakse viivitamata maakonna
						valimiskomisjonile või Vabariigi Valimiskomisjonile.
					</p>
					<p>
						<a name="lg282"> </a>(5) Eelhääletamise tulemusi ei avaldata enne kella 20.00.
					</p>
					<p>
						<a name="lg283"> </a>(6) Eelhääletamisel antud häälte lugemine valimisjaoskonnas on avalik. Häälte lugemise juures viibivad isikud peavad täitma jaoskonnakomisjoni liikmete suulisi korraldusi.
						Häältelugemise juures viibivad isikud ei või võtta ruumi, kus hääli loetakse, kaasa sidevahendeid ega lahkuda sealt enne kella 20.00.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 59.</strong><a name="para61"> </a>Alaliselt välisriigis elavate valijate hääletamistulemuste kindlakstegemine
					</h3>
					<p>
						<a name="lg284"> </a>(1) Alaliselt välisriigis elavate valijate häälte lugemist alustab käesoleva seaduse § 55 lõikes 4 määratud maakonna valimiskomisjon valimispäeval kell 19.00. Ümbrike
						avamise juures peavad viibima vähemalt kolm maakonna valimiskomisjoni liiget, sealhulgas komisjoni esimees või aseesimees.
					</p>
					<p>
						<a name="lg285"> </a>(2) Alaliselt välisriigis elavate valijate hääletamissedeleid sisaldavad sisemised ümbrikud avatakse ning hääletamissedelite välisküljele pannakse pitsati jäljend.
					</p>
					<p>
						<a name="lg286"> </a>(3) Maakonna valimiskomisjon teeb hääletamissedelite alusel kindlaks hääletamisest osavõtnud alaliselt välisriigis elavate valijate arvu, kehtetuks tunnistatud
						hääletamissedelite arvu ning kandidaatidele ja erakondadele antud häälte arvu. Hääletamissedeli kehtetuks tunnistamisel järgitakse käesoleva seaduse § 57 lõigetes 8 ja 9 ettenähtut.
					</p>
					<p>
						<a name="lg287"> </a>(4) Alaliselt välisriigis elavate valijate hääletamistulemusi ei avaldata enne kella 20.00.
					</p>
					<p>
						<a name="lg288"> </a>(5) Alaliselt välisriigis elavate valijate hääletamistulemuste kindlakstegemise kohta koostatakse vormikohane protokoll. Protokollile kirjutab alla komisjoni esimees.
						Protokolli märgitakse selle koostamise kuupäev ja kellaaeg.
					</p>
					<p>
						<a name="lg289"> </a>(6) Alaliselt välisriigis elavate valijate hääletamistulemused tehakse kindlaks avalikult, arvestades käesoleva seaduse § 58 lõikes 6 ettenähtud piiranguid.
					</p>
					<h3>
						<strong>§ 60.</strong><a name="para62"> </a>Hääletamistulemuste kindlakstegemine maakonna valimiskomisjonis
					</h3>
					<p>
						<a name="lg290"> </a>(1) Jaoskonnakomisjonidelt laekunud protokollide alusel teeb maakonna valimiskomisjon kindlaks valijate nimekirjadesse kantud valijate arvu, hääletamissedeli saanud valijate
						arvu, hääletamiskastides olnud sedelite arvu, sealhulgas kehtetute sedelite arvu, ning kandidaatidele ja erakondadele antud häälte arvu ning kannab need vormikohasesse protokolli. Saadud
						tulemust kontrollitakse hääletamissedelite ülelugemise teel.
					</p>
					<p>
						<a name="lg291"> </a>(2) Kui hääletamissedelite ülelugemise teel saadud arvud erinevad jaoskonnakomisjoni protokollis olevatest, märgib maakonna valimiskomisjon oma protokolli lisas erinevused
						ning neid tinginud asjaolud. Jaoskonnakomisjoni protokolli ei muudeta. Lõplike hääletamistulemuste kohta teeb otsustuse maakonna valimiskomisjon.
					</p>
					<p>
						<a name="lg292"> </a>(3) Maakonna, Tallinna iga valimisringkonna ja Tartu linna hääletamistulemuste kohta koostab maakonna valimiskomisjon protokolli, millele kirjutab alla komisjoni esimees.
						Protokolli märgitakse selle koostamise kuupäev ja kellaaeg.
					</p>
					<p>
						<a name="lg293"> </a>(4) Hääletamistulemused tehakse maakonna valimiskomisjonis kindlaks avalikult.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 60<sup>1</sup>.
						</strong><a name="para63"> </a>Elektrooniliselt antud häälte lugemine
					</h3>
					<p>
						<a name="lg294"> </a>(1) Vabariigi Valimiskomisjon teeb elektroonilise hääletamise tulemused kindlaks valimispäeval pärast kella 19.00.
					</p>
					<p>
						<a name="lg295"> </a>(2) Häälte lugemise juures peab viibima vähemalt pool Vabariigi Valimiskomisjoni koosseisust, sealhulgas komisjoni esimees või aseesimees.
					</p>
					<p>
						<a name="lg296"> </a>(3) Hääletamistulemused tehakse Vabariigi Valimiskomisjonis kindlaks avalikult, käesoleva seaduse § 58 lõikes 6 sätestatud piiranguid arvestades.
					</p>
					<p>
						<a name="lg297"> </a>(4) Hääletamistulemusi ei avalikustata enne kella 20.00.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 61.</strong><a name="para64"> </a>Hääletamistulemuste kindlakstegemine Vabariigi Valimiskomisjonis
					</h3>
					<p>
						<a name="lg298"> </a>(1) Kõigilt maakonna valimiskomisjonidelt laekunud maakonna ning alaliselt välisriigis elavate valijate hääletamistulemuste protokollide ning elektrooniliselt hääletanud
						valijate hääletamistulemuste alusel teeb Vabariigi Valimiskomisjon valimisringkondade kaupa kindlaks valijate nimekirjadesse kantud valijate arvu, hääletamissedeli saanud valijate arvu,
						hääletamisest osavõtnud valijate arvu, kehtetute hääletamissedelite arvu ning kandidaatidele ja erakondadele antud häälte arvu.
					</p>
					<p>
						<a name="lg299"> </a>(2) Hääletamistulemuste kohta koostab Vabariigi Valimiskomisjon protokolli, millele kirjutab alla komisjoni esimees. Protokolli märgitakse selle koostamise kuupäev ja
						kellaaeg.
					</p>
					<p>
						<a name="lg300"> </a>(3) <span class="mm">[Kehtetu – <a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<p>
						<a name="lg301"> </a>(4) Hääletamistulemuste kindlakstegemine Vabariigi Valimiskomisjonis on avalik.
					</p>
					<h3>
						<strong>§ 62.</strong><a name="para65"> </a>Valimistulemuste kindlakstegemine
					</h3>
					<p>
						<a name="lg302"> </a>(1) Iga valimisringkonna kohta arvutatakse lihtkvoot, mis saadakse valimisringkonnas antud kehtivate häälte arvu jagamisel selle ringkonna mandaatide arvuga.
					</p>
					<p>
						<a name="lg303"> </a>(2) Valituks osutub kandidaat, kellele antud häälte arv ületab lihtkvoodi või on sellega võrdne.
					</p>
					<p>
						<a name="lg304"> </a>(3) Nende erakondade ringkonnanimekirjades, kelle kandidaadid kogusid üleriigiliselt kokku vähemalt 5 protsenti häältest, reastatakse kandidaadid vastavalt igaühele antud
						häälte arvule. Sama erakonna ringkonnanimekirjas olevate kandidaatide hääled liidetakse. Erakond saab nii mitu mandaati, kui mitu korda ületab temale selles valimisringkonnas antud häälte arv
						lihtkvoodi. Erakonna mandaadiks loetakse ka käesoleva paragrahvi lõike 2 alusel saadud mandaati. Erakonna mandaatide arvu suurendatakse ühe võrra, kui häälte jääk moodustab vähemalt 75 protsenti
						lihtkvoodist. Erakond saab mandaadi ka juhul, kui häälte arv moodustab vähemalt 75 protsenti lihtkvoodist. Valituks osutuvad nimekirjas eespool olevad kandidaadid, kellele antud häälte arv on
						vähemalt 10 protsenti lihtkvoodist. Kui vähemalt kahele kandidaadile on antud võrdne arv hääli, osutub valituks kandidaatide üleriigilises nimekirjas eespool olev kandidaat.
					</p>
					<p>
						<a name="lg305"> </a>(4) Valimisringkondades lihtkvoodi alusel jaotamata jäänud mandaadid jaotatakse kompensatsioonimandaatidena nende erakondade vahel, kelle kandidaadid kogusid üleriigiliselt
						kokku vähemalt 5 protsenti häältest.
					</p>
					<p>
						<a name="lg306"> </a>(5) Kompensatsioonimandaadid jaotatakse modifitseeritud d’Hondti jagajate meetodil jagajate jadadega 1, 2<sup>0,9</sup>, 3<sup>0,9</sup>, 4<sup>0,9</sup> jne. Seejuures
						jäetakse iga erakonna võrdlusarvude arvutamisel vahele nii mitu jada esimest elementi, kui mitu mandaati sai erakond valimisringkondades. Kui vähemalt kahe erakonna võrdlusarvud on võrdsed, saab
						mandaadi erakond, kelle kandidaadid paiknesid valimisringkonna kandidaatide koondnimekirjas tagapool.
					</p>
					<p>
						<a name="lg307"> </a>(6) Kandidaatide üleriigilises nimekirjas saab kompensatsioonimandaadi kandidaat, kes on nimekirjas eespool ja kellele antud häälte arv on vähemalt 5 protsenti lihtkvoodist.
						Mandaatide jaotamisel jäetakse vahele need kandidaadid, kes osutusid valituks valimisringkondades.
					</p>
					<p>
						<a name="lg308"> </a>(7) Kui kompensatsioonimandaatide jaotamisel selgub, et üleriigilises nimekirjas ei ole piisavalt kandidaate, kellele antud häälte arv oli vähemalt 5 protsenti oma
						valimisringkonna lihtkvoodist, saab kompensatsioonimandaadi oma valimisringkonna lihtkvoodist enima häälteprotsendi kogunud sama nimekirja kandidaat. Häälte võrdsuse korral saab
						kompensatsioonimandaadi kandidaat, kes on esitatud nimekirjas eespool.
					</p>
					<p>
						<a name="lg309"> </a>(8) Erakond ei või saada rohkem mandaate, kui on tema nimekirjas kandidaate.
					</p>
					<p>
						<a name="lg310"> </a>(9) Kui erakonna kandidaadi registreerimise otsus tühistatakse (§ 32 lg 5), jäävad temale välisriigis antud hääled erakonnale. Samuti jäävad erakonnale selle kandidaadi
						hääled, kes sureb pärast eelhääletamise algust. Kui üksikkandidaadi registreerimise otsus tühistatakse või kui ta sureb, siis temale antud hääli valimistulemuste kindlakstegemisel ei arvestata.
					</p>
					<p>
						<a name="lg311"> </a>(10) Valimistulemuste kohta koostab Vabariigi Valimiskomisjon protokolli, millele kirjutab alla komisjoni esimees. Protokolli märgitakse selle koostamise kuupäev ja
						kellaaeg.
					</p>
					<p>
						<a name="lg312"> </a>(11) Valimistulemused tehakse Vabariigi Valimiskomisjonis kindlaks avalikult.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>10. peatükk </span>RIIGIKOGU ERAKORRALISTE VALIMISTE ERISUSED<a name="ptk10"> </a>
					</h2>
					<h3>
						<strong>§ 63.</strong><a name="para66"> </a>Riigikogu erakorraliste valimiste erisused
					</h3>
					<p>
						<a name="lg313"> </a>(1) Riigikogu erakorralised valimised viiakse läbi käesoleva seaduse kohaselt käesolevas peatükis ettenähtud erisusi arvestades.
					</p>
					<p>
						<a name="lg314"> </a>(2) Vabariigi Valimiskomisjon kehtestab oma otsusega Riigikogu erakorraliste valimiste toimingute järgmised tähtajad:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>hääleõiguslike Eesti kodanike arvu esitamine (§ 7 lg 3);<br />
						<a name=""> </a>2)<span class="tyhik"> </span>valimisjaoskondade jaotuse muutmine (§ 8 lg 3 ja 4);<br />
						<a name=""> </a>3)<span class="tyhik"> </span>jaoskonnakomisjonide moodustamine (§ 18);<br />
						<a name=""> </a>4)<span class="tyhik"> </span>valijakaardi saatmine (§ 21);<br />
						<a name=""> </a>5)<span class="tyhik"> </span>erakondade nimekirja esitamine (§ 26 lg 2);<br />
						<a name=""> </a>6)<span class="tyhik"> </span>kandidaatide registreerimiseks esitamine (§ 30);<br />
						<a name=""> </a>7)<span class="tyhik"> </span>kandidaatide registreerimine (§ 32);<br />
						<a name=""> </a>7<sup>1</sup>)<span class="tyhik"> </span>eelhääletamise aeg (§ 38 lg 2);<br />
						<a name=""> </a>8)<span class="tyhik"> </span>valijakaardi saatmine välisriigis ajutiselt elavale valijale (§ 49 lg 5);<br />
						<a name=""> </a>9)<span class="tyhik"> </span>kirja teel hääletamise taotluste välisesindustele esitamine (§ 50);<br />
						<a name=""> </a>10)<span class="tyhik"> </span>kirja teel hääletamise hääletamissedelite laekumine (§ 52 lg 2);<br />
						<a name=""> </a>11)<span class="tyhik"> </span>välisesinduses hääletamise aeg (§ 54 lg 2).
					</p>
					<p>
						<a name="lg315"> </a>(3) Riigikogu erakorraliste valimiste korral peab kandidaatide registreerimiseks esitamiseks ja registreerimiseks jääma kokku vähemalt kümme päeva.
					</p>
					<p>
						<a name="lg316"> </a>(4) Erakorraliste valimiste korral kantakse valija selle valimisjaoskonna nimekirja, mille territooriumil valimiste väljakuulutamise päeval asub tema rahvastikuregistrisse
						kantud elukoht. Kui valija elukoha aadressiandmed on kantud rahvastikuregistrisse valla või linna, Tallinnas linnaosa täpsusega, kantakse valija käesoleva seaduse § 8 lõike 2 punkti 5 alusel
						määratud valimisjaoskonna valijate nimekirja.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/704851">RT I 2004, 6, 32</a> - jõust. 14.02.2004]
						</span>
					</p>
					<h2 class="level2">
						<span>11. peatükk </span>VALIMISTE KULUD<a name="ptk11"> </a>
					</h2>
					<h3>
						<strong>§ 64.</strong><a name="para67"> </a>Valimiste korraldamise kulud
					</h3>
					<p>
						<a name="lg317"> </a>(1) Riigikogu valimiste ettevalmistamise ja korraldamise kulud kaetakse riigieelarvest.
					</p>
					<p>
						<a name="lg318"> </a>(2) Vabariigi Valimiskomisjon koostab valimiskulude eelarve projekti.
					</p>
					<p>
						<a name="lg319"> </a>(3) Vabariigi Valimiskomisjon otsustab eelarve kulude jaotuse, lähtudes riigieelarves määratud eraldiste suurusest.
					</p>
					<p>
						<a name="lg320"> </a>(4) Valijate arvestusega (5. peatükk) seotud kulud kaetakse riigieelarvest Siseministeeriumi eelarves selleks ettenähtud rahast.
					</p>
					<h3>
						<strong>§ 65.</strong><a name="para68"> </a>Erakonna ja üksikkandidaadi valimiskampaania rahastamise aruanne
					</h3>
					<p>
						<a name="lg321"> </a>(1) Erakond ja üksikkandidaat esitavad korruptsioonivastase seaduse § 14 lõikes 2 nimetatud Riigikogu komisjonile ühe kuu jooksul, arvates valimispäevast, aruande
						valimiskampaania kulude ning kasutatud vahendite päritolu kohta (edaspidi <i>aruanne</i>). Korruptsioonivastase seaduse § 14 lõikes 2 nimetatud Riigikogu komisjon avalikustab aruanded.
					</p>
					<p>
						<a name="lg322"> </a>(2) Kui erakonna nimekirjas kandideerinud isik tegi valimiskampaaniaks kulutusi erakonna kampaania kuludest eraldi, peab aruanne sisaldama andmeid ka nende kulude kohta.
						Nimetatud kuludele kohaldatakse erakonna aruande kohta ettenähtut.
					</p>
					<p>
						<a name="lg323"> </a>(3) <span class="mm">[Kehtetu – <a href="https://www.riigiteataja.ee/akt/691976">RT I 2003, 90, 601</a> - jõust. 01.01.2004]
						</span>
					</p>
					<p>
						<a name="lg324"> </a>(4) Aruanne koosneb vahendite päritolu osast ja kulude osast.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/691976">RT I 2003, 90, 601</a> - jõust. 01.01.2004]
						</span>
					</p>
					<h3>
						<strong>§ 66.</strong><a name="para69"> </a>Valimiskampaaniaks kasutatud vahendid
					</h3>
					<p>
						<a name="lg325"> </a>(1) Erakond ja üksikkandidaat märgivad aruandes:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>vahendite laekumise kuupäeva;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>vahendite liigi;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>vahendite väärtuse kroonides;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>vahendite eraldaja nime ja isiku- või registrikoodi.
					</p>
					<p>
						<a name="lg326"> </a>(2) Erakonnale laekunud vahendite liigid on:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>erakonna põhikirjaga kehtestatud liikmemaksud;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>füüsiliste isikute annetused;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>eraldised riigieelarvest;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>tulu erakonna varalt;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>laen või krediit erakonnaseaduse (RT I 1994, 40, 654; 1996, 37, 739; 42, 811; 1998, 59, 941; 1999, 27, 393; 2002, 21, 117; 29, 174; 42, 264; 57,
						355; 102, 602; 2003, 4, 22; 90, 601) § 12<sup>1</sup> lõikes 4 sätestatud tingimustel.
					</p>
					<p>
						<a name="lg327"> </a>(3) Üksikkandidaadile laekunud vahendite liigid on:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>annetus (rahaline annetus, mitterahaline annetus ja tegevustoetus);<br />
						<a name=""> </a>2)<span class="tyhik"> </span>pärand;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>laen;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>isiklikud vahendid.
					</p>
					<p>
						<a name="lg328"> </a>(4) Anonüümsed ja varjatud annetused on keelatud.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/704851">RT I 2004, 6, 32</a> - jõust. 14.02.2004]
						</span>
					</p>
					<h3>
						<strong>§ 67.</strong><a name="para70"> </a>Valimiskampaania kulud
					</h3>
					<p>
						<a name="lg329"> </a>(1) Erakond ja üksikkandidaat märgivad aruandes:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>kulutuse tegemise kuupäeva;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>makse saaja nime ja isiku- või registrikoodi;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>makse aluseks oleva arve numbri;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>kululiigi;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>makse summa kroonides.
					</p>
					<p>
						<a name="lg330"> </a>(2) Kulude liigid on:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>reklaamikulud (eraldi märgitakse kulutused trükistele, telereklaamile, raadioreklaamile ning reklaamile ajalehtedes ja ajakirjades);<br />
						<a name=""> </a>2)<span class="tyhik"> </span>suhtekorralduskulud;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kulud publikatsioonidele;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>transpordikulud;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>rendikulud;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>avalike ürituste korraldamise kulud;<br />
						<a name=""> </a>7)<span class="tyhik"> </span>sidekulud;<br />
						<a name=""> </a>8)<span class="tyhik"> </span>postikulud;<br />
						<a name=""> </a>9)<span class="tyhik"> </span>muud kulud.
					</p>
					<p>
						<a name="lg331"> </a>(3) Kuluaruandes märgitakse ka andmed tasumata lepinguliste maksete ja maksmata arvete kohta. Tasumata lepinguliste maksete ja maksmata arvete tasumise kohta esitavad
						erakond ja üksikkandidaat täiendava aruande.
					</p>
					<h2 class="level2">
						<span>12. peatükk </span>KAEBUSED<a name="ptk12"> </a>
					</h2>
					<h3>
						<strong>§ 68.</strong><a name="para71"> </a>Kaebuse mõiste
					</h3>
					<p>
						<a name="lg332"> </a> Käesoleva seaduse tähenduses on kaebus maakonna valimiskomisjonile või Vabariigi Valimiskomisjonile esitatav käesoleva seaduse nõuete kohaselt vormistatud taotlus vaadata
						läbi ja tühistada valimiskomisjoni otsus või tunnistada seadusevastaseks valimiskomisjoni toiming.
					</p>
					<h3>
						<strong>§ 69.</strong><a name="para72"> </a>Kaebusele esitatavad nõuded
					</h3>
					<p>
						<a name="lg333"> </a>(1) Kaebus vormistatakse kirjalikult ning selles märgitakse:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>selle organi nimi, kellele kaebus esitatakse;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kaebuse esitaja nimi, postiaadress ja sidevahendite numbrid;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>andmed vaidlustatava otsuse kohta või vaidlustatava toimingu kirjeldus;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>selgelt väljendatud taotlus;<br />
						<a name=""> </a>5)<span class="tyhik"> </span>kaebuse põhistus;<br />
						<a name=""> </a>6)<span class="tyhik"> </span>kuupäev.
					</p>
					<p>
						<a name="lg334"> </a>(2) Kaebusele kirjutab alla selle esitaja. Erakonna kaebusele kirjutab alla erakonna volitatud esindaja.
					</p>
					<p>
						<a name="lg335"> </a>(3) Kui kaebus ei vasta käesoleva paragrahvi lõigetes 1 ja 2 ettenähtud nõuetele või kui kaebus on esitatud käesoleva seaduse §-des 70 ja 71 ettenähtud korda rikkudes, võib
						organ, kellele kaebus esitatakse, jätta selle läbi vaatamata ning tagastada kaebuse selle esitajale.
					</p>
					<h3>
						<strong>§ 70.</strong><a name="para73"> </a>Jaoskonnakomisjoni toimingu peale kaebuse esitamise ja kaebuse läbivaatamise kord
					</h3>
					<p>
						<a name="lg336"> </a>(1) Kui üksikisik, kandidaat või erakond (edaspidi <i>huvitatud isik</i>) leiab, et jaoskonnakomisjoni toiminguga rikutakse tema õigusi, võib ta esitada kaebuse maakonna
						valimiskomisjonile.
					</p>
					<p>
						<a name="lg337"> </a>(2) Kaebus tuleb esitada maakonna valimiskomisjonile kolme päeva jooksul, arvates käesoleva paragrahvi lõikes 1 ettenähtud toimingu tegemisest.
					</p>
					<p>
						<a name="lg338"> </a>(3) Maakonna valimiskomisjon peab kaebuse läbi vaatama ja selle kohta otsuse tegema kolme tööpäeva jooksul, arvates kaebuse laekumisest. Maakonna valimiskomisjon edastab
						otsuse kaebuse esitajale viivitamata.
					</p>
					<p>
						<a name="lg339"> </a>(4) Kaebus vaadatakse läbi avalikult. Maakonna valimiskomisjon teatab kaebuse esitajale kaebuse läbivaatamise aja ja koha.
					</p>
					<p>
						<a name="lg340"> </a>(5) Maakonna valimiskomisjon teeb ühe järgmistest otsustest:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>jätta kaebus rahuldamata;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kaebus rahuldada;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kaebus rahuldada osaliselt.
					</p>
					<p>
						<a name="lg341"> </a>(6) Kui maakonna valimiskomisjon kaebuse rahuldab, võib ta otsustada teha käesoleva seaduse § 17 lõikes 2 loetletud toiminguid.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 71.</strong><a name="para74"> </a>Maakonna valimiskomisjoni otsuse või toimingu peale kaebuse esitamise ja kaebuse läbivaatamise kord
					</h3>
					<p>
						<a name="lg342"> </a>(1) Kui huvitatud isik leiab, et maakonna valimiskomisjoni otsuse või toiminguga rikutakse tema õigusi, võib ta esitada kaebuse Vabariigi Valimiskomisjonile. Isik, kelle
						jaoskonnakomisjoni toimingu peale esitatud kaebuse jättis maakonna valimiskomisjon rahuldamata, võib kaebuse jaoskonnakomisjoni toimingu peale esitada Vabariigi Valimiskomisjonile.
					</p>
					<p>
						<a name="lg343"> </a>(2) Kaebus esitatakse vaidlustatava otsuse või toimingu teinud või vaidlustatud toimingu peale esitatud kaebuse läbi vaadanud maakonna valimiskomisjonile käesoleva
						paragrahvi lõikes 1 ettenähtud otsuse või toimingu tegemisest alates kolme päeva jooksul. Maakonna valimiskomisjon edastab kaebuse omapoolse kirjaliku selgitusega viivitamata Vabariigi
						Valimiskomisjonile.
					</p>
					<p>
						<a name="lg344"> </a>(3) Vabariigi Valimiskomisjon peab kaebuse läbi vaatama ja selle suhtes otsuse tegema kolme tööpäeva jooksul, arvates kaebuse laekumisest. Vabariigi Valimiskomisjon edastab
						otsuse kaebuse esitajale viivitamata.
					</p>
					<p>
						<a name="lg345"> </a>(4) Kaebus vaadatakse läbi avalikult. Vabariigi Valimiskomisjon teatab kaebuse esitajale kaebuse läbivaatamise aja ja koha.
					</p>
					<p>
						<a name="lg346"> </a>(5) Vabariigi Valimiskomisjon teeb ühe järgmistest otsustest:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>jätta kaebus rahuldamata;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>kaebus rahuldada;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>kaebus rahuldada osaliselt.
					</p>
					<p>
						<a name="lg347"> </a>(6) Kui Vabariigi Valimiskomisjon kaebuse rahuldab, võib ta otsustada teha käesoleva seaduse § 15 lõikes 2 loetletud toiminguid.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 72.</strong><a name="para75"> </a>Vabariigi Valimiskomisjoni otsuse või toimingu peale kaebuse esitamine
					</h3>
					<p>
						<a name="lg348"> </a>(1) Kui huvitatud isik leiab, et jaoskonnakomisjoni toiminguga, maakonna valimiskomisjoni otsuse või toiminguga või Vabariigi Valimiskomisjoni otsuse või toiminguga
						rikutakse tema õigusi, võib ta esitada põhiseaduslikkuse järelevalve kohtumenetluse seaduses (RT I 2002, 29, 174) ettenähtud korras kaebuse Riigikohtule.
					</p>
					<p>
						<a name="lg349"> </a>(2) Kaebuse valimiskomisjoni otsuse või toimingu peale võib Riigikohtule esitada pärast asja lahendamist Vabariigi Valimiskomisjonis. Kaebus esitatakse Riigikohtule kolme
						päeva jooksul Vabariigi Valimiskomisjoni otsuse teatavakstegemisest või toimingu sooritamisest arvates Vabariigi Valimiskomisjoni kaudu.
					</p>
					<h3>
						<strong>§ 73.</strong><a name="para76"> </a>Hääletamistulemuste kehtetuks tunnistamine
					</h3>
					<p>
						<a name="lg350"> </a>(1) Kui Vabariigi Valimiskomisjon või Riigikohus on tunnistanud valimisjaoskonna või valimisringkonna või maakonna või Tallinna või Tartu linna või riigi hääletamistulemused
						kehtetuks, määrab Vabariigi Valimiskomisjon uue valimispäeva ja asjaomases valimisjaoskonnas või valimisringkonnas või maakonnas või Tallinnas või Tartu linnas või riigis korraldatakse
						kordushääletamine. Riigikogu valimiste tulemus tehakse kindlaks pärast kordushääletamise tulemuste selgumist.
					</p>
					<p>
						<a name="lg351"> </a>(1<sup>1</sup>) Kordushääletamist ei korraldata, kui Vabariigi Valimiskomisjon on tunnistanud elektroonilise hääletamise tulemused kehtetuks ja kutsunud elektrooniliselt
						hääletanud valijaid hääletama valimispäeval käesoleva seaduse §-s 39 või 46 ettenähtud korras.
					</p>
					<p>
						<a name="lg352"> </a>(2) Kordushääletamisel käesoleva seaduse §-des 40–45, 47 ning 8. peatükis ettenähtut ei kohaldata.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>12<sup>1</sup>. peatükk
						</span>VASTUTUS<a name="ptk13"> </a><br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/264747">RT I 2003, 26, 156</a> - jõust. 21.03.2003]
						</span>
					</h2>
					<h3>
						<strong>§ 73<sup>1</sup>.
						</strong><a name="para77"> </a>Andmete või materjalide esitamata jätmine või valimiskomisjoni otsuse mittetäitmine
					</h3>
					<p>
						<a name="lg353"> </a>(1) Andmete või materjalide esitamata jätmise eest valimiste korraldamiseks, samuti valimiskomisjoni otsuse mittetäitmise eest – karistatakse rahatrahviga kuni 20
						trahviühikut.
					</p>
					<p>
						<a name="lg354"> </a>(2) Käesoleva paragrahvi lõikes 1 sätestatud väärteole kohaldatakse karistusseadustiku (RT I 2001, 61, 364; 2002, 82, 480; 86, 504; 105, 612; 2003, 4, 22) üldosa ja
						väärteomenetluse seadustiku (RT I 2002, 50, 313; 110, 654) sätteid.
					</p>
					<p>
						<a name="lg355"> </a>(3) Käesoleva paragrahvi lõikes 1 sätestatud väärteo kohtuväline menetleja on politseiprefektuur.
					</p>
					<h3>
						<strong>§ 73<sup>2</sup>.
						</strong><a name="para78"> </a>Poliitilisele välireklaamile kehtestatud piirangute rikkumine
					</h3>
					<p>
						<a name="lg356"> </a>(1) Poliitilise välireklaami avalikustamisele kehtestatud piirangute rikkumise eest – karistatakse rahatrahviga kuni 300 trahviühikut.
					</p>
					<p>
						<a name="lg357"> </a>(2) Sama teo eest, kui selle on toime pannud juriidiline isik, – karistatakse rahatrahviga kuni 50 000 krooni.
					</p>
					<p>
						<a name="lg358"> </a>(3) Poliitilisele välireklaamile kehtestatud nõuete täitmata jätmise või kehtestatud piirangutest üleastumise eest vastutavad reklaami avalikustajatena käesolevas seaduses
						sätestatud korras:<br />
						<a name=""> </a>1)<span class="tyhik"> </span>reklaami tellija, kui tema tellitud reklaam rikub käesoleva seadusega reklaamile kehtestatud nõudeid või piiranguid, välja arvatud käesoleva lõike
						punktides 2 ja 4 sätestatud juhtudel;<br />
						<a name=""> </a>2)<span class="tyhik"> </span>reklaami vahendaja või tootja, kui tema tegevus rikub käesoleva seadusega reklaamile kehtestatud nõudeid või piiranguid;<br />
						<a name=""> </a>3)<span class="tyhik"> </span>reklaami avalik esitaja, üldsusele näitaja või üldsusele ülekandja, kui tema tegevus rikub käesoleva seadusega reklaami avalikustamisele kehtestatud
						piiranguid;<br />
						<a name=""> </a>4)<span class="tyhik"> </span>käesoleva lõike punktides 1–3 nimetatud reklaami avalikustajad solidaarselt, kui nende tegevus rikub käesoleva seadusega reklaamile kehtestatud
						nõudeid või piiranguid ning nende eraldi vastutust ei ole võimalik tuvastada.
					</p>
					<p>
						<a name="lg359"> </a>(4) Käesoleva paragrahvi lõigetes 1 ja 2 sätestatud väärteole kohaldatakse karistusseadustiku (RT I 2001, 61, 364; 2002, 86, 504; 82, 480; 105, 612; 2003, 4, 22; 83, 557;
						90, 601; 2004, 7, 40; 46, 329; 54, 387; 56, 401; 88, 600; 2005, 20, 126) üldosa ja väärteomenetluse seadustiku (RT I 2002, 50, 313; 110, 654; 2003, 26, 156; 83, 557; 88, 590; RT III 2004, 9, 96;
						RT I 2004, 46, 329; 54, 387 ja 390; 56, 403) sätteid.
					</p>
					<p>
						<a name="lg360"> </a>(5) Käesoleva paragrahvi lõigetes 1 ja 2 sätestatud väärteo kohtuväline menetleja on politseiprefektuur.
					</p>
					<p>
						<a name="lg361"> </a>(6) Käesoleva paragrahvi lõigetes 1 ja 2 sätestatud väärteoasju arutab maa- või linnakohus.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/914829">RT I 2005, 37, 281</a> - jõust. 10.07.2005]
						</span>
					</p>
					<h3>
						<strong>§ 73<sup>3</sup>.
						</strong><a name="para79"> </a>Hääletamissedeli hääletamisruumist väljaviimine
					</h3>
					<p>
						<a name="lg362"> </a>(1) Hääletamissedeli hääletamisruumist väljaviimise keelu rikkumise eest – karistatakse rahatrahviga kuni 20 trahviühikut.
					</p>
					<p>
						<a name="lg363"> </a>(2) Käesoleva paragrahvi lõikes 1 sätestatud väärteole kohaldatakse karistusseadustiku üldosa ja väärteomenetluse seadustiku sätteid.
					</p>
					<p>
						<a name="lg364"> </a>(3) Käesoleva paragrahvi lõikes 1 sätestatud väärteo kohtuväline menetleja on politseiprefektuur.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h2 class="level2">
						<span>13. peatükk </span>LÕPPSÄTTED<a name="ptk14"> </a>
					</h2>
					<h3>
						<strong>§ 74.</strong><a name="para80"> </a>Riigikogu liikmete registreerimine ja valimistulemuste väljakuulutamine
					</h3>
					<p>
						<a name="lg365"> </a>(1) Vabariigi Valimiskomisjon registreerib valitud Riigikogu liikmed oma otsusega pärast valimispäeva, kui Vabariigi Valimiskomisjonile ja Riigikohtule kaebuste esitamise
						tähtaeg on möödunud või kui esitatud kaebuste kohta on tehtud lõplikud otsused.
					</p>
					<p>
						<a name="lg366"> </a>(2) Käesoleva seaduse §-s 73 ettenähtud juhul registreerib Vabariigi Valimiskomisjon valitud Riigikogu liikmed pärast kordushääletamise päeva, arvestades käesoleva
						paragrahvi lõikes 1 ettenähtut.
					</p>
					<p>
						<a name="lg367"> </a>(3) Valimistulemused loetakse väljakuulutatuks Vabariigi Valimiskomisjoni käesoleva paragrahvi lõikes 1 või 2 märgitud otsuse Riigi Teatajas avaldamisele järgneval päeval.
					</p>
					<h3>
						<strong>§ 75.</strong><a name="para81"> </a>Riigikogu asendusliikmete registreerimine
					</h3>
					<p>
						<a name="lg368"> </a>(1) Vabariigi Valimiskomisjon registreerib Riigikogu asendusliikmed oma otsusega. Vabariigi Valimiskomisjon edastab otsuse Riigikogu juhatusele.
					</p>
					<p>
						<a name="lg369"> </a>(2) Asendusliikmed registreeritakse erakondadele, mille kandidaadid kogusid üleriigiliselt kokku vähemalt 5 protsenti kehtivatest häältest.
					</p>
					<p>
						<a name="lg370"> </a>(3) Valimisringkondades valituks osutunud kandidaatide asendusliikmeteks registreeritakse kandidaadid erakondadele valimisringkondade kaupa, reastatult saadud häälte arvu
						järgi. Kui kandidaadid said valijatelt hääli võrdselt, siis paigutatakse ettepoole kandidaat, kes paiknes erakonna ringkonnanimekirjas eespool. Asendusliikmeks registreeritakse valimata jäänud
						kandidaadid, kellele antud häälte arv on vähemalt 10 protsenti oma ringkonna lihtkvoodist.<br />11.03.2011 10:56<br />Veaparandus – Parandatud täheviga sõnas "Valimisringkondade". Alus: "Riigi
						Teataja seaduse" § 10 lõige 3 ja Riigikogu õiguskomisjoni 08.03.2011 kiri nr 2.6-3/424.
					</p>
					<p>
						<a name="lg371"> </a>(4) Kompensatsioonimandaadi alusel valituks osutunud kandidaatide asendusliikmeteks registreeritakse valimata jäänud kandidaadid, kellele antud häälte arv on vähemalt 5
						protsenti oma ringkonna lihtkvoodist, erakonna üleriigilises nimekirjas määratud järjestuses ja seejärel ülejäänud sama erakonna valimata jäänud kandidaadid reastatult valimisringkonna
						lihtkvoodist arvutatud häälteprotsendi suuruse järgi. Kui kandidaatide häälteprotsendid on võrdsed, siis paigutatakse ettepoole kandidaat, kes paiknes erakonna üleriigilises nimekirjas eespool.
					</p>
					<h3>
						<strong>§ 76.</strong><a name="para82"> </a>Lisamandaatide registreerimine
					</h3>
					<p>
						<a name="lg372"> </a>(1) Lisamandaatide jaotamise aluseks on erakondade võrdlusarvude tabel, mis on kinnitatud Vabariigi Valimiskomisjoni otsusega. Vabariigi Valimiskomisjon edastab otsuse
						Riigikogu juhatusele.
					</p>
					<p>
						<a name="lg373"> </a>(2) Võrdlusarvude tabelis on erakondadele arvutatud võrdlusarvud (§ 62 lg 5) suuruse järjekorras, alates võrdlusarvust, mis esimesena jäi kompensatsioonimandaatide
						jaotamisel arvesse võtmata.
					</p>
					<p>
						<a name="lg374"> </a>(3) Kui vähemalt kaks võrdlusarvu on võrdsed, saab kõrgema järjekoha valijatelt rohkem hääli saanud erakonna võrdlusarv. Kui erakondadele on antud võrdne arv hääli, saab
						kõrgema järjekoha erakond, kelle kandidaadid paiknesid valimisringkonna kandidaatide koondnimekirjas tagapool.<br />
						<span class="mm">[<a href="https://www.riigiteataja.ee/akt/1043129">RT I 2006, 30, 231</a> - jõust. 14.07.2006]
						</span>
					</p>
					<h3>
						<strong>§ 77.</strong><a name="para83"> </a>Kautsjoni tagasimaksmine
					</h3>
					<p>
						<a name="lg375"> </a> Üksikkandidaadile või erakonnale makstakse kautsjon tagasi, kui kandidaat osutub valituks või saab valimisringkonnas hääli vähemalt poole lihtkvoodi ulatuses või kui
						erakonna kandidaadid kogusid üleriigiliselt kokku vähemalt 5 protsenti häältest. Tagastamata kautsjoni kannab Vabariigi Valimiskomisjon riigituludesse.
					</p>
					<h3>
						<strong>§ 78.</strong><a name="para84"> </a>Elektroonilise hääletamise rakendamine
					</h3>
					<p>
						<a name="lg376"> </a> Elektroonilist hääletamist ei rakendata enne 2005. aastat.
					</p>
					<p class="paragraph">
						<strong>§ 79–85.</strong><a name="para85"> </a>[Käesolevast tekstist välja jäetud]
					</p>
					<h3>
						<strong>§ 86.</strong><a name="para86"> </a>Seaduse jõustumine
					</h3>
					<p>
						<a name="lg377"> </a> Käesolev seadus jõustub kümnendal päeval pärast Riigi Teatajas avaldamist, välja arvatud §-d 75 ja 79, mis jõustuvad 2003. aasta 2. märtsil.
					</p>
				</div>

				<p id="agreeNotice">Vajutades kandideerimise nuppu kinnitate, et olete tutvunud ning nõustute kandideerimise tingimustega</p>
				<div id="buttonLoader">
					<a href="javascript:void(0);" id="candidatebutton" class="button">Kandideeri!</a>
				</div>
			</div> <!--content-->
		</div> <!--applypage-->

		<jsp:include page="/footer.jsp" />
	</div>
	<!-- wrapper -->
	<script type="text/javascript" src="/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src='/js/popbox.js'></script>
	<script type="text/javascript" src="/js/ketchup/jquery.ketchup.js"></script>
	<script type="text/javascript" src="/js/ketchup/jquery.ketchup.helpers.js"></script>
	<script type="text/javascript" src="/js/ketchup/jquery.ketchup.validations.js"></script>
	<script type="text/javascript" src="/js/easy.notification.js"></script>
	<script type="text/javascript" src='/js/apply.js'></script>
</body>
</html>