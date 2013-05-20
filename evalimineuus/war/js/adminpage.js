$(document).ready(function() {
	loadTableData();
	$('#CandidateStateOption').on('change', loadTableData);
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
var cancelStateChange = false;
function changeUserState(){
	if(cancelStateChange) return;
	var userId = this.id.split('-')[1];
	var newState = getSelectedText(this.id);
	if (newState.toUpperCase() === "NONE") { 
		alert('Viga: Toiming ei ole lubatud! Kasuta "Declined" staatust.'); 
		return;
	}
	var jsonObj = [];
	jsonObj.push({uId: userId, nState: newState});
	$.ajax({ 
		url: "/changeUserState",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {  },
		complete: function() {  },
		success: function(jsonData){
			alert(jsonData['message']);
		},
		error: function (xhr, ajaxOptions, thrownError) {
			alert(xhr.status + " : " + thrownError);
	    }
	});	
}

function getSelectedText(elementId) {
    var elt = document.getElementById(elementId);

    if (elt.selectedIndex == -1)
        return null;

    return elt.options[elt.selectedIndex].text;
}

var step = 10;
var curSearch;
function loadTableData(startIndex, append) {
	var startIndex = typeof startIndex==="number" ? startIndex : 0;
	var endIndex = startIndex + step;
	var append = typeof append==="boolean" ? append : false;
	var tbodyID = $('table.stattable > tbody').attr('id')
	var orderedJson;
	orderedJson = ["PID", "Firstname","Lastname","Isikukood","PartyId","CID","Aadress","ShortInfo","LongInfo","ApplyState"];
	var curr = $('#CandidateStateOption option:selected').attr('value');
	var jsonObj = [];
	jsonObj.push({current: curr, start: startIndex, end: endIndex});	
	if(curSearch) curSearch.abort();
	curSearch = $.ajax({ 
		url: "/getAdminTable",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {
			if(!append) $('#'+tbodyID).empty(); 
			$('#tableLoadMore').addClass('loading').show();
			cancelStateChange = true;
		},
		complete: function() {
			$('#tableLoadMore').removeClass('loading'); 
			cancelStateChange = false;
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
						else if(j==orderedJson.length-1){
							var userStateOptions = document.createElement("select");
							userStateOptions.className = "changeUserApplyState";
							userStateOptions.onchange=changeUserState;
							userStateOptions.id = "changeUserState-"+c['PID'];
							userStateOptions[0]=new Option("Pending", "PENDING");
							userStateOptions[1]=new Option("Declined", "DECLINED");
							userStateOptions[2]=new Option("Active", "ACTIVE");
							userStateOptions[3]=new Option("None", "NONE");
							if(v==="PENDING") userStateOptions[0].selected = true;
							else if(v==="DECLINED") userStateOptions[1].selected = true;
							else if(v==="ACTIVE") userStateOptions[2].selected = true;
							else if(v==="NONE") userStateOptions[3].selected = true;
							td.appendChild(userStateOptions);
						}
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