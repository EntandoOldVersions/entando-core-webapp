<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />

<script type="text/javascript"><!--
//--><![CDATA[//>
window.addEvent('domready', function(){
	$$("span.shortcut-toolbar").each(function(toolbar) {
		toolbar.inject(toolbar.getParent(), 'top');
	});
});
//<!]]>-->--</script>

<s:if test='#myClient == "advanced"'>
	<s:set var="allowedShortcutsVar" value="allowedShortcuts" />
	<s:if test="(null != #allowedShortcutsVar) && (#allowedShortcutsVar.size() > 0)">

		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/shortcuts-drag-drop.css" media="screen" />
		<script type="text/javascript" src="<wp:resourceURL />/administration/mint/js/jAPS-shortcuts.js"></script>
		
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Assets/LightFace.css" media="screen" />
		<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Source/LightFace.js"></script>
		<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Source/LightFace.Static.js"></script>
		
		<script type="text/javascript"><!--
		//--><![CDATA[//>	
		<%-- Here today, in defaultExtraResources someday --%>
		window.addEvent('domready', function(){
			//shortcuts /start
			var shortcuts = null;
			if (document.getElements("dl.maxiButton") != null) {
				shortcuts = new jAPSShortCuts({
					"ajaxSwapActionUrl": "<s:url action="swapMyShortcutAjax" namespace="/do/MyShortcut" />?strutsAction=2",  
					"configureActionUrl": "<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure"><s:param name="position" value="%{'POSitionTOKen'}" /><s:param name="strutsAction" value="1" /></s:url>",
					"prefixId": "fagiano_shortCut_",
					"draggables": ".maxiButton",
					"droppables": ".maxiButton",
					"handler": "img.move",
					"css": {
						"dragWhileDraggin": "dragged",
						"dropOver": "dropping",
						"clone": "dragClone",
						"dragLoading": "dragLoading",
						"dropLoading": "dropLoading",
						"divMessage": "message message_error"
					},
					"cloneOffsets": {
						"top": -19 ,
						"left": -140
					},
					"params": {
						"start": "positionTarget",
						"end": "positionDest"
					},
					"labels": {
						"messageTitle": "<s:text name="message.title.ActionErrors" />",
						"genericError": "<s:text name="core.shortcut.message.error.generic" />",
						"timeoutError": "<s:text name="core.shortcut.message.error.timeout" />",
						"configure": "<s:text name="label.configure" />",
						"clearPosition": "<s:text name="label.clear" />"+" "+"<s:text name="name.position" /> "
					},
					"iconShortcutClear": "<wp:resourceURL />administration/common/img/icons/22x22/shortcut-clear.png",
					onCompleteSwap: function(drag,drop) {
						//event fired when swap is done successfully.
						var dragAnchors = drag.getElements(".shortcut-toolbar a");
						var dropAnchors = drop.getElements(".shortcut-toolbar a");
						var dragPos = drag.get("id").split(this.options.prefixId)[1];
						var dropPos = drop.get("id").split(this.options.prefixId)[1];
						Array.each(dragAnchors, function(item){
							item.set("href",item.get("href").replace("position="+dropPos,"position="+dragPos));
							item.set("href",item.get("href").replace("positionTarget="+dropPos,"position="+dragPos));
							item.set("title",item.get("title").replace((dropPos.toInt()+1),(dragPos.toInt()+1)));
						}.bind(this));
						Array.each(dropAnchors, function(item){
							item.set("href",item.get("href").replace("position="+dragPos,"position="+dropPos));
							item.set("href",item.get("href").replace("positionTarget="+dragPos,"position="+dropPos));
							item.set("title",item.get("title").replace((dragPos.toInt()+1),(dropPos.toInt()+1)));
						}.bind(this));
						//topbar custom
						//get the topbar shortctus
							var topbarElements = document.id("topbar").getElements("li");
						//find the dragged
							var topDrag = topbarElements[dragPos];
						//find the dropped
							var topDrop = topbarElements[dropPos];
						//creat two placeholder for swapping in the right position
							var placeholderDrag = new Element("span");
							var placeholderDrop = new Element("span");
							placeholderDrag.inject(topDrag,"after");
							placeholderDrop.inject(topDrop,"after");
						//magic fade-out
						topDrag.fade("out");
						topDrop.fade("out");
						//wait 550 milliseconds then...
						(function(){
							//swap the things
								topDrag.inject(placeholderDrop,"after");
								topDrop.inject(placeholderDrag,"after");
							//magic fade-in
								topDrag.fade("in");
								topDrop.fade("in");
							//destroy placeholders
								placeholderDrag.destroy();
								placeholderDrop.destroy();
						}).delay(550);
					}
				});	
			}
			//shortcuts /end
			
			var myModalSource = $("shortcut-configure-container"); 
			////$("shortcut-configure-container").dispose();
			var myModalTitle = myModalSource.getElement("h2");
			var originalTitle = myModalTitle.get("text");
			myModalTitle.getElement("span.position-name").set("text","");
			
			myModalSource.getElement("h2").dispose();
			
			// Create instance
			var modalConfigure = new LightFace({
				title: originalTitle,
				content: myModalSource.get("html"),
				draggable: true,
				buttons: [{ title: '<s:text name="label.close" />', event: function() { this.close(); } }]
			});

			var updateTopBarShortcut = function(shortcutJSONwrapper) {
				if (shortcutJSONwrapper!=undefined) {
					var position = new Number(shortcutJSONwrapper.position).valueOf();
					var newShortcut = shortcutJSONwrapper.shortcut;
					//debugger;
					var shortcut = document.id("topbar").getElements("li")[position];
						shortcut.setProperty("class","");
						shortcut.addClass("topbar-menusection-"+newShortcut.menuSectionCode);

					var a = shortcut.getElement("a");
						a.set("href",newShortcut.href);
						a.set("title",newShortcut.longDescr);

					var img = a.getElement("img");
						var src = img.getProperty("src");
						src = src.replace(/topbar-[\w_\.\d]{0,}.png$/,"topbar-"+newShortcut.menuSectionCode+".png");
						img.setProperty("src",src);
						var alt = newShortcut.menuSection.description;

					var span = a.getElement("span");
						span.set("text",newShortcut.shortDescr);
				} 
			};
			
			var updateShortcut = function(form, involvedButton) {
				var mythis = shortcuts;
				var updateShortcutRequest = new Request.JSON({
					"url":  "<s:url namespace="/do/MyShortcut" action="configureMyShortcutAjax" />"+"?"+form.toQueryString(),
					"secure": true,
					"link": "ignore",
					"noCache": true,
					"method": "get",
					onRequest: function() {
						this.doLoad(involvedButton);
					}.bind(shortcuts),
					onComplete: function(res) {
						this.removeLoad(involvedButton);
					}.bind(shortcuts),
					onSuccess: function(response, responseText){
						if (response.result==true) {
							this.removeLoad(involvedButton);
							this.removeMessages();
							//debugger;
							this.updateShortcut(involvedButton,response.shortcut);
							updateTopBarShortcut(response);
							//console.log(response);
						}
						else {
							this.removeLoad(involvedButton);
							this.handleMessages(response.messages);
						}
					}.bind(shortcuts),
					onFailure: function(xhr) {
						this.removeLoad(involvedButton);
						this.handleMessages([this.options.labels.genericError]);
					}.bind(shortcuts),
					onException: function(headerName, value){
						this.removeLoad(involvedButton);
						this.handleMessages([this.options.labels.genericError]);
					}.bind(shortcuts),
					onTimeout: function(xhr) {
						this.removeLoad(involvedButton);
						this.handleMessages([this.options.labels.timeoutError]);
					}.bind(shortcuts)
				});
				
				updateShortcutRequest.get({});
				
				//shortcuts.updateShortcut(dl);
			};
			
			<%-- Just a test --%>
			//console.log($$('span.shortcut-toolbar a[rel="shortcut-configure"]'));
			var popupContainerSelector = '#shortcut-configure-container';
			var configureSelector = 'a[rel="shortcut-configure"]';
			document.getElements('dl').addEvent('click:relay('+configureSelector+')', function(ev) {
				ev.preventDefault();
				var target = ev.target;
				if (target.get("tag") != "a") {
					target = target.getParent(configureSelector); 
				}
				if (target!=null) {
					//debugger;
					var dl = target.getParent("dl");
					var href = target.get("href");
					var truncateAt = href.search(/position=[\d]{1,}/);
					var positionValue = new Number(href.substring(truncateAt+9).split("&")[0]).valueOf();
					var popup = modalConfigure.toElement();
					popup.getElement('input[name="position"]').set("value",positionValue);
					modalConfigure.load(false,originalTitle + (positionValue+1));
					//debugger;
					var form = popup.getElement("form");
					var submit = popup.getElement("form").getElement('input[type="submit"]');
					submit.removeEvents("click");
					submit.addEvent("click",function(ev){
						//debugger;
						ev.preventDefault();
						modalConfigure.close();
						updateShortcut(form,dl);
					});
					//Open Sesame!
					modalConfigure.open();
				}
			});
		
		});
		//<!]]>--></script>
	</s:if>
	<%-- shortcuts //end --%>
</s:if>