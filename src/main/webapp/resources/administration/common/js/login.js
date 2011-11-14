window.addEvent('domready', function(){
	
	var usernameElement = document.id('username');
	if (usernameElement != null) {
		usernameElement.focus();		
	}
	
	var fadingElement = document.id('fieldset_space');
	if (fadingElement != null) {
		var durationTime = 3000;
		fadingElement.set('tween', {
			duration: durationTime,
		}); 
		fadingElement.tween('border-color','#DEDEDE','#FE9900');
		fadingElement.tween('border-color','#FE9900', '#DEDEDE');
	}
});