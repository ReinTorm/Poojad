$(document).ready(function(){

	/* Converting the #box div into a bounceBox: */
	$('#votedmessage').bounceBox();

	/* Listening for the click event and toggling the box: */
	$('a.votebutton').click(function(e){

		$('#votedmessage').bounceBoxToggle();
		e.preventDefault();
		setTimeout(function() {
		$('#votedmessage').trigger('click');
		}, 3e3);
	});
	
	/* When the box is clicked, hide it: */
	$('#votedmessage').click(function(){
		$('#votedmessage').bounceBoxHide();
	});
});
