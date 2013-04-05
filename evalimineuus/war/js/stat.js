$(document).ready(function() {
	$(stat_candidate);
	
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
});

function stat_candidate() {
	var jsonObj = [];
	jsonObj.push({pageID: "candidate", current: 0});	
	curSearch = $.ajax({ 
		url: "/getTable",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {$('#candidate-content').addClass("loading"); },
		complete: function() {$('#candidate-content').removeClass("loading"); },
		success: function(jsonData){
			var table = "<table class='stattable sortable'>\n"
				+ "<thead>\n"
				+ "<tr><th class='alphabetic'>#</th><th class='alphabetic'>Number</th><th class='alphabetic'>Nimi</th><th class='alphabetic'>Partei</th><th class='alphabetic'>Piirkond</th><th class='alphabetic'>Hääli</th></tr>\n"
				+ "</thead>\n"
				+ "<tbody>\n"
			for (i = 0; i < jsonData.length; i++) {
				var c = jsonData[i];
				table+= "<tr>" +
							"<td>" + c.Nr + "</td>" +
							"<td>" + c.PID + "</td>" +
							"<td>" + c.Nimi + "</td>" +
							"<td>" + c.PartyName + "</td>" +
							"<td>" + c.ConstituencyName + "</td>" +
							"<td>" + c.Hääli + "</td>" +
						"</tr>\n";
			}
			$("#content").html(table);
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#content").html(xhr.status);
			$("#content").html(thrownError);
	    }
	});
	
}