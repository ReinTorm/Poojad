$(document).ready(function() {
	loadTableData();
	
	if($('table.stattable')){
		$("<div id='tableLoadMore'>Laadi rohkem tulemusi!</div><div id='noMoreResults'>Rohkem sissekandeid ei ole</div>").insertAfter('table.stattable');
		$('#noMoreResults').hide();
	}
	
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
	orderedJson = ["AvaldusId", "Firstname", "Lastname", "Isikukood", "PartyName", "ConstituencyName", "Aadress", "Mobilephone", "Birthplace", "Education","Degree","Work","Job","State"]; 
	
	if(curSearch) curSearch.abort();
	curSearch = $.ajax({ 
		url: "/getAdminTable",
		type: "post",
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
			var v;
			for (i = 0; i < jsonData.length; i++) {
				var c = jsonData[i];
				var trNode = document.createElement('tr');
				for(j=0;j<orderedJson.length;j++){
					var td = document.createElement('td');
					v = c[orderedJson[j]] || "-"
					if(j==0) td.appendChild(document.createTextNode(startIndex+i+1));
					else td.appendChild(document.createTextNode(v));
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