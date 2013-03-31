$(document).ready(function() {
	$('a.statbutton').on('click', function() {
		$('.stat-content').hide();
		var pageToShow = $(this).attr('id') + "-content";
		document.getElementById(pageToShow).style.display = 'block';
	});

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
		results.html("");
		results.addClass("loading");
		var current_radiobox = $('input:checked', '#radioboxes').val();
		$.getJSON('candidates.json', function(data) {
			for (i = 0, l = data.candidates.length; i < l; ++i) {
				var candidate = data.candidates[i];
				if ((current_radiobox == 0 || current_radiobox == candidate.person.constituency_nr) && $('#checkboxes input:checkbox[value="' + candidate.person.party + '"]').is(':checked')) {
					results.append('<li><a href="javascript:previewCandidate(' + candidate.id + ')">' + candidate.person.name + "</a></li>\n");
				}
			}
		});
		setTimeout(function(){results.removeClass("loading")}, 1000);
	}

	$('#radioboxes, #checkboxes').on('change', updateResults);
});

function previewCandidate(candidateId) {
	$.getJSON('candidates.json', function(data) {
		for (i = 0, l = data.candidates.length; i < l; ++i) {
			if (data.candidates[i].id == candidateId) {
				$('#profile').html("");
				$('#profile').append(
						'<img src="img/avatar.jpg" id="avatar">' + '<h1>' + data.candidates[i].person.name + '</h1>' + '<p><b>Vanus: </b>' + data.candidates[i].person.age + '</p>'
								+ '<p><b>Partei: </b>' + data.candidates[i].person.party + '</p>' + '<p><b>Valimisringkond: </b>' + data.candidates[i].person.constituency + '</p>'
								+ '<p><b>Facebook: </b><a href="' + data.candidates[i].person.facebook + '">' + data.candidates[i].person.name + '</a></p>' + '<p><b>Skype: </b>'
								+ data.candidates[i].person.skype + '</p>' + '<p><b>Muu: </b>' + data.candidates[i].person.other + '</p>' + "<h4>What's up?</h4>" + '<p>'
								+ data.candidates[i].person.stext + '</p>' + '<h4>Lorem Ipsum</h4>' + '<p>' + data.candidates[i].person.ltext + '</p>');
				break;
			}
		}
	});
}