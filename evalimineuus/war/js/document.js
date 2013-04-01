$(document).ready(function() {

	$('.popbox').popbox();

	$('#subForm').submit(function() {
		var ok = true;
		var formDate = $(this).find("input[name='date']");
		var formNumber = $(this).find("input[name='number']");
		var formParty = $(this).find("input[name='partyName']");

		function testStringError(inputField) {
			if ((/\d/g).test(inputField.val()) || inputField.val().length < 3) {
				inputField.addClass("errorField");
				if (inputField.val().length < 1) {
					inputField.before(errorMandatory);
				} else if ((/\d/g).test(inputField.val())) {
					inputField.before(errorNumbers);
				} else if (inputField.val().length < 3) {
					inputField.before(errorShort);
				}
				ok = false;
			}
		}

		function testShortIntegerError(inputField) {
			if ((/\D/g).test(inputField.val())) {
				inputField.addClass("errorField");
				if ((/\D/g).test(inputField.val())) {
					inputField.before(errorLetters);
				}
				ok = false;
			}
		}

		$('#subForm>*').removeClass("errorField");
		$('#subForm p.error').hide();

		if (!(formDate.val()).match(/^([1][12]|[0]?[1-9])[\.-]([3][01]|[12]\d|[0]?[1-9])[\.-](\d{4}|\d{2})$/)) {
			formDate.addClass("errorField");
			ok = false
		}
		testStringError(formParty);
		testShortIntegerError(formNumber);

		return ok
	});

	$('#candidateForm').submit(function() {
		var ok = true;
		var candidateParty = $(this).find("input[name='party']");

		var errorMandatory = '<p class="error">Kohustuslik!</p>';
		var errorNumbers = '<p class="error">Ei tohi sisaldada numbreid!</p>';
		var errorLetters = '<p class="error">Peab koosnema ainult numbritest!</p>';
		var errorShort = '<p class="error">Liiga lühike!</p>'

		$('#candidateForm>*').removeClass("errorField");
		$('#candidateForm p.error').hide();

		function testStringError(inputField) {
			if ((/\d/g).test(inputField.val()) || inputField.val().length < 3) {
				inputField.addClass("errorField");
				if (inputField.val().length < 1) {
					inputField.before(errorMandatory);
				} else if ((/\d/g).test(inputField.val())) {
					inputField.before(errorNumbers);
				} else if (inputField.val().length < 3) {
					inputField.before(errorShort);
				}
				ok = false;
			}
		}

		function testIntegerError(inputField) {
			if ((/\D/g).test(inputField.val()) || inputField.val().length < 10) {
				inputField.addClass("errorField");
				if (inputField.val().length < 1) {
					inputField.before(errorMandatory);
				} else if ((/\D/g).test(inputField.val())) {
					inputField.before(errorLetters);
				} else if (inputField.val().length < 10) {
					inputField.before(errorShort);
				}
				ok = false;
			}
		}

		testStringError($(this).find("input[name='fname']"));
		testStringError($(this).find("input[name='lname']"));
		testIntegerError($(this).find("input[name='socnumber']"));
		testStringError($(this).find("input[name='party']"));
		testStringError($(this).find("input[name='address']"));

		return ok;
	});

	$('form input').keydown(function(event) {
		$(this).removeClass('errorField');
	});

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
		results = $('#results');
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
				beforeSend: function() { results.addClass("loading"); },
				complete: function() { results.removeClass("loading"); },
				success: function(jsonData){
					results.html("");
					for (i = 0; i < jsonData.length; i++) {
						var c = jsonData[i];
						results.append('<li><a href="javascript:previewCandidate(' + c.PID + ')">' + c.PID + " - " + c.Firstname + " " + c.Lastname + "</a></li>\n");
					}
				},
				error: function (xhr, ajaxOptions, thrownError) {
			        results.html(xhr.status);
			        results.html(thrownError);
			    }
			});
		} else {
			results.html("");
		}
	}

	$('#radioboxes, #checkboxes').on('change', updateResults);
});

function previewCandidate(candidateId) {
	profile = $('#profile');
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
			 $('#profile span#name').html(c.Firstname + " " + c.Lastname);
			 $('#profile span#birthdate').html(c.Birthdate);
			 $('#profile span#party').html(c.PartyName);
			 $('#profile span#constituency').html(c.ConstituencyName);
			 $('#profile span#facebook').html("<a href='www.facebook.com/" + c.Facebook_Id + "'>"+c.Firstname + " " + c.Lastname +"</a>");
			 $('#profile span#skype').html(c.Skype);
			 $('#profile span#skype').html(c.Skype);
			 $('#profile span#other').html(c.Other);
			 $('#profile span#shortText').html(c.ShortInfo); 
			 $('#profile span#longText').html(c.LongInfo); 
			 profile.show();
		},
		error: function(xhr, ajaxOptions, thrownError) {
	        alert(xhr.status);
	        alert(thrownError);
	    }
	});
//	
//	$.getJSON('candidates.json', function(data) {
//		for (i = 0, l = data.candidates.length; i < l; ++i) {
//			if (data.candidates[i].id == candidateId) {
//				$('#profile').append(
//						'<img src="img/avatar.jpg" id="avatar">' + '<h1>' + data.candidates[i].person.name + '</h1>' + '<p><b>Vanus: </b>' + data.candidates[i].person.age + '</p>'
//								+ '<p><b>Partei: </b>' + data.candidates[i].person.party + '</p>' + '<p><b>Valimisringkond: </b>' + data.candidates[i].person.constituency + '</p>'
//								+ '<p><b>Facebook: </b><a href="' + data.candidates[i].person.facebook + '">' + data.candidates[i].person.name + '</a></p>' + '<p><b>Skype: </b>'
//								+ data.candidates[i].person.skype + '</p>' + '<p><b>Muu: </b>' + data.candidates[i].person.other + '</p>' + "<h4>What's up?</h4>" + '<p>'
//								+ data.candidates[i].person.stext + '</p>' + '<h4>Lorem Ipsum</h4>' + '<p>' + data.candidates[i].person.ltext + '</p>');
//				break;
//			}
//		}
//	});
}

