<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<s:set var="myClient"><wpsa:backendGuiClient /></s:set>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="it">
<head>
<title>EntandoLink</title>
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/menu.css" media="screen" />	
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/layout-general.css" media="screen" />

	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/menu-ie7.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/layout-general-ie7.css" media="screen" />
	<![endif]-->	

<s:if test="#myClient == 'normal'">
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/menu.css" media="screen" />	
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/layout-general.css" media="screen" />
</s:if>

<s:if test="#myClient == 'advanced'">
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/menu.css" media="screen" />	
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/layout-general.css" media="screen" />
	
	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/menu-ie7.css" media="screen" />		
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/layout-general-ie7.css" media="screen" />
	<![endif]-->
	
	<!--[if IE 8]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/administration-ie8.css" media="screen" />		
	<![endif]-->

	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/js/fckeditor/editor/plugins/japslink/fck_japslink.css" media="screen"  />

</s:if>

	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/fckeditor/editor/dialog/common/fck_dialog_common.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/mootools-core-1.3-full-compat-yc.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/mootools-more-1.3-full-compat-yc.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/common/js/moo-japs/moo-jAPS-0.2.js"></script>



<script type="text/javascript">
<!--//--><![CDATA[//><!--
                  
//per tab
<s:set var="active"><%= request.getParameter("activeTab")%></s:set>
//|<c:out value="${param.activeTab}" />|
<s:if test="%{#active == 'null' || #active == ''}"><s:set var="active">0</s:set></s:if>
window.addEvent('domready', function(){
	 var tabSet = new Taboo({
			tabs: "tab",
	 		<s:if test="#request.parameters.activeTab != null">startTabIndex: <s:property value="#request.parameters.activeTab"/>,</s:if>
			tabTogglers: "tab-toggle",
			anchorTab: null,
			activeTabClass: "tab-current"
		});
});

<s:set var="pageTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_page" /></s:set>

<s:if test="#pageTreeStyleVar == 'classic'">
window.addEvent('domready', function(){
	var pageTree = new Wood({
		rootId: "pageTree",
		menuToggler: "subTreeToggler",
		openClass: "node_open",
		closedClass: "node_closed",
		showTools: "true",
		expandAllLabel: "<s:text name="label.expandAll"/>",
		collapseAllLabel: "<s:text name="label.collapseAll"/>",
		type: "tree",
		<s:if test="%{selectedNode != null && !(selectedNode.equalsIgnoreCase(''))}">
		startIndex: "fagianonode_<s:property value="selectedNode" />",
		</s:if>
		toolTextIntro: "<s:text name="label.introExpandAll" />",
		toolexpandAllLabelTitle: "<s:text name="label.expandAllTitle" />",
		toolcollapseLabelTitle: "<s:text name="label.collapseAllTitle" />"		
	});
});
</s:if>

window.addEvent('domready', function(){
	if ( !eSelected )
		return ;

	if ( eSelected.tagName == 'SPAN' && eSelected._fckjapslink )
		txtName.value = eSelected._fckjapslink ;
	else
		eSelected == null ;
});

var FCK = window.opener.FCK;
var eSelected = FCK.Selection.GetSelectedElement();

//Eventi per bottoni
window.addEvent('domready', function(){

	//$('linkForm').getElements('input[name^=button]').removeEvents();

	//External URL
	$('form_externalURL').addEvent('submit', function(){
		if ( $('txtName').value.length == 0 ) {
			alert( '<s:text name="note.typeValidURL" />' ) ;
			return false ;
		}
		oLink = FCK.CreateLink( "#!U;" + $('txtName').value + "!#" );
		if (oLink) {
			window.close();
		}
	});	

	//Page Link
	$('form_pageLink').addEvent('submit', function(){
	    var pageCode = null;
    	var pageCodes = $('pageTree').getElements('input[name=selectedNode]');
    	pageCodes.each(function(item, index){
	    	if ( item.getProperty("checked") ) {
		    	pageCode = item.getProperty("value");
	    	} 
    	});

		if ( null == pageCode ) {
			alert( '<s:text name="note.choosePageToLink" />');
			return false ;
		}
		oLink = FCK.CreateLink( "#!P;" + pageCode + "!#" );
		if (oLink) {
			window.close();
		}
	});	

	//Content Link
	$('button_contentLink').addEvents({
	    'click': function(){
	    	contentCode = null;
	    	contentCodes = $('contentListTable').getElements('input[name=contentId]').getProperty("value");
	    	contentCodes.each(function(item, index){
		    	if ( $('contentId_' + item).getProperty("checked") ) {
			    	contentCode = $('contentId_' + item).getProperty("value");
		    	} 
	    	});

			if ( null == contentCode ) {
				alert( '<s:text name="note.chooseContentToLink" />');
				return false ;
			}

			oLink = FCK.CreateLink( "#!C;" + contentCode + "!#" );
			if (oLink) {
				window.close();
			}
	    },
	    //FIXME: se ne va per la tangente col keypress del URL esterno per via del tabindex. Fixare :(
	    'keypress': function(){
	    	contentCodes = $('contentListTable').getElements('input[name=contentId]').getProperty("value");
	    	contentCodes.each(function(item, index){
		    	if ( $('contentId_' + item).getProperty("checked") ) {
			    	contentCode = $('contentId_' + item).getProperty("value");
		    	} 
	    	});

			if ( contentCode.length == 0 ) {
				alert( '<s:text name="note.chooseContentToLink" />');
				return false ;
			}

			oLink = FCK.CreateLink( "#!C;" + contentCode + "!#" );
			if (oLink) {
				window.close();
			}
	    }
	});	

});

//per gli accordion
window.addEvent('domready', function(){
	var myAccordion = new Accordion($$('.accordion_toggler'), $$('.accordion_element'), {
	    show: -1,
	    duration: 'short',
	    alwaysHide: true
	});

	var myAnchor = new Element('img', {
	    'src': '<wp:resourceURL/>administration/img/icons/media-eject.png',
	    'class': 'myClass',
	    'style': 'vertical-align: middle',
	    'alt': '<s:text name="label.open" /> ',
	    'title': '<s:text name="label.open" /> '	    
	});

	$$('.accordion_toggler').each(function(cToggler) {
		cToggler.appendText(' ');
		var poba = myAnchor.clone();
		poba.injectBottom(cToggler);
	});
	
});	
	
/*
var variable = null;
var FCK = window.opener.FCK;
function ok() {
if(variable != null) {
FCK.Focus();
var B = FCK.EditorDocument.selection.createRange(); //only works in IE
B.text = variable;
}
window.close();
}
*/

//--><!]]></script>

</head>
<body class="client-<s:property value="#myClient" />">
<div id="corpo">
<h1><s:text name="title.contentManagement" /></h1>
<h2><s:text name="title.contentEditing" /></h2>
<h3><s:text name="note.chooseLinkType" /></h3>
<ul class="menu horizontal tab-toggle-bar">
	<li><a href="#divURLLink" class="tab-toggle"><s:text name="note.URLLinkTo" /></a></li>
	<li><a href="#divPageLink" class="tab-toggle"><s:text name="note.pageLinkTo" /></a></li>
	<li><a href="#divContentLink" class="tab-toggle"><s:text name="note.contentLinkTo" /></a></li>
</ul>

<div id="linkForm" class="tab-container">
<!-- URL Link -->
<form id="form_externalURL">
<div id="divURLLink" class="tab">
<h3 class="noscreen"><s:text name="note.URLLinkTo" /></h3>
<p>
	<label for="txtName"><s:text name="note.typeValidURL" />:</label><br />
	<wpsf:textfield useTabindexAutoIncrement="true" id="txtName" name="txtName" maxlength="255" cssClass="text" />
</p>

<p><input id="button_externalURL" name="button_externalURL" type="submit" value="<s:text name="label.confirm" />" class="button" /></p>
</div>
</form>
<!-- //URL Link -->

<!-- //Page Link -->
<s:action name="introPageLink" executeResult="true" ></s:action>

<!-- Content Link -->
<s:if test="#request.activeTab == 2 && null != #request.internalActionName"><s:set var="introContentLinkActionName" value="#request.internalActionName" ></s:set></s:if>
<s:else><s:set var="introContentLinkActionName" value="'introContentLink'" ></s:set></s:else>
<s:action name="%{#introContentLinkActionName}" executeResult="true"></s:action>

</div>

</div>
</body>
</html>