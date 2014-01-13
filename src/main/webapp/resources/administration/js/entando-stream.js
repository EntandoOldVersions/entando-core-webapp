jQuery(function(){ //dom is ready...
//settings
	var $ = jQuery;
	var WINDOW_TITLE_DEFAULT = window.document.title;
	var routineInterval = null;
	var CLOCK = 4 * 1000;
	var ANIMATION_DURATION = 600;
	var TIMESTAMP_ATTR = 'data-entando-creationdate';
	var TIMESTAMP_LAST_UPDATE_ATTR = 'data-entando-updatedate';
	var ID_ATTR = 'data-entando-id';
	var AJAX_UPDATE_SELECTOR = '[data-entando="ajax-update"]';
	var STREAM_ROOT = $('#activity-stream');
	var STREAM_UPDATE_EL = $('#stream-updates-alert');
	var TMP_CONTAINER = $('<ul class="ajax tmp"></ul>');
	var LOAD_MORE_BUTTON_EL = $('[data-entando="load-more-button"]');
	var STREAM_ITEM_EL_SELECTOR = 'li'
	var LIST_UPDATE_URL = Entando.backoffice.stream.list.updateUrl;
	var LIST_LOAD_MORE_URL = Entando.backoffice.stream.list.loadMoreUrl;
	var COMMENT_ADD_URL = Entando.backoffice.stream.comments.addUrl;
	var COMMENT_DELETE_URL = Entando.backoffice.stream.comments.deleteUrl;


//utility
	var getTsFromStreamEl = function(streamEl) {
		var attrTm = $(streamEl).attr(TIMESTAMP_ATTR).split('|');
		var ts = new Date(attrTm[0]);
		ts.setMilliseconds(attrTm[1]);
		if (!ts.getTime()>0) return new Date('1970-01-01');
		return ts;
	};

	var getLastUpdateTs = function(streamEl) {
		var attrTm = $(streamEl).attr(TIMESTAMP_LAST_UPDATE_ATTR).split('|');
		var ts = new Date(attrTm[0]);
		ts.setMilliseconds(attrTm[1]);
		if (!ts.getTime()>0) return new Date('1970-01-01');
		return ts;
	};

	var getTsStringFromDate = function(date) {
		//2013-12-13 11:46:59|207
		var date = new Date(date);
		if (!date.getTime()>0) return;
		return date.getFullYear()
			+'-'+ (date.getMonth()+1<10 ? ('0'+(date.getMonth()+1)) : date.getMonth()+1)
			+'-'+ (date.getDate()<10? ('0'+date.getDate()) : date.getDate())
			+' '+ (date.getHours()<10? ('0'+date.getHours()) : date.getHours())
			+':'+ (date.getMinutes()<10? ('0'+date.getMinutes()) : date.getMinutes())
			+':'+ (date.getSeconds()<10? ('0'+date.getSeconds()) : date.getSeconds())
			+'|'+ ((0<=date.getMilliseconds()&&date.getMilliseconds()<10) ? ('00'+date.getMilliseconds()) :
						(10<=date.getMilliseconds()&&date.getMilliseconds()<100) ? ('0'+date.getMilliseconds()) :
								date.getMilliseconds())
	};
	var setWindowTitle = function(title){
		if (title!==undefined) {
			window.document.title = '('+title+') ' + WINDOW_TITLE_DEFAULT;
		}
		else {
			window.document.title = WINDOW_TITLE_DEFAULT;
		}
	};
	var checkIfNewOrUpdateStreamItem = function(stream) {
		var id = $(stream).attr(ID_ATTR);
		var findstring = STREAM_ITEM_EL_SELECTOR+'['+ID_ATTR+'="'+id+'"]';
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
//stream
	var LAST_UPDATE_TS = getLastUpdateTs(STREAM_ROOT.children(STREAM_ITEM_EL_SELECTOR).first());
	var updateStream = function(elementsArray) {
		var els = elementsArray;
		if (els!==undefined) {
			els = els.get();
			if (els.length>0) {
				preUpdate(els);
				$.each(els.reverse(), function(index, item){
					item = $(item);
					if (index==0) {
						var ts = getLastUpdateTs(item);
						if ( ts.getTime() > LAST_UPDATE_TS.getTime() ) {
							LAST_UPDATE_TS = ts;
						}
					}
					var check = checkIfNewOrUpdateStreamItem(item);
					if (check.update) { // update item
						var oldItem = check.updateEl;
						var newItem = item;
						var oldRepl = $(AJAX_UPDATE_SELECTOR, oldItem).get();
						var newRepl  = $(AJAX_UPDATE_SELECTOR, newItem).get();
						$.each(oldRepl, function(index, el) {
							var el = $(el);
							el.replaceWith(newRepl[index])
						})
						els[index]=oldItem;
					}
					else { //new item
						item.addClass('hide hidden');
						$('.insert-comment.hide.hidden', item).removeClass('hide hidden');
						item.appendTo(STREAM_UPDATE_EL);
					}
				});
				postUpdate(els);
			}
		}
	};
	var preUpdate = function(elementsArray) {
		var news = 0;
		var newsReadyToGo = STREAM_UPDATE_EL.children(STREAM_ITEM_EL_SELECTOR).get().length;
		$.each(elementsArray, function(index, item){
			var check = checkIfNewOrUpdateStreamItem(item);
			if (check.newone) { news = news +1; }
		});
		var numberEl = $('.n', STREAM_UPDATE_EL);
		numberEl.text(news + newsReadyToGo);
		if (news + newsReadyToGo) {
			STREAM_UPDATE_EL.removeClass('hide hidden');
			setWindowTitle(news + newsReadyToGo);
		}
		else {
			STREAM_UPDATE_EL.addClass('hide hidden');
			setWindowTitle();
		}
	};
	var postUpdate = function(elementsArray){
		$.each(elementsArray, function(index, item){
			$('[data-toggle="tooltip"]', item).tooltip({trigger: 'hover'});
		});
	};
	var displayUpdates = function(elementsArray) {
		$.each(elementsArray, function(index, item){
			item = $(item);
			item.removeClass('hide hidden');
			item.prependTo(STREAM_ROOT);
		})
		STREAM_UPDATE_EL.addClass('hide hidden');
	};
	var ajaxUpdateStreamRequest = function(data) {
		return $.ajax({
				method: 'post',
				dataType: 'html',
				async: true,
				url: LIST_UPDATE_URL,
				data: data || {
					ajax: true,
					timestamp: getTsStringFromDate(LAST_UPDATE_TS)
				},
				success: function(data, textStatus, jqXHR) {
					var streamElements = TMP_CONTAINER.html(data).children(STREAM_ITEM_EL_SELECTOR);
					updateStream(streamElements);
				}
			})
	};
	var askForUpdate = function() { ajaxUpdateStreamRequest(); }
	var startRoutine = function() {
		routineInterval = setInterval(askForUpdate, CLOCK);
		return routineInterval;
	};
	var pauseRoutine = function() {
		clearInterval(routineInterval);
	}
	STREAM_UPDATE_EL.on('click touchstart', function(){
		pauseRoutine();
		displayUpdates(STREAM_UPDATE_EL.children(STREAM_ITEM_EL_SELECTOR));
		setWindowTitle();
		startRoutine();
	});

//comment ajax
	STREAM_ROOT.delegate('.insert-comment form', 'submit', function(ev){
		ev.preventDefault();
		var textarea = $('textarea', ev.target);
		if ($.trim(textarea.val()).length >0) {
			$.ajax({
				url: COMMENT_ADD_URL,
				method: 'post',
				data: $(this).serialize(),
				beforeSend: pauseRoutine,
				success: function() {
					var textarea = $('textarea', ev.target);
					textarea.val("");
					restoreSizeCommentTextarea(textarea);
					askForUpdate();
				},
				complete: startRoutine
			});
		}
	});
	STREAM_ROOT.delegate('[data-entando="remove-comment-ajax"]', 'click touchstart', function(ev){
		ev.preventDefault();
		var button = $(ev.target);
		var commentToDeleteEl = button.parents('[data-entando-commentid]').first();
		var streamId = commentToDeleteEl.parents(STREAM_ITEM_EL_SELECTOR+'['+ID_ATTR+']').attr(ID_ATTR);
		var commentToDeleteId = commentToDeleteEl.attr('data-entando-commentid');
		$.ajax({
			url: COMMENT_DELETE_URL,
			method: 'post',
			dataType: 'json',
			data: {
				'streamId': streamId,
				'commentId': commentToDeleteId
			},
			success: function(data, textStatus, jqXHR) {
				$('[data-entando-comment="'+data.commentId+'"]').fadeOut(ANIMATION_DURATION, function(){
					$(this).remove();
				})
			}
		})
	});
	var restoreSizeCommentTextarea = function(el) {
		var textarea = $(el);
		var lines = textarea.val().split('\n').length;
		textarea.attr('rows', lines > 10 ? 10 : lines);
	};
	$('#activity-stream').delegate('.insert-comment textarea', 'keydown blur', function(ev) {
		restoreSizeCommentTextarea(this);
	});
	$('#activity-stream').delegate('.insert-comment textarea', 'cut paste', function(ev) {
		var el = this;
		setInterval(function(){
			restoreSizeCommentTextarea(el);
		},200);
	});

//start stream routine
	startRoutine();

//load more
	var updateMoreStream = function(elementsArray) {
		$.each(elementsArray, function(index, item) {
			var item = $(item);
			item.removeClass('hide hidden');
			$('.insert-comment.hide.hidden', item).removeClass('hide hidden');
			item.appendTo(STREAM_ROOT);
		});
	};
	var loadMoreLoadingState = function(load) {
		if (load == true) {
			LOAD_MORE_BUTTON_EL.button('loading');
		}
		else {
			setTimeout(function() {
				LOAD_MORE_BUTTON_EL.button('reset');
			}, ANIMATION_DURATION);
		}
	};
	var ajaxLoadMoreRequest = function() {
		return $.ajax({
			url: LIST_LOAD_MORE_URL,
			method: 'post',
			data: {
				'ajax': true,
				timestamp: STREAM_ROOT.children(STREAM_ITEM_EL_SELECTOR).last().attr(TIMESTAMP_ATTR)
			},
			beforeSend: function(){ loadMoreLoadingState(true) },
			success: function(data, textStatus, jqXHR) {
				var streamElements = $('<ul class="ajax tmp"></ul>').html(data).children(STREAM_ITEM_EL_SELECTOR);
				updateMoreStream(streamElements);
				postUpdate(streamElements);
				loadMoreLoadingState();
			}
		});
	};
	LOAD_MORE_BUTTON_EL.on('click touchstart', function(){
		ajaxLoadMoreRequest();
	});
//domready
});