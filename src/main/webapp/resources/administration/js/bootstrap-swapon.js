+function ($) { "use strict";
	var selector = '[data-swapon]';
	var Swapon = function(el) {
		$(el).on('click', this.swap);
	}

	Swapon.prototype.swap = function(el) {
		var $this    = $(this)
    	var selector = $this.attr('data-swapon');

    	if (!selector) {
			selector = $this.attr('href')
			selector = selector && selector.replace(/.*(?=#[^\s]*$)/, '') // strip for ie7
		}
		selector = '#'+selector;

		$this.css('display', 'none');
		$this.trigger('swapon', ['hide']);

		$(selector).css('display', "");
		$(selector).trigger('swapon', ['show']);
	}

	$.fn.swapon = function (option) {
		return this.each(function () {
			var $this = $(this)
			var data  = $this.data('bs.swapon');

			if (!data) {
				data = new Swapon(this);
				$this.data('swapon', data);
			}
		})
	}

	$.fn.swapon.Constructor = Swapon

	$(selector).swapon();

}(window.jQuery);
