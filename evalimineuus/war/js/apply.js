$(document).ready(function() {
  $('.popbox').popbox();
  $.ajax({
		url: "/profileData",
		type: "post",
		contentType: 'application/json; charset=utf-8',
		dataType: 'json',
		beforeSend: function() {},
		complete: function() {},
		success: function(jsonData){
			var c = jsonData[0];
			if(c.Firstname) $('#applyPage-Firstname').val(c.Firstname);
			if(c.Lastname) $('#applyPage-Lastname').val(c.Lastname);
			if(c.Isikukood) $('#applyPage-Isikukood').val(c.Isikukood);
			if(c.CID) $('#applyPage-Constituency #'+c.CID).prop('selected', true);
			if(c.PartyId) $('#applyPage-Party #'+c.PartyId).prop('selected', true);
			if(c.Aadress) $('#applyPage-Aadress').val(c.Aadress);
			if(c.Mobiil) $('#applyPage-Mobiil').val(c.Mobiil);
			if(c.Shortinfo) $('#applyPage-Shortinfo').val(c.Shortinfo);
			if(c.Longinfo) $('#applyPage-Longinfo').val(c.Longinfo);
		}
	}); 
});

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

$('#marginFixer').click(checkCandidateForm);

function checkCandidateForm(){
  var errors = false;
  $('ul#PartyNothingSelected').remove();
  $('ul#ConstNothingSelected').remove();
  var partySelect = $('#candidateForm select[name="party"]');
  var constSelect = $('#candidateForm select[name="constituency"]');
  if(!partySelect.val()){
    $('<ul class="ketchup-custom" id="PartyNothingSelected" style="display: block;"><li>Palun vali valimisringkond</li></ul>').insertAfter(partySelect);
    errors = true;
  }
  if(!constSelect.val()){
    $('<ul class="ketchup-custom" id="ConstNothingSelected" style="display: block;"><li>Palun vali piirkond</li></ul>').insertAfter(constSelect);
    errors = true;
  }
  if(!$.ketchup.allFieldsValid($('#candidateForm'), true)){
    errors = true;
  }
  if(errors){
    return false;
  }else{
    $("#opaque").hide();
    $('.box').fadeOut("fast");
  }
}


$('#formClean').click(function(){
    $('#candidateForm')[0].reset();
    $('ul.ketchup-custom').hide();
});
$('#candidateForm select[name="party"]').change(function(){
    $('ul#PartyNothingSelected').remove();
});
$('#candidateForm select[name="constituency"]').change(function(){
    $('ul#ConstNothingSelected').remove();
});

var curSubmit;
$('#candidatebutton').click(function(){
    if(!checkCandidateForm()){
        var jsonObj =$('#candidateForm').serializeObject();
        if(curSubmit) curSubmit.abort();
        curSubmit = $.ajax({ 
            url: "/submitCandidate",
            type: "post",
            data: JSON.stringify(jsonObj),
            contentType: 'application/json; charset=utf-8',
            dataType: 'json',
            beforeSend: function() { $('#candidatebutton').hide(); $('#buttonLoader').addClass("loading"); },
            complete: function() {  $('#candidatebutton').show(); $('#buttonLoader').removeClass("loading"); },
            success: function(jsonData){
                $.easyNotification(jsonData.message); 
                $("html, body").animate({ scrollTop: 0 }, "slow");
            },
            error: function(xhr, ajaxOptions, thrownError) {
                $.easyNotification(xhr.status + " : " + thrownError);
                $("html, body").animate({ scrollTop: 0 }, "slow");
            }
        });
    }else{
      alert("Palun vaata oma kandideerimisavaldus üle!");
    }
})


$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};