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

function remove_cand(){
	var jsonObj = [];	
	$.ajax({
		url: "/profileRemCand",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {},
		complete: function() {},
		success: function(jsonData){
			$.easyNotification(jsonData.message);
			$("html, body").animate({ scrollTop: 0 }, "slow");
			update();			
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$.easyNotification(xhr.status + " : " + thrownError);
			$("html, body").animate({ scrollTop: 0 }, "slow");
		}
    });
}

function getSelect(elementId) {
    var elt = document.getElementById(elementId);

    if (elt.selectedIndex == -1)
        return null;

    return elt.options[elt.selectedIndex].value;
}


$('#savebutton').click(function(){	
	var const_id = getSelect('constituency');
	var fname = document.getElementById('fname').value;
	var lname = document.getElementById('lname').value;
	var email = document.getElementById('email').value;
	var faceid = document.getElementById('face_id').value;
	var skype = document.getElementById('skype').value;
	var jsonObj = [];
	jsonObj.push({fname: fname, lname: lname, email: email, face_id: faceid, skype: skype, const_id: const_id});
	$.ajax({
		url: "/profileUpdateInfo",
		type: "post",
		data: JSON.stringify(jsonObj),
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {},
		complete: function() {},
		success: function(jsonData){
			$.easyNotification(jsonData.message);
			$("html, body").animate({ scrollTop: 0 }, "slow");
		},
		error: function(xhr, ajaxOptions, thrownError) {
			$.easyNotification(xhr.status + " : " + thrownError);
			$("html, body").animate({ scrollTop: 0 }, "slow");
		}
    });
})

function update() {
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
			$("#mystatus").empty();
			$("#mystatus").append("<h4>Kandidatuur</h4>");
			var CandState = c.ApplyState;
			var mystatus_data =
				"<p><label><b>Staatus:</b></label> " + CandState + "<br>"
				+	"<label><b>Erakond:</b></label> - <br>"
				+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
				+	"<label><b>Häälte arv:</b></label> - <br></p>";
			$("#mystatus").append(mystatus_data);
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#my_data_block").html(xhr.status);
			$("#my_data_block").html(thrownError);
		}
	});
}

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
				"<label>Eesnimi:</label><input type='text' id='fname' name='fname' value='" + c.Firstname +"'><br>"
			+	"<label>Perenimi:</label><input type='text' id='lname' name='lname' value='" + c.Lastname +"'><br>"			
			+	"<label>E-mail:</label><input type='text' id='email' name='email' value='" + c.Email +"'><br>"
			+	"<label>Facebook:</label><input type='text' id='face_id' name='face_id' value='" + c.Facebook_Id +"'><br>"
			+	"<label>Skype:</label><input type='text' id='skype' name='skype' value='" + c.Skype +"'><br>"
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
			var CandState = c.ApplyState;
			switch(CandState){
				case('NONE'): case('DECLINED'): {
					var mystatus_data =
					"<p><label><b>Staatus:</b></label> " + CandState + "<br>"
					+	"<label><b>Erakond:</b></label> - <br>"
					+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
					+	"<label><b>Häälte arv:</b></label> - <br></p>";
					break;
				}
				case('PENDING'):{
				var mystatus_data =
					"<p><label><b>Staatus:</b></label> " + CandState + "<br>"
					+	"<label><b>Erakond:</b></label> - <br>"
					+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
					+	"<label><b>Häälte arv:</b></label> - <br>"
					+	"<a href='javascript:void(0);' onclick='remove_cand()' id='remove_cand'><b>Eemalda mind kandidatuurist!</b></a></p>";
					break;		
				}
				case('ACTIVE'):{ 
					var mystatus_data =
					"<p><label><b>Staatus:</b></label> " + CandState + "<br>"
					+	"<label><b>Erakond:</b></label> " + c.PartyName + "<br>"
					+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
					+	"<label><b>Häälte arv:</b></label> " + c.VCount + "<br>"
					+	"<a href='javascript:void(0);' onclick='remove_cand()' id='remove_cand'><b>Eemalda mind kandidatuurist!</b></a></p>";	
					break;
				}
				default:{
					var mystatus_data =
					"<p><label><b>Staatus:</b></label> Ei kandideeri <br>"
					+	"<label><b>Erakond:</b></label> - <br>"
					+	"<label><b>Valimispiirkond:</b></label> " + c.ConstituencyName + "<br>"
					+	"<label><b>Häälte arv:</b></label> - <br></p>";
					break;
				}
			}
			$("#mystatus").append(mystatus_data);
		},
		error: function (xhr, ajaxOptions, thrownError) {
			$("#my_data_block").html(xhr.status);
			$("#my_data_block").html(thrownError);
		}
	});
}