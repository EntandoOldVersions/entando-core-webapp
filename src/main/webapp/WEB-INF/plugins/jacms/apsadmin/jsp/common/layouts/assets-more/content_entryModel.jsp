<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />
<script type="text/javascript">
	var ENTANDO_MODEL_VOCABULARY = {
		<jsp:include page="inc/attributeType-json-Model.jsp" />,
		"#foreach ($item in $<LIST>) $item #end": null,
		"#if (<TRUE>) <DO> #else <DOANOTHER> #end": null, 
		"#if (<TRUE>) <DO> #end": null,
		"#set ($<VAR> = <VALUE>)": null
	};
</script>
<s:if test="#myClient == 'normal'">
<%-- normal start --%>
	<link type="text/css" rel="stylesheet" href="<wp:resourceURL />administration/common/css/MooContentAssist_themes.css" />
	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/mootools-xml.js">--</script> 
	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/MooContentAssist.js"></script>
	<script type="text/javascript">
	<!--//--><![CDATA[//><!--
	/************ client script ************/
	window.addEvent("domready",function(){ 
		var editorAssisted = new MooContentAssist( {
			frameSize : 3,
			vocabularyDiscoverer: false,
			windowPadding: {
				"x": 0,
				"y": 2
			},
			aggressiveAssist : false,
			source : document.id("newModel_contentShape"),
			css : {
				item: "item", 
				itemsContainer: "itemsContainer_theme_japs",
				itemSelected: "itemSelected",
				messageItem: "messageItem",
				matchedText: "matchedText"
			},
			vocabulary : ENTANDO_MODEL_VOCABULARY
		});
	});
	//--><!]]></script>
<%-- normal end --%>
</s:if>
<s:if test="#myClient == 'advanced'">
<%-- advanced start --%>
	<%-- detail function --%>
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Assets/LightFace.css" media="screen" />
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Source/LightFace.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/darkwing-LightFace-89eadac/Source/LightFace.Static.js"></script>

	
	<script src="<wp:resourceURL />administration/mint/js/codemirror/codemirror-compressed.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/codemirror.css">
	
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/codemirror/overlay.js"></script>
	
	<script src="<wp:resourceURL />administration/mint/js/codemirror/mode/xml/xml.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/mode/xml/xml-eclipse.css">
	
	<script src="<wp:resourceURL />administration/mint/js/codemirror/mode/velocity/velocity-overlay-mode.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/mode/velocity/velocity.css"></script>
	
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/downloadify/js/swfobject.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/downloadify/js/downloadify.min.js"></script>
	<script type="text/javascript">
	var myModalLightFace = null;
window.addEvent('domready', function() {
//domready
	var downloadTitleString = "<s:text name="label.download" />";
	var closeTitleString = "<s:text name="label.close" />";
	
	var details_shortcut = document.id("jacms-content-model-detail-shortcut");

	var getPopUpTitle = function() {
		var titleString = "";
		var contentType = document.id("newModel_contentType");
		var id = document.id("newModel_id");
		var description = document.id('newModel_description');
		var titleString = "";
		if (contentType!==null && id!==null && description!==null) {
			id = id.get("value"); 
			description = description.get("value");
			contentType = contentType.get("value")
			document.getElements("options").each(function(item) {
				if (item.get("value") == contentType) { contentType = item.get("text"); };
			});
			titleString = "<s:text name="contentModel.label.shape" /> " +id+ " " +contentType+ " " +description;
		}
		return titleString;
	};
	
	var getVMfilename = function(){
		titleString = "contentmodel.vm";
		var contentType = document.id("newModel_contentType");
		var id = document.id("newModel_id");
		var description = document.id('newModel_description');
		var titleString = "";
		if (contentType!==null && id!==null && description!==null) {
			id = id.get("value"); 
			description = description.get("value");
			contentType = contentType.get("value")
			titleString = contentType+"-"+description+"-"+id+".vm";
			titleString = titleString.replace(/\s{1,}/g,"-").replace(/-{1,}/g,"-");
		}
		return titleString;
	};

	myModalLightFace = new LightFace({
		title: getPopUpTitle(),
		content: "",
		draggable: true,
		buttons: [
			{ title: downloadTitleString },
			{
				title: closeTitleString, 
				event: function() { 
					this.close(); 
				} 
			}
		]
	});

	//var heightButton = 22;
	var heightButton = myModalLightFace.buttons[closeTitleString].getDimensions().y;
	var widthButton = 36;
	var downloadButton = myModalLightFace.buttons[downloadTitleString].getParent();
	downloadButton.set("title",downloadTitleString);
	downloadButton.setStyles({
		width: widthButton+"px",
		height: heightButton+"px",
		"background-image": 'url("<wp:resourceURL />administration/common/img/icons/go-down.png")',
		"background-repeat": 'no-repeat',
		"background-position": 'center center'
	});

	downloadButton.downloadify({
		filename: getVMfilename,
		data: function(){ 
		  return document.id("newModel_contentShape").get("value");
		},
		transparent: true,
		swf: '<wp:resourceURL />administration/mint/js/downloadify/media/downloadify.swf',
		downloadImage: '<wp:resourceURL />administration/mint/img/downloadify-download-sprite.png',
		width: widthButton,
		height: heightButton,
		append: false
	});

	downloadButton.getElements("object").set("title",downloadTitleString);
	downloadButton.getElements("object").setStyles({
		"cursor": "pointer",
		"margin": 0,
		"padding": 0
	});
	var myCodeMirrorElement = new Element("div").inject(myModalLightFace.contentBox.getElement(".lightfaceMessageBox"));
	var myCodeMirrorOptions = {
		mode: "velocity",
		value: document.id("newModel_contentShape").get("value"),
		readOnly: true,
		lineNumbers: true,
		gutter: true
	};
	
	var myCodeMirror = CodeMirror(myCodeMirrorElement,myCodeMirrorOptions);
	details_shortcut.addEvent("click", function(ev){
		ev.preventDefault();
		myCodeMirror.setValue(document.id("newModel_contentShape").get("value"));
		myModalLightFace.open();
	});
//domready
});
	</script>
	<script type="text/javascript">
		var contentModelsEditorActive = true;
	</script>
	<!--[if IE]>
		<script type="text/javascript">
			contentModelsEditorActive = false;
		</script>
		<link type="text/css" rel="stylesheet" href="<wp:resourceURL />administration/common/css/MooContentAssist_themes.css" />
		<script type="text/javascript" src="<wp:resourceURL />administration/common/js/mootools-xml.js"></script> 
		<script type="text/javascript" src="<wp:resourceURL />administration/common/js/MooContentAssist.js"></script>
		<script type="text/javascript">
		/************ client script ************/
		window.addEvent("domready",function(){ 
			var editorAssisted = new MooContentAssist( {
				frameSize : 3,
				vocabularyDiscoverer: false,
				windowPadding: {
					"x": 0,
					"y": 2
				},
				aggressiveAssist : false,
				source : document.id("newModel_contentShape"),
				css : {
					item: "item", 
					itemsContainer: "itemsContainer_theme_japs",
					itemSelected: "itemSelected",
					messageItem: "messageItem",
					matchedText: "matchedText"
				},
				vocabulary : ENTANDO_MODEL_VOCABULARY
			});
		});
		</script>
	<![endif]-->
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/contentModels-editor.js"></script>
	<script type="text/javascript">
		window.addEvent("domready", function(){
			new CodeMirrorManager(document.id("newModel_contentShape"), {vocabulary : ENTANDO_MODEL_VOCABULARY});
		});
	</script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/css/content-model-editor.css" />
<%-- advanced end --%>
</s:if>