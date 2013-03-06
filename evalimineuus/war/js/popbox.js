(function(){

  $.fn.popbox = function(options){
    var settings = $.extend({
      selector      : this.selector,
      open          : '.open',
      box           : '.box',
      close         : '.close'
    }, options);

    var methods = {
      open: function(event){
        event.preventDefault();

        var pop = $(this);
        var box = $(this).parent().find(settings['box']);
        $("body").append("<div id='opaque' style='display: none;'></div>");


        if(box.css('display') == 'block'){
          methods.close();
        } else {
          $("#opaque").show();
          box.css({'display': 'block'});
        }
      },

      close: function(){
        $("#opaque").hide();
        $(settings['box']).fadeOut("fast");
      }
    };

    $(document).bind('keyup', function(event){
      if(event.keyCode == 27){
        methods.close();
      }
    });

    $(document).bind('click', function(event){
      if(!$(event.target).closest(settings['selector']).length){
        methods.close();
      }
    });

    return this.each(function(){
      $(settings['open'], this).bind('click', methods.open);
      $(settings['open'], this).parent().find(settings['close']).bind('click', function(event){
        event.preventDefault();
        methods.close();
      });
    });
  }

}).call(this);
