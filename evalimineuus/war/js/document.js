$(document).ready(function() {

	$('.popbox').popbox();

	$('table.sortable').each(function() {
		var $table = $(this);
		$('th', $table).each(function(column) {
			if ($(this).is('.alphabetic')) {
				$(this).hover(function() {
					$(this).addClass('hover');
				}, function() {
					$(this).removeClass('hover');
				}).click(function() {
					var sortOrder = $('table.sortable').data('order');
					var rows = $table.find('tbody > tr').get();

					if (sortOrder == 'd' || sortOrder == '') {
						$('table.sortable').data('order', 'a');
						rows.sort(function(a, b) {
							var keyA = $(a).children('td').eq(column).text().toUpperCase();
							var keyB = $(b).children('td').eq(column).text().toUpperCase();

							if (keyA < keyB) {
								return 1;
							}
							if (keyA > keyB) {
								return -1;
							}
							return 0;
						});
					} else {
						$('table.sortable').data('order', 'd');
						rows.sort(function(a, b) {
							var keyA = $(a).children('td').eq(column).text().toUpperCase();
							var keyB = $(b).children('td').eq(column).text().toUpperCase();

							if (keyA < keyB) {
								return -1;
							}
							if (keyA > keyB) {
								return 1;
							}
							return 0;
						});
					}
				});
			}
		});
	});

	function updateResults() {
		results = document.getElementById("results");
		var current_radiobox = $('#radioboxes.custom-radiobox input[type=radio]:checked').val();
		var current_checked = $("#checkboxes.custom-checkbox input[type=checkbox]:checked").map(function () {return this.value;}).get();
		
		if(current_checked.length>0){
			var jsonObj = [];
			jsonObj.push({radio: current_radiobox, checkboxes: current_checked});
			$.ajax({ 
				url: "/getCandidates",
				type: "post",
				data: JSON.stringify(jsonObj),
				contentType: 'application/json; charset=utf-8',
				dataType: 'json',
				beforeSend: function() { $('#results_wrapper').addClass("loading"); },
				complete: function() {  $('#results_wrapper').removeClass("loading"); },
				success: function(jsonData){
					results.innerHTML = "";
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
			        results.html(xhr.status);
			        results.html(thrownError);
			    }
			});
		} else {
			results.innerHTML = "";
		}
	}

	$('#radioboxes, #checkboxes').on('change', updateResults);
});

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
			 $('#profile span#birthdate').html(c.Birthdate);
			 $('#profile span#party').html(c.PartyName);
			 $('#profile span#constituency').html(c.ConstituencyName);
			 $('#profile span#facebook').html("<a href='http://www.facebook.com/" + c.Facebook_Id + "'>"+c.Firstname + " " + c.Lastname +"</a>");
			 $('#profile span#skype').html(c.Skype);
			 $('#profile span#skype').html(c.Skype);
			 $('#profile span#other').html(c.Other);
			 $('#profile span#shortText').html(c.ShortInfo); 
			 $('#profile span#longText').html(c.LongInfo); 
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
		beforeSend: function() { $('#votebutton').removeClass("button").addClass("loading"); },
		complete: function() {  $('#votebutton').addClass("button").removeClass("loading"); },
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
$.ketchup

.createErrorContainer(function(form, el) {
  return $('<ul/>', {
           'class': 'ketchup-custom'
         }).insertAfter(el);
})

.addErrorMessages(function(form, el, container, messages) {
  container.html('');

  for(i = 0; i < messages.length; i++) {
    $('<li/>', {
      text: messages[i]
    }).appendTo(container);
  }
})

.showErrorContainer(function(form, el, container) {
  container.slideDown('fast');
})

.hideErrorContainer(function(form, el, container) {
  container.slideUp('fast');
});

$('#candidateForm').ketchup({
  validateEvents: 'blur',
});

//var rows = document.getElementById('results').getElementsByTagName("li");
$('#resultSearch').keyup(function() {
	
	var input = document.getElementById('resultSearch').value;
    var val = input.trim($(input).val()).replace(/ +/g, ' ').toLowerCase();
    for(var i=0; i<rows.length;i++){
		rows[i].style.display="block";
    	var rowValue = rows[i].getElementsByTagName("a").item(0).childNodes[0].nodeValue;
    	var val2 = rowValue.replace(/\s+/g, ' ').toLowerCase();
    	if(!~val2.indexOf(val)){
    		rows[i].style.display="none";
    	}
    }
});
