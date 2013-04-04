$(document).ready(function() {

	$('.popbox').popbox();


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

