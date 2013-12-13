jQuery(function(){
	var windowTitle = window.document.title;
	var $ = jQuery;
	var routineInterval = null;
	var clock = 4 * 1000;
	var TIMESTAMP_ATTR = 'data-entando-timestamp';
	var STREAM_ROOT = $('#activity-stream');
	var STREAM_UPDATE_EL = $('#stream-updates-alert');

	var LIST_UPDATE_URL = Entando.backoffice.streamListUpdateAjaxUrl;
	var COMMENT_UPDATE_URL = Entando.backoffice.streamAddCommentAjaxUrl;

	var setWindowTitle = function(title){
		if (title!==undefined) {
			window.document.title = '('+title+') ' + windowTitle;
		}
		else {
			window.document.title = windowTitle;
		}
	};

	var checkIfNewOrUpdateStreamItem = function(stream) {
		var ts = $(stream).attr(TIMESTAMP_ATTR);
		var findstring = 'li['+TIMESTAMP_ATTR+'="'+ts+'"]';
		var found = STREAM_ROOT.children(findstring);
		var el = undefined;
		if (found.length>0){
			el = found;
		}
		found=found.length>0;
		return {
				update: (found ? true : false),
				newone: (!found ? true : false),
				updateEl: el
			};
	};

	var updateStream = function(elementsArray) {
		var els = elementsArray;
		if (els!==undefined) {
			els = els.get();
			preUpdate(els);
			//var rawTs = els.attr(TIMESTAMP_ATTR);
			//ts = new Date(rawTs.split('|')[0]);
			//ts.setMilliseconds(rawTs.split('|')[1]);
			//console.log(els[0]);
			//console.log(TIMESTAMP_ATTR, ts);
			$.each(els.reverse(), function(index, item){
				item = $(item);
				//console.log('updating', index, checkIfNewOrUpdateStreamItem(item), item);
				var check = checkIfNewOrUpdateStreamItem(item);
				if (check.update) {
					var ts = item.attr(TIMESTAMP_ATTR);
					var oldItem = $('li['+TIMESTAMP_ATTR+'="' +ts+ '"]', STREAM_ROOT);
					var oldComment = $('.insert-comment', oldItem);
					$('.insert-comment', item).replaceWith(oldComment);
					check.updateEl.replaceWith(item);
				}
				else {
					item.addClass('hide');
					$('.insert-comment.hide', item).removeClass('hide');
					item.appendTo(STREAM_UPDATE_EL);
				}
			});
			postUpdate(els);
		}
	};
	var preUpdate = function(elementsArray) {
		var news = 0;
		var newsReadyToGo = STREAM_UPDATE_EL.children('li').get().length;
		$.each(elementsArray, function(index, item){
			var check = checkIfNewOrUpdateStreamItem(item);
			if (check.newone) { news = news +1; }
		});
		var numberEl = $('.n', STREAM_UPDATE_EL);
		numberEl.text(news + newsReadyToGo);
		if (news + newsReadyToGo) {
			STREAM_UPDATE_EL.removeClass('hide');
			setWindowTitle(news + newsReadyToGo);
		}
		else {
			STREAM_UPDATE_EL.addClass('hide');
			setWindowTitle();
		}
	};
	var postUpdate = function(elementsArray){
		$('[data-toggle="tooltip"]', STREAM_ROOT).tooltip({trigger: 'hover'});
	};

	var displayUpdates = function(elementsArray) {
		$.each(elementsArray, function(index, item){
			item = $(item);
			item.removeClass('hide');
			item.prependTo(STREAM_ROOT);
		})
		STREAM_UPDATE_EL.addClass('hide');
	}

	var ajaxRequest = function(data) {
		return $.ajax({
				dataType: 'html',
				async: true,
				url: LIST_UPDATE_URL,
				data: data || { ajax: true },
				success: function(data, textStatus, jqXHR) {
					var streamElements = $('<ul class="ajax">'+data+'</ul>').children('li');
					updateStream(streamElements);
				}
			})
	};

	var askForUpdate = function() { ajaxRequest(); }

	STREAM_UPDATE_EL.on('click touchstart', function(){
		pauseRoutine();
		displayUpdates(STREAM_UPDATE_EL.children('li'));
		setWindowTitle();
		startRoutine();
	});

	var startRoutine = function() {
		routineInterval = setInterval(askForUpdate, clock);
		return routineInterval;
	};
	var pauseRoutine = function() {
		clearInterval(routineInterval);
	}
	/** comment ajax **/
	STREAM_ROOT.delegate('.insert-comment form', 'submit', function(ev){
		ev.preventDefault();
		console.log('form, prevented', ev);
		$.ajax({
			url: COMMENT_UPDATE_URL,
			method: 'post',
			data: $(this).serialize(),
			beforeSend: pauseRoutine,
			success: function() {
				$
				askForUpdate();
				startRoutine();
			}
		});
	});


	startRoutine();
});