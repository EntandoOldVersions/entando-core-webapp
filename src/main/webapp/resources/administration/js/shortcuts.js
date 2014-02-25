jQuery(function(){
	$('#edit-shortcuts').on('click', function(ev){
		ev.preventDefault();
		$('.shortcuts-container').toggleClass('edit-mode');
		$('.shortcuts-container .empty').toggleClass('margin-small-bottom');
	});

	var animationDuration = 250;

	var fadeOut = function (els, callback) {
		$(els[0]).addClass('fadeOut');
		$(els[0]).removeClass('fadeIn');
		$(els[1]).addClass('fadeOut');
		$(els[1]).removeClass('fadeIn');
		if(callback) callback();
	};

	var fadeIn = function (els, callback) {
		window.setTimeout(function(){
			$(els[0]).addClass('fadeIn');
			$(els[0]).removeClass('fadeOut');
			$(els[1]).addClass('fadeIn');
			$(els[1]).removeClass('fadeOut');
			if(callback) callback()
		}, animationDuration);
	}

	var scAjax = function(url) {
		$.ajax({url: url});
	};

	var scBarFind = function(item) {
		if ( $(item).hasClass('btn-toolbar') ) { return $(item); }
		return $(item).parents('.btn-toolbar');
	};
	var scGetPosition = function(item) {
		return scBarFind(item).attr('data-entando-position');
	};
	var scSetPosition = function(item, sign) {
		var el = scBarFind(item);
		var oldv = parseInt(el.attr('data-entando-position'));
		var newv = oldv;
		if (sign == '+') {
			newv = (newv+1) > 10 ? 10 : (newv+1);
		}
		else {
			newv = (newv-1) < 0 ? 0 : ((-1)+newv);
		}
		el.attr('data-entando-position', newv);
		$('[data-entando-role="empty"]', el).text(newv+1);
		var as = $('a[href]', el);
		$.each(as, function(index, a){
			var a = $(a);
			var href = a.attr('href');
			href = href.replace(/position=\d+/gi, 'position='+ newv +'');
			href = href.replace(/positionTarget=\d+/gi, 'positionTarget='+ newv +'');
			if (a.attr('data-entando-action')=='shortcut-move-down') {
					href = href.replace(/positionDest=\d+/gi, 'positionDest='+ (newv+1) +'');
			}
			else {
				href = href.replace(/positionDest=\d+/gi, 'positionDest='+ (newv-1) +'');
			}
			a.attr('href', href);
		});
	};
	var scMoveUp = function(ev) {
		ev.preventDefault();
		scAjax($(this).attr('href'));
		var scBlock = scBarFind(this);
		var otherEl = scBlock.prev();
		if (otherEl.length>0) {
			fadeOut([scBlock, otherEl]);
			var cb = function() {
				scSetPosition(scBlock, '-');
				scSetPosition(otherEl, '+');
				scBlock.insertBefore(otherEl);
			}
			fadeIn([scBlock, otherEl], cb);
		}
	};
	var scMoveDown = function(ev) {
		ev.preventDefault();
		scAjax($(this).attr('href'));
		var scBlock = scBarFind(this);
		var otherEl = scBlock.next();
		if (otherEl.length>0) {
			fadeOut([scBlock, otherEl]);
			var cb = function() {
				scSetPosition(scBlock, '+');
				scSetPosition(otherEl, '-');
				scBlock.insertAfter(otherEl);
			};
			fadeIn([scBlock, otherEl], cb);
		}
	};
	var scAdd = function(ev) {
		ev.preventDefault();
		var position = scGetPosition(this);
		$('#shortcut-configure-modal2 [name="position"]').val(position);
	};

	var scClear = function(ev) {
		//var pos = scGetPosition(this);
		//ev.preventDefault();
		//scAjax($(this).attr('href'));
	};

	$('body').delegate('[data-entando-action="shortcut-add"]', 'click', scAdd);
	$('body').delegate('[data-entando-action="shortcut-move-up"]', 'click', scMoveUp);
	$('body').delegate('[data-entando-action="shortcut-move-down"]', 'click', scMoveDown);
	$('body').delegate('[data-entando-action="remove""]', 'click', scClear);
});
