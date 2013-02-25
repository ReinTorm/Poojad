(function($){
	
	/* The plugin extends the jQuery Core with four methods */
	
	/* Converting an element into a bounce box: */
	$.fn.bounceBox = function(){
		
		this.css({
			position	: 'relative',
			display		:  'none'
		});
		
		return this;
	}
	
	$.fn.bounceBoxShow = function(){
		this.css({
			display		: 'block'
		});
		return this;
	}
	
	$.fn.bounceBoxHide = function(){
		this.css({
			display		: 'none'
		});

		return this;
	}
	
	/* And the boxToggle method */
	$.fn.bounceBoxToggle = function(){		
		if(this.data('bounceShown'))
			this.bounceBoxHide();
		else
			this.bounceBoxShow();
		
		return this;
	}
	
})(jQuery);