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