jQuery(function(){
	var $ = jQuery;
	var clock = 4 * 1000;
	var TIMESTAMP_ATTR = 'data-entando-timestamp';
	var STREAM_ROOT = $('#activity-stream');

	var url = Entando.backoffice.streamUpdateAjaxUrl;

	var updateStream = function(elementsArray) {
		var checkIfNewOrUpdateStreamItem = function(stream) {
			var ts = $(stream).attr(TIMESTAMP_ATTR);
			var findstring = 'li['+TIMESTAMP_ATTR+'="'+ts+'"]';
			console.log('checkIfNewOrUpdateStreamItem', ts, findstring);
			var found = $(findstring, STREAM_ROOT);
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
		var els = elementsArray;
		if (els!==undefined) {
			var rawTs = els.attr(TIMESTAMP_ATTR);
			ts = new Date(rawTs.split('|')[0]);
			ts.setMilliseconds(rawTs.split('|')[1]);
			//console.log(els[0]);
			//console.log(TIMESTAMP_ATTR, ts);
			$.each(els.get().reverse(), function(index, item){
				//console.log('updating', index, checkIfNewOrUpdateStreamItem(item), item);
				var check = checkIfNewOrUpdateStreamItem(item);
				if (check.update) {
					check.updateEl.replaceWith(item);
				}
				else {
					$(item).prependTo(STREAM_ROOT);
				}
			});
			postUpdate(els);
		}
	};

	var postUpdate = function(elementsArray){
		$('[data-toggle="tooltip"]', STREAM_ROOT).tooltip({trigger: 'hover'});
	};

	var ajaxRequest = function(complete, success, data) {
		return $.ajax({
				dataType: 'html',
				async: true,
				url: url,
				data: data || { date: new Date() },
				success: function(data, textStatus, jqXHR) {
					var streamElements = $('li', '<ajax>'+data+'</ajax>');
					updateStream(streamElements);
					//streamElements.prependTo($('#activity-stream'))
					//console.log('streamElements', streamElements);
				}
			})
	};

	var askForUpdate = function() {
		ajaxRequest();
	}

	var routineInterval = setInterval(askForUpdate, clock);
	console.log('stream ready');

	$('body').on('click', function(ev){
		console.log(ev.timeStamp)
		console.log('wewew');
	})
});