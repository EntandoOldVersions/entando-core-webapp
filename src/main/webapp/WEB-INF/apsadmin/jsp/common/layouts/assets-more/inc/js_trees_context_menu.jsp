<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

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
	var myActionMenu = $('#actions-container .buttons', currentForm);

	$('#actions-container', currentForm).remove();
	myActionMenu.removeClass('margin-small-vertical');

	//the labels
	var labels = $('li.tree_node_flag label', currentForm);

	//prepare and attach popover to labels
	labels.popover({
		html: true,
		content: myActionMenu,
		placement: "right",
		animation: false,
		container: currentForm
	});

	//for each label if checked just show the menu
	jQuery.each(labels, function(index, myLabel){
		var myLabel = $(myLabel);
		var myInput = $('#'+myLabel.attr('for'));
		if (myInput.attr('checked') == 'checked') {
			$(myLabel).addClass('text-info');
			$(myLabel).popover('show');

			//prepare and attach tooltips to action buttons
			$(myActionMenu).tooltip({
				container: myActionMenu,
				selector: "[data-toggle=tooltip]"
			});
		}
		myLabel.css("cursor","pointer");
	});


	//onclick event delegation for the labels
	$(currentForm).delegate('li.tree_node_flag label', 'click', function() {
		//e.stop();
		var clickedLabel = this;

		//hide any popover except for the one of the clicked label
		//hide proved to be asynchronous, that's why we are excluding the unwanted label using .not()
		labels.not(clickedLabel).popover('hide');
		//show the popover for the clicked label
		$(clickedLabel).popover('show');

		//prepare and attach tooltips to action buttons
		$(myActionMenu).tooltip({
			container: myActionMenu,
			selector: "[data-toggle=tooltip]"
		});

		//remove the class text-info from the other labels
		labels.removeClass('text-info');
		//add the class to the clicked label
		$(clickedLabel).addClass('text-info');

	});
});