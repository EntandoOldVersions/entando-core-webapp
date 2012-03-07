window.addEvent("domready",function(){
	var entandoApplyLinkToEditor = function (href) {
		//alert(href);
		var editor = window.opener.entandoCKEditor;	
		var selection = editor.getSelection();
		var ranges = selection.getRanges(true);
		if (ranges.length == 1 && ranges[0].collapsed) {
			var text = new CKEDITOR.dom.text('', editor.document);
			ranges[0].insertNode(text);
			ranges[0].selectNodeContents(text);
			selection.selectRanges(ranges);
		}
		var style = new CKEDITOR.style({"element": "a", "attributes": { "data-cke-saved-href": href, "href": href } });
		style.type = CKEDITOR.STYLE_INLINE;	// need to override... dunno why.
		style.apply(editor.document);
		//window.opener.console.log(style);
	};

	$('form_externalURL').addEvent('submit', function(event){
		event.preventDefault();
		if ( $('txtName').value.length == 0 ) {
			alert( 'Insert a valid URL (example: http://www.mysite.com/)' ) ;
		}
		else {
			var hrefValue = "#!U;" + $('txtName').value + "!#";
			entandoApplyLinkToEditor(hrefValue);
			window.close();
		}
	});	
	//Page Link
	$('form_pageLink').addEvent('submit', function(event){
		event.preventDefault();
	    var pageCode = null;
    	var pageCodes = $('pageTree').getElements('input[name=selectedNode]');
		pageCodes.each(function(item, index){
	    	if (item.getProperty("checked") ) {
		    	pageCode = item.getProperty("value");
	    	} 
    	});
		//debugger;
		if ( null == pageCode ) {
			alert('Choose a Page');
		}
		else {
			var hrefValue = "#!P;" + pageCode + "!#";
			entandoApplyLinkToEditor(hrefValue);
			window.close();
		}
	});	
	//Content Link
	$('button_contentLink').addEvents({
	    'click': function(event){
	    	var contentCode = null;
	    	var contentCodes = $('contentListTable').getElements('input[name=contentId]').getProperty("value");
	    	contentCodes.each(function(item, index){
		    	if ( $('contentId_' + item).getProperty("checked") ) {
			    	contentCode = $('contentId_' + item).getProperty("value");
		    	} 
	    	});

			if ( null == contentCode ) {
				event.preventDefault();
				alert( 'Choose a Content');
			}
			else {
				var hrefValue = "#!C;" + contentCode + "!#";
				entandoApplyLinkToEditor(hrefValue);
				window.close();
			}
	    },
	    //FIXME: se ne va per la tangente col keypress del URL esterno per via del tabindex. Fixare :(
	    'keypress': function(event){
	    	contentCodes = $('contentListTable').getElements('input[name=contentId]').getProperty("value");
	    	contentCodes.each(function(item, index){
		    	if ( $('contentId_' + item).getProperty("checked") ) {
			    	contentCode = $('contentId_' + item).getProperty("value");
		    	} 
	    	});

			if ( contentCode.length == 0 ) {
				event.preventDefault
				alert( 'Choose a Content');
			}
			else {
				var hrefValue= "#!C;" + contentCode + "!#";
				entandoApplyLinkToEditor(hrefValue);
				window.close();
			}
	    }
	});
});//domready