<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
/*
--
predisposizione per più di un form in una pagina - start
--
var array_actionForm = $("form.action-form");
if (array_actionForm != null && array_actionForm.length > 0) {
	for (var i = 0; i < array_actionForm.length;i++) {
	var currentForm = array_actionForm[i];
*/

console.log("\n\n@nkjoep: please translate Mootoolsian --> jQuerian in /WEB-INF/apsadmin/jsp/common/template/extraresources/inc/js_trees_context_menu.jsp :F\n\n")

		var iconPath = "<wp:resourceURL />administration/_OLD/mint/img/icons/16x16/";
		var currentForm = $("form.action-form");
		if (null != currentForm) {
		//if
			var currentFormInputs = currentForm.find('li.tree_node_flag input[type="radio"]');
				console.log("currentForm:", currentForm);
				console.log("currentFormInputs:", currentFormInputs);
				currentFormInputs.each(function() {
					$(this).css('position', 'absolute');
					$(this).css('left', '-9999px');
				});

			var myActionMenu = currentForm.find('#actions-container p.buttons');
				currentForm.find('#actions-container').remove();
				myActionMenu.attr('id','actions-menu'); // prop() ?
				myActionMenu.removeClass('margin-small-vertical');
				myActionMenu.addClass('margin-small-horizontal');
				//myActionMenu.fade('out'); // restore with jQuery method
				myActionMenu.css('display', 'none');
				console.log("myActionMenu", myActionMenu);
				myActionMenu.find('button').each(function() {
					$(this).removeClass("btn-small");
					$(this).addClass("btn-mini");
					console.log("myActionButton", $(this));
				});

				var labels = currentForm.find("li.tree_node_flag label");
				if (labels != null && labels.length > 0) {
					for (var y = 0; y < labels.length;y++) {
						var myLabel = labels[y];
						console.log(myLabel);
							var myInput = $($(myLabel).attr('for'));
							if (myInput.prop('checked') == true) {
								myLabel.addClass('highlight');
								myActionMenu.insertAfter(myLabel);
								myActionMenu.set('tween', {duration: 'short'});
								myActionMenu.css('display', 'inline-block');
								myActionMenu.fade('in');
							}
							$(myLabel).css("cursor","pointer"); //provare?
							$(myLabel).on("click", function() {
								//e.stop();
								console.log(myLabel);
								var clickedLabel = this;
								//clickedLabel.set('morph', { duration: 'short' });
								//clickedLabel.morph('.highlight');
								myActionMenu.insertAfter(clickedLabel);
								//myActionMenu.set('tween', {duration: 'short'});
								myActionMenu.css('display', 'inline-block');
								//myActionMenu.fade('in');

								//creo temp e clono
									var labelsArray = $.merge([], labels);
								//creo rimuovo
									labelsArray = jQuery.grep(labelsArray, function(value) {
									  return value != clickedLabel;
									});

								//dall'array delle label rimuovo quella corrente e per ciascuna di loro setto morph
									$(labelsArray).each(function(myOtherLabel) {
										//$(myOtherLabel).set('morph', {duration: 'long'});
										//$(myOtherLabel).morph('.reset');
									});
							});
					}
				}
		//endif
		}



/*
--
predisposizione per più di un form in una pagina - end
--
	}
}
*/