$(document).ready(function() {
	loadTableData();
	$('#partyTableOption, #areaTableOption').on('change', loadTableData);
	
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
});
var curSearch;
function loadTableData() {
	var tbodyID = $('table.stattable > tbody').attr('id')
	var orderedJson;
	var jsonObj = [];
	switch(tbodyID){
		case("candidateTable"): 
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'candidate'});	
			break;
		case("riikTable"): 
			orderedJson = ["Nr", "PartyName", "Hääli"]; 
			jsonObj.push({pageID: 'riik'});	
			break;	
		case("partyTable"): 
			var curr = parseInt($('#partyTableOption option:selected').attr('id'));
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'partei', current: curr});	
			break;
		case("areaTable"): 
			var curr = parseInt($('#areaTableOption option:selected').attr('id'));
			orderedJson = ["Nr", "PID", "Nimi", "PartyName", "ConstituencyName", "Hääli"]; 
			jsonObj.push({pageID: 'area', current: curr});	
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
		beforeSend: function() {$('#'+tbodyID).empty(); $('#content > *').hide(); $('#content').addClass('loading'); },
		complete: function() {$('#content > *').show(); $('#content').removeClass('loading'); },
		success: function(jsonData){
			var tBody = document.getElementById(tbodyID);
			for (i = 0; i < jsonData.length; i++) {
				var c = jsonData[i];
				var trNode = document.createElement('tr');
				for(j=0;j<orderedJson.length;j++){
					var td = document.createElement('td');
					td.appendChild(document.createTextNode(c[orderedJson[j]]));
					trNode.appendChild(td);
				}
				tBody.appendChild(trNode);
			} 
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#content").html(xhr.status);
			$("#content").html(thrownError);
	    }
	});
}