<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
var iconPath = "<wp:resourceURL />administration/_OLD/mint/img/icons/16x16/";

//for each elements 'form.action-form'
jQuery.each($('form.action-form'), function(index, currentForm){

	//current form
	var currentForm = $(currentForm);
	
	//the inputs type[radio]
	var currentFormInputs = $('li.tree_node_flag input[type="radio"]', currentForm);
		currentFormInputs.each(function() {
			$(this).css('position', 'absolute');
			$(this).css('left', '-9999px');
		});

	//the action container 
	var myActionMenu = $('#actions-container p.buttons', currentForm);
		$('#actions-container', currentForm).remove();
		//myActionMenu.attr('id','actions-menu'); // prop() ?
		myActionMenu.removeClass('margin-small-vertical');
		myActionMenu.addClass('margin-small-horizontal');
		myActionMenu.css('display', 'none');
	//for each button remove class btn-small and add class btn-mini
	$('button',myActionMenu).each(function() {
		$(this).removeClass("btn-small");
		$(this).addClass("btn-mini");
	});

	//the labels
	var labels = $('li.tree_node_flag label',currentForm);
	//for each label if checked just show the menu
	jQuery.each(labels, function(index, myLabel){
		var myLabel = $(myLabel);
		var myInput = $('#'+myLabel.attr('for'));
		if (myInput.attr('checked') == 'checked') {
			myLabel.addClass('highlight');
			myActionMenu.insertAfter(myLabel);
			myActionMenu.css('display', 'inline-block');
		}
		myLabel.css("cursor","pointer");
	});

	//onclick event delegation for the labels
	$(currentForm).delegate('li.tree_node_flag label', 'click', function() {
		//e.stop();
		var clickedLabel = this;
		//insert the menu and show it
		myActionMenu.insertAfter(clickedLabel);
		myActionMenu.css('display', 'inline-block');
		//remove the class text-info from the other labels  
		labels.removeClass('text-info');
		//add the class to the clicked label
		$(clickedLabel).addClass('text-info');

	});
});