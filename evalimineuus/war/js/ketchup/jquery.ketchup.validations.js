jQuery.ketchup

.validation('required', 'Kohustuslik väli.', function(form, el, value) {
	var type = el.attr('type').toLowerCase();
  	
  if(type == 'checkbox' || type == 'radio') {
    return (el.attr('checked') == true);
  } else {
    return (value.length != 0);
  }
})

.validation('minlength', 'Peab olema vähemalt {arg1} märki.', function(form, el, value, min) {
  return (value.length >= +min);
})

.validation('maxlength', 'Peab olema lühem kui {arg1} märki.', function(form, el, value, max) {
  return (value.length <= +max);
})

.validation('rangelength', 'Peab olema {arg1} ja {arg2} vahel.', function(form, el, value, min, max) {
  return (value.length >= min && value.length <= max);
})

.validation('min', 'Peab olema vähemalt {arg1}.', function(form, el, value, min) {
  return (this.isNumber(value) && +value >= +min);
})

.validation('max', 'Peab olema väiksem kui {arg1}.', function(form, el, value, max) {
  return (this.isNumber(value) && +value <= +max);
})

.validation('range', 'Peab olema {arg1} ja {arg2} vahel.', function(form, el, value, min, max) {
  return (this.isNumber(value) && +value >= +min && +value <= +max);
})

.validation('number', 'Peab olema arv.', function(form, el, value) {
  return this.isNumber(value);
})

.validation('digits', 'Peab koosnema ainult arvudest.', function(form, el, value) {
  return /^\d+$/.test(value);
})

.validation('email', 'Vigane E-Mail.', function(form, el, value) {
  return this.isEmail(value);
})

.validation('url', 'Vigane URL.', function(form, el, value) {
  return this.isUrl(value);
})

.validation('name', 'Sisesta õige nimi.', function(form, el, value) {
  return this.isUsername(value);
})

.validation('match', 'Peab olema {arg1}.', function(form, el, value, word) {
  return (el.val() == word);
})

.validation('contain', 'Peab sisaldama {arg1}', function(form, el, value, word) {
  return this.contains(value, word);
})

.validation('date', 'Peab olema õige kuupäev.', function(form, el, value) {
  return this.isDate(value);
})

.validation('minselect', 'Vali vähemalt {arg1}.', function(form, el, value, min) {
  return (min <= this.inputsWithName(form, el).filter(':checked').length);
}, function(form, el) {
  this.bindBrothers(form, el);
})

.validation('maxselect', 'Vali vähem kui {arg1}.', function(form, el, value, max) {
  return (max >= this.inputsWithName(form, el).filter(':checked').length);
}, function(form, el) {
  this.bindBrothers(form, el);
})

.validation('rangeselect', 'Vali rohkem kui {arg1} ja vähem kui {arg2}.', function(form, el, value, min, max) {
  var checked = this.inputsWithName(form, el).filter(':checked').length;
  
  return (min <= checked && max >= checked);
}, function(form, el) {
  this.bindBrothers(form, el);
});