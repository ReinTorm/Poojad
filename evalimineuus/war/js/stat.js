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
	  center:new google.maps.LatLng(58.631217,25.092773),
	  zoom:7,
	  mapTypeId:google.maps.MapTypeId.ROADMAP,
	  //disableDefaultUI:true,
	  mapTypeControl:false,
	  streetViewControl:false
	  };
	map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
	for (i = 0; i < 12; i++){
		addCircles(i);
	}
}
function addCircles(i) {
	var circles = [[59.428316,24.645081, 'Tallinna Haaberisti, Põhja-Tallinna ja Kristiine linnaosa'], [59.469152,24.860001, 'Tallinna Kesklinna, Lasnamäe ja Pirita linnaosa'], [59.436696,24.752197, 'Tallinna Mustamäe ja Nõmme linnaosa'], [59.144952,24.97467, 'Harju-(v.a. Tallinn) ja Raplamaa'], [58.788132,23.856812, 'Hiiu-, Lääne- ja Saaremaa'], [59.302356,26.328735, 'Lääne-Virumaa'], [59.258862,27.413635, 'Ida-Virumaa'], [58.622637,25.504761, 'Järva- ja Viljandimaa'], [58.53386,26.449585, 'Jõgeva- ja Tartumaa (v.a. Tartu linn)'], [58.360697,26.727757, 'Tartu linn'], [57.955674,26.564941, 'Võru-, Valga- ja Põlvamaa'], [58.553927,24.515991, 'Pärnumaa']];
	var jsonObj = [];
	var x = i + 1	
	jsonObj.push({pageID: 'kaart', current: x});
	curSearch = $.ajax({
		url: "/getTable",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		//beforeSend: function() {$('#googleMap').addClass("loading"); },
		//complete: function() {$('#googleMap').removeClass("loading"); },
		success: function(jsonData){
			var infowindow = new google.maps.InfoWindow({});
			var global_circles = [];
			var colors = ["", "#4D4D4D", "#66CCFF", "#1F7A1F", "#0000B2", "#FFFF00", "#663300", "#800000", "#BA5919", "#2E8B2E", "#5CD6FF", "#CC0000"]
			var lat = parseFloat(circles[i][0]);
	        var lng = parseFloat(circles[i][1]);
	        var marker_name = circles[i][2];
	        if (jsonData.length != 0) {
	        	var c = jsonData[0];
	        	var contentString = "<p>Piirkond: " + marker_name + "</p>" +
	        						"<p>Partei: " + c.PartyName + "</p>" +
	        						"<p>Hääli: " + c.VoteSum + "</p>";
	        	var parteiId = parseInt(c.PID);
	        }
	        else {
	        	var contentString = "<p>Piirkond: " + marker_name + "</p>" +
									"<p>Partei: -</p>" +
									"<p>Hääli: -</p>";    	        	
	        }
	        var myLatlng = new google.maps.LatLng(lat, lng);

	        var circle = new google.maps.Circle({
	        	clickable: true,
	            center: myLatlng,
	            radius: 15000,
	            fillColor: colors[parteiId],
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
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#content").html(xhr.status);
			$("#content").html(thrownError);
		}
	});	
}