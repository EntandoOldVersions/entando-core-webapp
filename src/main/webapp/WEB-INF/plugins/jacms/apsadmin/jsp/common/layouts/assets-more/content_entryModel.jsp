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
<%--
	<script src="<wp:resourceURL />administration/mint/js/codemirror/codemirror-compressed.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/codemirror.css">
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/codemirror/overlay.js"></script>
	<script src="<wp:resourceURL />administration/mint/js/codemirror/mode/xml/xml.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/mode/xml/xml-eclipse.css">
	<script src="<wp:resourceURL />administration/mint/js/codemirror/mode/velocity/velocity-overlay-mode.js"></script>
	<link rel="stylesheet" href="<wp:resourceURL />administration/mint/js/codemirror/mode/velocity/velocity.css"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/mint/js/contentModels-editor.js"></script>
--%>
<link rel="stylesheet" href="<wp:resourceURL />administration/js/codemirror/lib/codemirror.css" />
<link rel="stylesheet" href="<wp:resourceURL />administration/js/codemirror/theme/neat.css" />
<script type="text/javascript" src="<wp:resourceURL />administration/js/codemirror/lib/codemirror.js"></script>
<script type="text/javascript" src="<wp:resourceURL />administration/js/codemirror/mode/velocity/velocity.js"></script>
<script type="text/javascript">
	jQuery(function(){
		var divContainer = $('<div class="panel panel-default"></div>');
		var textarea = $('#contentShape');
		divContainer.insertBefore(textarea);
		divContainer.css('width', (textarea.width()+30)+"px");
		divContainer.css('max-width', (textarea.width()+30)+"px");

		textarea.css('width', (textarea.width()+30)+"px");
		textarea.css('max-width', (textarea.width()+30)+"px");
		textarea.appendTo(divContainer);

		CodeMirror.fromTextArea(document.getElementById('contentShape'), {
			value: document.getElementById('contentShape').value,
			lineNumbers: false,
			gutter: false,
			tabMode: "indent",
			indentUnit: 1,
			mode: "velocity"
		});
	});
</script>
	<script type="text/javascript">
	/*
	window.addEvent("domready", function(){
		new CodeMirrorManager(document.id("newModel_contentShape"), {vocabulary : ENTANDO_MODEL_VOCABULARY});
	});*/
</script>