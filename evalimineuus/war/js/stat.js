$(document).ready(function() {
	loadTableData();
	
	if($('table.stattable')){
		$("<div id='tableLoadMore'>Laadi rohkem tulemusi!</div><div id='noMoreResults'>Rohkem sissekandeid ei ole</div>").insertAfter('table.stattable');
		$('#noMoreResults').hide();
	}

	$('#partyTableOption, #areaTableOption').on('change', loadTableData);
	
	$('#tableLoadMore').on('click', function(){
		var tbodyID = $('table.stattable > tbody').attr('id')
		var rowNrEnd = 0;
		$('#'+tbodyID+' tr > td:nth-child(1)').each(function(){
			if(parseInt($(this).text())>rowNrEnd){
				rowNrEnd = parseInt($(this).text());
			}
		});
		loadTableData(rowNrEnd, true);
	});
	
	$('table.sortable').each(function() {
		var $table = $(this);
		$('th', $table).each(function(column) {
			if ($(this).is('.alphabetic')) {
				$(this).hover(function() {
					$(this).addClass('hover');
				}, function() {
					$(this).removeClass('hover');
				})
			}
		});
	});
	
	
	var $gMap = $("#googleMap");
	if ($gMap.length){
		var map;		
		initialize();
		//google.maps.event.addDomListener(window, 'load', initialize);
	}
});
var step = 10;
var curSearch;
function loadTableData(startIndex, append) {
	var startIndex = typeof startIndex==="number" ? startIndex : 0;
	var endIndex = startIndex + step;
	var append = typeof append==="boolean" ? append : false;
	var tbodyID = $('table.stattable > tbody').attr('id')
	var orderedJson;
	var jsonObj = [];
	switch(tbodyID){
		case("candidateTable"): 
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'candidate', start: startIndex, end: endIndex});	
			break;
		case("riikTable"): 
			orderedJson = ["Nr", "PartyName", "Hääli"]; 
			jsonObj.push({pageID: 'riik', start: startIndex, end: endIndex});	
			break;	
		case("partyTable"): 
			var curr = parseInt($('#partyTableOption option:selected').attr('id'));
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'partei', current: curr, start: startIndex, end: endIndex});	
			break;
		case("areaTable"): 
			var curr = parseInt($('#areaTableOption option:selected').attr('id'));
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'area', current: curr, start: startIndex, end: endIndex});	
			break;
		default:
			return;
	}
	if(curSearch) curSearch.abort();
	curSearch = $.ajax({ 
		url: "/getTable",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {
			if(!append) $('#'+tbodyID).empty(); 
			$('#tableLoadMore').addClass('loading').show();
		},
		complete: function() {
			$('#tableLoadMore').removeClass('loading'); 
		},
		success: function(jsonData){
			var tBody = document.getElementById(tbodyID);
			for (i = 0; i < jsonData.length; i++) {
				var c = jsonData[i];
				var trNode = document.createElement('tr');
				for(j=0;j<orderedJson.length;j++){
					var td = document.createElement('td');
					if(j==0) td.appendChild(document.createTextNode(startIndex+i+1));
					else td.appendChild(document.createTextNode(c[orderedJson[j]]));
					trNode.appendChild(td);
				}
				tBody.appendChild(trNode);
			}
			if(jsonData.length<step){
				$('#tableLoadMore').hide();
				$('#noMoreResults').show();
			}else{
				$('#tableLoadMore').show();
				$('#noMoreResults').hide();
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#content").html(xhr.status);
			$("#content").html(thrownError);
	    }
	});
}
function initialize(){
	geocoder = new google.maps.Geocoder();
	var mapProp = {
	  center:new google.maps.LatLng(58.651227, 25.455322),
	  zoom:7,
	  mapTypeId:google.maps.MapTypeId.ROADMAP,
	  //disableDefaultUI:true,
	  mapTypeControl:false,
	  streetViewControl:false
	  };
	map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
	map.controls[google.maps.ControlPosition.RIGHT_BOTTOM].push(document.getElementById('legendMap'));
	addCircles();
}
function addCircles(i) {
	var circles = [[59.442806, 24.618301, 'Tallinna Haabersti, Põhja-Tallinna ja Kristiine linnaosa', 5000], 
	               [59.480661, 24.878883, 'Tallinna Kesklinna, Lasnamäe ja Pirita linnaosa', 5000],
	               [59.358396, 24.695206, 'Tallinna Mustamäe ja Nõmme linnaosa', 5000],
	               [59.074448,24.647827, 'Harju-(v.a. Tallinn) ja Raplamaa', 25000],
	               [58.802362, 23.247071, 'Hiiu-, Lääne- ja Saaremaa', 45000],
	               [59.302356, 26.328735, 'Lääne-Virumaa', 20000],
	               [59.258862, 27.413635, 'Ida-Virumaa', 25000],
	               [58.622637, 25.504761, 'Järva- ja Viljandimaa', 27500],
	               [58.716894, 26.674805, 'Jõgeva- ja Tartumaa (v.a. Tartu linn)', 22500],
	               [58.360697, 26.727757, 'Tartu linn', 15000],
	               [57.955674, 26.564941, 'Võru-, Valga- ja Põlvamaa', 25000], 
	               [58.372918, 24.455566, 'Pärnumaa', 27500]];
	var jsonObj = [];
	var global_circles = [];
	var colors = ["#297ACC", "#000072", "#1F7A1F", "#FF8DC6", "#FFFF00", "#663300", "#800000", "#BA5919", "#2E8B2E", "#5CD6FF", "#CC0000", "#FFFFFF"];
	jsonObj.push({pageID: 'kaart'});
	curSearch = $.ajax({
		url: "/getTable",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {$('#googleMap').addClass("loading"); },
		complete: function() {$('#googleMap').removeClass("loading"); },
		success: function(jsonData){
			for (var i = 0; i < circles.length; i++){
				var infowindow = new google.maps.InfoWindow({});
				var lat = parseFloat(circles[i][0]);
		        var lng = parseFloat(circles[i][1]);	        
		        var const_name = circles[i][2];
		        var circ_radius = parseInt(circles[i][3]);
		        var const_id = i+1;		        
		        for (var j = 0; j < jsonData.length; j++){
		        	var c = jsonData[j];
		        	//alert("ConstId: " + const_id + ". c.CID: " + c.CID + ". Kas on sama? " + (c.CID == const_id) + ". Hetke objekt: " + c.PartyName + ". I:" + i + " J:" + j);
			        if (c.CID == const_id) {			        	
			        	var contentString = "<p>Piirkond: " + const_name + "</p>" +
			        						"<p>Partei: " + c.PartyName + "</p>" +
			        						"<p>Hääli: " + c.VoteSum + "</p>";
			        	var parteiColor = c.PartyId - 1;
			        	//alert(c.PartyName + " " + c.PartyId + " " + parteiColor + " " + colors[parteiColor]);
			        	j = jsonData.length + 1;
			        }
			        else if (j == jsonData.length - 1){
			        	var contentString = "<p>Piirkond: " + const_name + "</p>" +
											"<p>Partei: -</p>" +
											"<p>Hääli: -</p>";
			        	var parteiColor = 11; //valge 
			        }
		        }
		        
		        var myLatlng = new google.maps.LatLng(lat, lng);
	
		        var circle = new google.maps.Circle({
		        	clickable: true,
		            center: myLatlng,
		            radius: circ_radius,
		            fillColor: colors[parteiColor],
		            fillOpacity: 0.3,
		            strokeWeight: 1,
		            map: map	            
		        });
	
		        circle['infowindow'] = contentString;
	
		        global_circles[i] = circle;
	
		        google.maps.event.addListener(global_circles[i], 'click', function() {
		        	infowindow.setPosition(this.getCenter());
		            infowindow.setContent(this['infowindow']);
		            infowindow.open(map);
		        });
		        
			}
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#content").html(xhr.status);
			$("#content").html(thrownError);
		}
	});	
}