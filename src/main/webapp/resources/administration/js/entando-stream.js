jQuery(function(){
	var windowTitle = window.document.title;
	var $ = jQuery;
	var routineInterval = null;
	var clock = 4 * 1000;
	var TIMESTAMP_ATTR = 'data-entando-timestamp';
	var TIMESTAMP_COMMENT_ATTR = 'data-entando-timestamp-comment';
	var STREAM_ROOT = $('#activity-stream');
	var STREAM_UPDATE_EL = $('#stream-updates-alert');
	var TMP_CONTAINER = $('<ul class="ajax tmp"></ul>');
	var LIST_UPDATE_URL = Entando.backoffice.streamListUpdateAjaxUrl;
	var COMMENT_UPDATE_URL = Entando.backoffice.streamAddCommentAjaxUrl;

	var getTsFromStreamEl = function(streamEl) {
		var attrTm = $(streamEl).attr(TIMESTAMP_ATTR).split('|');
		var ts = new Date(attrTm[0]);
		ts.setMilliseconds(attrTm[1]);
		return ts;
	}
	var getCommentTsFromStreamEl = function(streamEl) {
		var attrTm = $(streamEl).attr(TIMESTAMP_COMMENT_ATTR).split('|');
		var ts = new Date(attrTm[0]);
		ts.setMilliseconds(attrTm[1]);
		return ts;
	}
	getTsStringFromDate = function(date) {
		//2013-12-13 11:46:59|0207
		var date = new Date(date);
		return date.getFullYear()
			+'-'+ (date.getMonth()+1<10 ? ('0'+(date.getMonth()+1)) : date.getMonth()+1)
			+'-'+ (date.getDate()<10? ('0'+date.getDate()) : date.getDate())
			+' '+ (date.getHours()<10? ('0'+date.getHours()) : date.getHours())
			+':'+ (date.getMinutes()<10? ('0'+date.getMinutes()) : date.getMinutes())
			+':'+ (date.getSeconds()<10? ('0'+date.getSeconds()) : date.getSeconds())
			+'|'+ (
				(0<=date.getMilliseconds()&&date.getMilliseconds()<10) ? ('000'+date.getMilliseconds()) :
						(10<=date.getMilliseconds()&&date.getMilliseconds()<100) ? ('00'+date.getMilliseconds()) :
								(100<=date.getMilliseconds()&&date.getMilliseconds()<1000) ? ('0'+date.getMilliseconds()) : date.getMilliseconds()
				)
	};

	var LATEST_STREAM_TS = getTsFromStreamEl(STREAM_ROOT.children('li').first());
	var LATEST_COMMENT_TS = getCommentTsFromStreamEl(STREAM_ROOT.children('li').first());

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
			$.each(els.reverse(), function(index, item){
				item = $(item);

				if (index==1) {
					var ts = getTsFromStreamEl(item);
					if ( ts.getTime() > LATEST_COMMENT_TS.getTime() ) {
						LATEST_COMMENT_TS = ts;
					}
				}

				var check = checkIfNewOrUpdateStreamItem(item);
				if (check.update) { // update item
					var ts = item.attr(TIMESTAMP_ATTR);
					var oldItem = $('li['+TIMESTAMP_ATTR+'="' +ts+ '"]', STREAM_ROOT);
					var oldComment = $('.insert-comment', oldItem);
					$('.insert-comment', item).replaceWith(oldComment);
					check.updateEl.replaceWith(item);
				}
				else { //new item
					var ts = getTsFromStreamEl(item);
					if ( ts.getTime() > LATEST_STREAM_TS.getTime() ) {
						LATEST_STREAM_TS = ts;
					}
					item.addClass('hide');
					item.children('.insert-comment.hide').removeClass('hide');
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
		$('[data-toggle="tooltip"]', elementsArray).tooltip({trigger: 'hover'});
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
				method: 'post',
				dataType: 'html',
				async: true,
				url: LIST_UPDATE_URL,
				data: data || {
					ajax: true,
					lastStreamTimestamp: getTsStringFromDate(LATEST_STREAM_TS),
					lastCommentTimestamp: getTsStringFromDate(LATEST_COMMENT_TS)
				},
				success: function(data, textStatus, jqXHR) {
					var streamElements = TMP_CONTAINER.html(data).children('li');
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
		$.ajax({
			url: COMMENT_UPDATE_URL,
			method: 'post',
			data: $(this).serialize(),
			beforeSend: pauseRoutine,
			success: function() {
				askForUpdate();
				startRoutine();
			}
		});
	});


	startRoutine();
});