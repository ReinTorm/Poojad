$(document).ready(function() {
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