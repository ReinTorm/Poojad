$(document).ready(function() {
	$(profile_data);	
});

$('#remove_vote').click(function(){
	var jsonObj = [];	
	$.ajax({
		url: "/profileRemVote",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {},
		complete: function() {},
		success: function(jsonData){
			$.easyNotification(jsonData.message);
			$("html, body").animate({ scrollTop: 0 }, "slow");
			var kandidaat = document.getElementById('voted_for_name');
			kandidaat.innerHTML = '-';
			$('#remove_vote').hide();			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$.easyNotification(xhr.status + " : " + thrownError);
			$("html, body").animate({ scrollTop: 0 }, "slow");
		}
    });
})

function profile_data() {
	var jsonObj = [];	
	curSearch = $.ajax({
		url: "/profileData",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {$('#my_data_block').addClass("loading"); },
		complete: function() {$('#my_data_block').removeClass("loading"); },
		success: function(jsonData){
			var c = jsonData[0];
			var selection = document.getElementById('constituency');
			var data = 
				"<label>Eesnimi:</label><input type='text' name='fname' value='" + c.Firstname +"'><br>"
			+	"<label>Perenimi:</label><input type='text' name='lname' value='" + c.Lastname +"'><br>"			
			+	"<label>E-mail:</label><input type='text' name='email' value='" + c.Email +"'><br>"						
			selection.options[c.CID].selected = true;
			$("#my_data_block").append(data);
			
			document.getElementById('avatar').setAttribute('src', c.ImgUrl);			
			var kandidaat = document.getElementById('voted_for_name');
			if (c.VName != undefined){
				kandidaat.innerHTML = c.VName;
				$('#remove_vote').show();
			}
			else {
				kandidaat.innerHTML = '-';
				$('#remove_vote').hide();
			}			
			if (c.PartyId != "0"){
				var mystatus_data =
				"<p><label><b>Staatus:</b></label> Kandideerib <br>"
				+	"<label><b>Erakond:</b></label> " + c.PartyName + "<br>"
				+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
				+	"<label><b>Häälte arv:</b></label> " + c.VCount + "<br></p>";
			}
			else { 
				var mystatus_data =
				"<p><label><b>Staatus:</b></label> Ei kandideeri <br>"
				+	"<label><b>Erakond:</b></label> - <br>"
				+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
				+	"<label><b>Häälte arv:</b></label> - <br></p>";
			}				
			
			$("#mystatus").append(mystatus_data);
				
			 
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#my_data_block").html(xhr.status);
			$("#my_data_block").html(thrownError);
		}
	});
}