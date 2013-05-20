/*
 * 	Easy Notification - jQuery plugin
 *	written by Alen Grakalic	
 *	http://cssglobe.com
 *
 *	Copyright (c) 2011 Alen Grakalic (http://cssglobe.com)
 *	Dual licensed under the MIT (MIT-LICENSE.txt)
 *	and GPL (GPL-LICENSE.txt) licenses.
 *
 *	Built for jQuery library
 *	http://jquery.com
 *
 */

jQuery.easyNotification = function (options) {

    var defaults = {	
		id: 'easyNotification',
		text: 'Notification!',		
		parent: '#content',
		prepend: true,		
		sibling: '',
		before: true,
		closeClassName: 'close',
		closeText: 'Sulge',
		cookieEnable: false,
		cookieName: 'notification',
		cookieValue: '123425',
		cookieDays: 30,		
		delay: 0,
		autoClose: false,
		duration: 2000,
		callback: function(){}
	}; 
	if(typeof options == 'string') defaults.text = options;
	var options = jQuery.extend(defaults, options); 
	
	var obj, timeout;
	
	function setCookie(name,value,days) {
		if (days) {
			var date = new Date();
			date.setTime(date.getTime()+(days*24*60*60*1000));
			var expires = "; expires="+date.toGMTString();
		}
		else var expires = "";
		document.cookie = name+"="+value+expires+"; path=/";
	};
	
	function getCookie(name) {
		var nameEQ = name + "=";
		var ca = document.cookie.split(';');
		for(var i=0;i < ca.length;i++) {
			var c = ca[i];
			while (c.charAt(0)==' ') c = c.substring(1,c.length);
			if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
		}
		return null;
	};
	
	function deleteCookie(name) {
		setCookie(name,"",-1);
	};	
	
	function checkCookie(){
		var cookieExist = false;
		if(options.cookieEnable){
			var cookie = getCookie(options.cookieName);
			if (cookie == options.cookieValue) cookieExist = true;
		};
		return cookieExist;
	};
	
	function hide(){
		$(obj).slideUp('fast');
		if(options.cookieEnable) setCookie(options.cookieName,options.cookieValue,options.cookieDays);
		options.callback();	
		clearTimeout(timeout);
	}
	
	function show(){
		
		$('#'+ options.id).remove();
		clearTimeout(timeout);
		obj = $('<div id="'+ options.id +'">'+ options.text +'</div>');
		$('<span class="'+ options.closeClassName +'">'+ options.closeText +'</span>')
			.click(function(){hide();})
			.appendTo(obj);
		if(options.sibling != ''){
			if(options.before) {
				$(obj).hide().insertBefore(options.sibling).fadeIn('fast');
			} else {
				$(obj).hide().insertAfter(options.sibling).fadeIn('fast');
			};	
		} else {
			if(options.prepend) {
				$(obj).hide().prependTo(options.parent).fadeIn('fast');
			} else {
				$(obj).hide().appendTo(options.parent).fadeIn('fast');
			};				
		}
		if (options.autoClose) timeout = setTimeout(hide,options.duration);
	};
	
	if (!checkCookie()) timeout = setTimeout(show,options.delay);
	
};



$(document).ready(function() {
	$('#radioboxes, #checkboxes').on('change', updateResults);

	$(updateResults);
});
var curSearch;
function updateResults() {
	$('#resultSearch').val("");
	results = document.getElementById("results");
	var current_radiobox = $('#radioboxes.custom-radiobox input[type=radio]:checked').val();
	var current_checked = $("#checkboxes.custom-checkbox input[type=checkbox]:checked").map(function () {return this.value;}).get();

	if(current_checked.length>0){
		var jsonObj = [];
		jsonObj.push({radio: current_radiobox, checkboxes: current_checked});
		if(curSearch) curSearch.abort();
		curSearch = $.ajax({ 
			url: "/getCandidates",
			type: "post",
			data: JSON.stringify(jsonObj),
			contentType: 'application/json; charset=utf-8',
			dataType: 'json',
			beforeSend: function() { $('#noResultsFound').hide(); $('#results_wrapper').addClass("loading"); },
			complete: function() {  $('#results_wrapper').removeClass("loading"); },
			success: function(jsonData){
				results.innerHTML = "";
				if(jsonData.length==0) $('#noResultsFound').show();
				for (i = 0; i < jsonData.length; i++) {
					var c = jsonData[i];
					var linode = document.createElement('li');
					var anode = document.createElement('a');
					anode.setAttribute('href', 'javascript:previewCandidate('+c.PID+')');
					anode.appendChild(document.createTextNode(c.Firstname + " " + c.Lastname));
					results.appendChild(linode).appendChild(anode);
				}
			},
			error: function (xhr, ajaxOptions, thrownError) {
				results.innerHTML = xhr.status;
				results.innerHTML = thrownError;
		    }
		});
	} else {
		if(curSearch) curSearch.abort();
		results.innerHTML = "";
		$('#noResultsFound').show();
	}
}

function previewCandidate(candidateId) {
	var jsonObj = [];
	jsonObj.push({userId: candidateId});
	$.ajax({ 
		url: "/getCandidates",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		success: function(jsonData){
			var c = jsonData[0];
			 $('#profile img#avatar').attr('src',(c.ImgUrl==undefined ? "/img/avatar.jpg" : c.ImgUrl));
			 $('#profile span#name').html(c.Firstname + " " + c.Lastname);
			 $('#profile span#birthdate').html((c.Birthdate) ? c.Birthdate : '-');
			 $('#profile span#party').html((c.PartyName) ? c.PartyName : '-');
			 $('#profile span#constituency').html((c.ConstituencyName) ? c.ConstituencyName : '-');
			 $('#profile span#facebook').html((c.Facebook_Id) ? "<a href='http://www.facebook.com/" + c.Facebook_Id + "'>"+c.Firstname + " " + c.Lastname +"</a>" : '-');
			 $('#profile span#skype').html((c.Skype) ? c.Skype : '-');
			 $('#profile span#other').html((c.Other) ? c.Other : '-');
			 $('#profile span#shortText').html((c.ShortInfo) ? c.ShortInfo : '-'); 
			 $('#profile span#longText').html((c.LongInfo) ? c.LongInfo : '-'); 
			 document.getElementById( "votebutton" ).setAttribute( "onClick", "javascript:vote("+c.PID+");");
			 $('#profile').show();
			 $('#votebutton').show(); 
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$.easyNotification(xhr.status + " : " + thrownError);
			$("html, body").animate({ scrollTop: 0 }, "slow");
	    }
	});
}


function vote(candidateId){
	var jsonObj = [];
	jsonObj.push({vote: candidateId});

	$.ajax({ 
		url: "/vote",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {$('#votebutton').hide(); $('#buttonLoader').addClass("loading"); },
		complete: function() {  $('#votebutton').show(); $('#buttonLoader').removeClass("loading"); },
		success: function(jsonData){
			$.easyNotification(jsonData.message); 
			$("html, body").animate({ scrollTop: 0 }, "slow");
		},
		error: function(xhr, ajaxOptions, thrownError) {
	        switch(xhr.status){
	        	case 888: $.easyNotification('Hääletamiseks logige palun sisse!'); break;
	        	case 999: $.easyNotification('Tekkis viga!'); break;
	        	default: $.easyNotification(xhr.status + " : " + thrownError);
	        }
	        $("html, body").animate({ scrollTop: 0 }, "slow");
	    }
	});
}

var rows = document.getElementById('results').getElementsByTagName("li");
$('#resultSearch').keyup(function() {
	var input = document.getElementById('resultSearch').value;
    var val = input.trim($(input).val()).replace(/ +/g, ' ').toLowerCase();
    var results = rows.length;
    for(var i=0; i<rows.length;i++){
		rows[i].style.display="block";
    	var rowValue = rows[i].getElementsByTagName("a").item(0).childNodes[0].nodeValue;
    	var val2 = rowValue.replace(/\s+/g, ' ').toLowerCase();
    	if(!~val2.indexOf(val)){
    		rows[i].style.display="none";
    		results--;
    	}
    }
	if(results==0) $('#noResultsFound').show();
	else $('#noResultsFound').hide();
});

function clearAllFilters(){
	$('#resultSearch').val("");
	$('#radioboxes.custom-radiobox input[type=radio]:first').prop('checked',true);
	$("#checkboxes.custom-checkbox input[type=checkbox]").each(function() {
        this.checked = true;                        
    });
	updateResults();
}