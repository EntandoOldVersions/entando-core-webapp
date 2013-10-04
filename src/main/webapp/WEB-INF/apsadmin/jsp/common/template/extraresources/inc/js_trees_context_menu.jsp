<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
/*
--
predisposizione per più di un form in una pagina - start
--
var array_actionForm = document.getElements("form.action-form");
if (array_actionForm != null && array_actionForm.length > 0) {
	for (var i = 0; i < array_actionForm.length;i++) {
	var currentForm = array_actionForm[i];
*/

console.log("\n\n@nkjoep: please translate Mootoolsian --> jQuerian in /WEB-INF/apsadmin/jsp/common/template/extraresources/inc/js_trees_context_menu.jsp :F\n\n")

		var iconPath = "<wp:resourceURL />administration/mint/img/icons/16x16/";
		var currentForm = document.getElement("form.action-form");
		if (null != currentForm) {
		//if
			var currentFormInputs = currentForm.getElements('li.tree_node_flag input[type="radio"]');
				currentFormInputs.each(function(myInput) {
					myInput.setStyle('position', 'absolute');
					myInput.setStyle('left', '-9999px');
				});
			
			var myActionMenu = currentForm.getElement('#actions-container p.buttons');
				currentForm.getElement('#actions-container').dispose();
				myActionMenu.setProperty('id','actions-menu');
				myActionMenu.removeClass('buttons');
				myActionMenu.addClass('actions-menu');
				myActionMenu.fade('out');
				myActionMenu.setStyle('display', 'none');
				var path = null; //istanzio a null
				myActionMenu.getElements('input').each(function(myActionButton) {
					/*
					 	risulta essere meno performante e pericoloso il replace:
					 		var myActionButtonSrc = myActionButton.getProperty('src');
							myActionButton.setProperty('src', myActionButtonSrc.replace('/32x32/','/16x16/'));
							myActionButtonSrc = myActionButton.getProperty('src');		
							myActionButton.setProperty('src', myActionButtonSrc.replace('/common/','/mint/')); 
					 */
					//istazion path corrente
					var currentPath;
					//se path esiste lo uso per spezzare l'url e trovare il nomefile
					if (path != null) { currentPath = iconPath+myActionButton.getProperty('src').substring(path); }
					else {
						//recupero il path originale
						var actionButtonPath = myActionButton.getProperty('src');
						//splitto e recupero il nome del file
						var filename = actionButtonPath.split("/"); //array
							filename = filename[filename.length-1]; //recupero il nomefile
						//costruisco path + nomefile
						currentPath = iconPath+filename;
						//setto dove trimmare
						path = actionButtonPath.substring(0,actionButtonPath.length-filename.length).length;
					}
					//setto quello che ho trovato
					myActionButton.setProperty('src', currentPath);
				});
			
				var labels = currentForm.getElements("li.tree_node_flag label");
				if (labels != null && labels.length > 0) {
					for (var y = 0; y < labels.length;y++) {
						var myLabel = labels[y];
							var myInput = document.id(myLabel.getProperty('for'));
							if (myInput.getProperty('checked') == true) {
								myLabel.addClass('highlight');
								myActionMenu.inject(myLabel, 'after');
								myActionMenu.set('tween', {duration: 'short'});
								myActionMenu.setStyle('display', 'inline-block');
								myActionMenu.fade('in');
							}
							myLabel.setStyle("cursor","pointer"); //provare?
							myLabel.addEvent('click', function(e){
								//e.stop();
								var clickedLabel = this;
								clickedLabel.set('morph', { duration: 'short' }); 
								clickedLabel.morph('.highlight');
								myActionMenu.inject(clickedLabel, 'after');
								myActionMenu.set('tween', {duration: 'short'});
								myActionMenu.setStyle('display', 'inline-block');
								myActionMenu.fade('in');
								//creo temp
									var labelsArray = [];
								//creo clono
									labelsArray.combine(labels);
								//creo rimuovo
									labelsArray.erase(clickedLabel);
								//dall'array delle label rimuovo quella corrente e per ciascuna di loro setto morph
									labelsArray.each(function(myOtherLabel) {
										myOtherLabel.set('morph', {duration: 'long'});
										myOtherLabel.morph('.reset');
									});
							}.bind(myLabel));
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