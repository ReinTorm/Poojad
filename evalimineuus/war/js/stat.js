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
		google.maps.event.addDomListener(window, 'load', initialize);
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
	  //disableDefaultUI:true,  //eemaldab google nupud sealt
	  mapTypeControl:false,
	  streetViewControl:false
	  };
	map=new google.maps.Map(document.getElementById("googleMap"), mapProp);
	addMarker();
}
function addMarker() {
	var infowindow = new google.maps.InfoWindow({});
	var global_markers = [];
	var markers = [[58.915992, 24.708252, 'trialhead0'], [58.410345, 26.856079, 'trialhead1'], [58.553927,24.515991, 'trialhead2']];
    for (var i = 0; i < markers.length; i++) {
        // obtain the attribues of each marker
        var lat = parseFloat(markers[i][0]);
        var lng = parseFloat(markers[i][1]);
        var trailhead_name = markers[i][2];
        

        var myLatlng = new google.maps.LatLng(lat, lng);

        var contentString = "<p>" + trailhead_name + "</p>";

        var marker = new google.maps.Marker({
            position: myLatlng,
            map: map,
            title: "Coordinates: " + lat + " , " + lng + " | Trailhead name: " + trailhead_name
        });

        marker['infowindow'] = contentString;

        global_markers[i] = marker;

        google.maps.event.addListener(global_markers[i], 'click', function() {
            infowindow.setContent(this['infowindow']);
            infowindow.open(map, this);
        });
    }
}