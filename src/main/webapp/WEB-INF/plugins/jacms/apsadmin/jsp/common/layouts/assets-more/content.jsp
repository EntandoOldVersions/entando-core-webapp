<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%-- tabs --%>
<script>
	jQuery(function(){
		<%--
		when the dom is ready we try to read the hash
		and recognize what is the tab to open.
		--%>
		if (document.location.hash.length > 0) {
			var tabContainer = $('#tab-container'); //tab conainer
			var tabTogglersContainer = $('#tab-togglers'); //toggler container
			//find the parent with class .tab-pane inside the tab container (and get its id)
			var tabId = $($(document.location.hash).parent('.tab-pane'), tabContainer).first().attr('id');
			if (tabId == undefined) {
				var tabId = $(document.location.hash+'.tab-pane', tabContainer).first().attr('id');
			}
			if (tabId!==undefined) {
				//find the element with [href][data-toggle] matching our hash
				var toggler = $('[href="#'+ tabId +'"][data-toggle="tab"]', tabTogglersContainer).first();
				if (toggler.length==1) {
					$(toggler).tab('show');
				}
			}
		}
		//enable the clickable togglers (as required by bootstrap)
		$('.tab-togglers a').click(function (e) {
			e.preventDefault()
			$(this).tab('show')
		});
	})
</script>
<%-- tabs //end --%>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />
<script src="<wp:resourceURL />administration/js/bootstrap-swapon.js"></script>
<s:if test="htmlEditorCode == 'fckeditor'">
	<script type="text/javascript" src="<wp:resourceURL />administration/js/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="<wp:resourceURL />administration/js/ckeditor/adapters/jquery.js"></script>
</s:if>
<script>
//one domready to rule 'em all
$(function() {
	var emtpyText= '<s:property value="%{getText('note.provide.description')}" escapeJavaScript="true" escapeHtml="false" escapeXml="false" />'

	$('[data-toggle="popover"]').popover();

	/* contentDescription routine //start */
	var fillText = $( '[data-swapon-role="text"]' , '#contentDescription-readonly' ).text();
	$( '#contentDescription-confirm' ).on('swapon', function(ev, action){
		if (action == 'hide') { //when description is filled, update the read only text...
			var contentDescriptionReadOnlyEl = $( '#contentDescription-readonly' );
			var newValue = $( '#contentDescription' ).val();
			$('#contentDescription').val(newValue);
			if (newValue.length<=0) { //if text is an empty string show the default text
				newValue = fillText;
				contentDescriptionReadOnlyEl.next( 'span' ).show();
			}
			else { //otherwise go ahead and hide the second message
				contentDescriptionReadOnlyEl.next( 'span' ).hide();
			}
			$('[data-swapon-role="text"]', '#contentDescription-readonly' ).text( newValue );
		}
	})

	$('#contentDescription-input').on('swapon', function(ev, action) {
		if (action == 'show') {
			var newValue = $.trim($( '#contentDescription-readonly' ).text());
			if (newValue==emtpyText) { newValue = ''; }
			$('#contentDescription').val();
			$('#contentDescription').focus();
		}
	})

	/* contentDescription routine //end */

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

//for content categories
<s:if test="#categoryTreeStyleVar == 'classic'">

	var catTree = jQuery("#categoryTree").EntandoWoodMenu({
		menuToggler: "subTreeToggler",
		menuRetriever: function(toggler) {
			return $(toggler).parent().children("ul");
		},
		openClass: "node_open",
		closedClass: "node_closed",
		showTools: true,
		onStart: function() {
			this.collapseAll();
		},
		expandAllLabel: "<s:text name="label.expandAll" />",
		collapseAllLabel: "<s:text name="label.collapseAll" />",
	<s:if test="%{categoryCode != null && !(categoryCode.equalsIgnoreCase(''))}">
		startIndex: "fagianonode_<s:property value="categoryCode" />",
	</s:if>
		toolTextIntro: "<s:text name="label.introExpandAll" />",
		toolexpandAllLabelTitle: "<s:text name="label.expandAllTitle" />",
		toolcollapseLabelTitle: "<s:text name="label.collapseAllTitle" />"
	});

</s:if>

<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-more/inc/js_trees_context_menu.jsp" />

//Hypertext Attribute
<s:if test="htmlEditorCode != 'none'">
	$('[data-toggle="entando-hypertext"]').ckeditor({
		customConfig : '<wp:resourceURL />administration/js/ckeditor/entando-ckeditor_config.js',
		EntandoLinkActionPath: "<s:url namespace="/do/jacms/Content/Hypertext" action="entandoInternalLink"><s:param name="contentOnSessionMarker" value="contentOnSessionMarker" /></s:url>",
		language: '<s:property value="locale" />'
	});
</s:if>
//End Hypertext Attribute
}); //End domready
</script>
<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-more/inc/snippet-datepicker.jsp" />
<%-- TEMPORARILY COMMENTED OUT EVERYTHING

<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />
<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/snippet-calendar.jsp" />


//per attributo Date
<s:iterator value="content.attributeList" id="attribute">
<%-- INIZIALIZZAZIONE TRACCIATORE --

<wpsa:tracerFactory var="attributeTracer" lang="%{#lang.code}" />

<s:if test="#attribute.type == 'Date'">
$(function() { myCal_<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" /> = new Calendar({ <s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />: 'd/m/Y' }, {
		navigation: 1,
		months: ['<s:text name="calendar.month.gen" />','<s:text name="calendar.month.feb" />','<s:text name="calendar.month.mar" />','<s:text name="calendar.month.apr" />','<s:text name="calendar.month.may" />','<s:text name="calendar.month.jun" />','<s:text name="calendar.month.jul" />','<s:text name="calendar.month.aug" />','<s:text name="calendar.month.sep" />','<s:text name="calendar.month.oct" />','<s:text name="calendar.month.nov" />','<s:text name="calendar.month.dec" />'],
		days: ['<s:text name="calendar.week.sun" />','<s:text name="calendar.week.mon" />','<s:text name="calendar.week.tue" />','<s:text name="calendar.week.wen" />','<s:text name="calendar.week.thu" />','<s:text name="calendar.week.fri" />','<s:text name="calendar.week.sat" />'],
		calendarTitle: "<s:text name="calendar.button.title" />",
		//prevTitle: '',
		//nextTitle: '',
		prevText: "<s:text name="calendar.label.prevText" />",	//Mese precedente
		nextText: "<s:text name="calendar.label.nextText" />",	//Mese successivo
		introText: "<s:text name="calendar.label.introText" />"	//Benvenuto nel calendario
	});});
</s:if>

<s:elseif test="#attribute.type == 'Monolist'">
<s:set name="masterAttributeTracer" value="#attributeTracer" />
<s:set name="masterAttribute" value="#attribute" />
<s:iterator value="#attribute.attributes" id="attribute" status="elementStatus">
<s:set name="attributeTracer" value="#masterAttributeTracer.getMonoListElementTracer(#elementStatus.index)"></s:set>
<s:set name="elementIndex" value="#elementStatus.index" />

	<s:if test="#attribute.type == 'Composite'">
	<s:set name="masterCompositeAttributeTracer" value="#attributeTracer" />
	<s:set name="masterCompositeAttribute" value="#attribute" />
	<s:iterator value="#attribute.attributes" id="attribute">
		<s:set name="attributeTracer" value="#masterCompositeAttributeTracer.getCompositeTracer(#masterCompositeAttribute)"></s:set>
		<s:set name="parentAttribute" value="#masterCompositeAttribute"></s:set>

		<s:if test="#attribute.type == 'Date'">
		$(function() { myCal_<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" /> = new Calendar({ <s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />: 'd/m/Y' }, {
				navigation: 1,
				months: ['<s:text name="calendar.month.gen" />','<s:text name="calendar.month.feb" />','<s:text name="calendar.month.mar" />','<s:text name="calendar.month.apr" />','<s:text name="calendar.month.may" />','<s:text name="calendar.month.jun" />','<s:text name="calendar.month.jul" />','<s:text name="calendar.month.aug" />','<s:text name="calendar.month.sep" />','<s:text name="calendar.month.oct" />','<s:text name="calendar.month.nov" />','<s:text name="calendar.month.dec" />'],
		days: ['<s:text name="calendar.week.sun" />','<s:text name="calendar.week.mon" />','<s:text name="calendar.week.tue" />','<s:text name="calendar.week.wen" />','<s:text name="calendar.week.thu" />','<s:text name="calendar.week.fri" />','<s:text name="calendar.week.sat" />'],
				calendarTitle: '<s:text name="calendar.button.title" />',
				//prevTitle: '',
				//nextTitle: '',
				prevText: "<s:text name="calendar.label.prevText" />",	//Mese precedente
				nextText: "<s:text name="calendar.label.nextText" />",	//Mese successivo
				introText: "<s:text name="calendar.label.introText" />"	//Benvenuto nel calendario
			});});
		</s:if>

	</s:iterator>
	<s:set name="attributeTracer" value="#masterCompositeAttributeTracer" />
	<s:set name="attribute" value="#masterCompositeAttribute" />
	<s:set name="parentAttribute" value=""></s:set>
	</s:if>

	<s:elseif test="#attribute.type == 'Date'">
$(function() { myCal_<s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" /> = new Calendar({ <s:property value="%{#attributeTracer.getFormFieldName(#attribute)}" />: 'd/m/Y' }, {
		navigation: 1,
		months: ['<s:text name="calendar.month.gen" />','<s:text name="calendar.month.feb" />','<s:text name="calendar.month.mar" />','<s:text name="calendar.month.apr" />','<s:text name="calendar.month.may" />','<s:text name="calendar.month.jun" />','<s:text name="calendar.month.jul" />','<s:text name="calendar.month.aug" />','<s:text name="calendar.month.sep" />','<s:text name="calendar.month.oct" />','<s:text name="calendar.month.nov" />','<s:text name="calendar.month.dec" />'],
		days: ['<s:text name="calendar.week.sun" />','<s:text name="calendar.week.mon" />','<s:text name="calendar.week.tue" />','<s:text name="calendar.week.wen" />','<s:text name="calendar.week.thu" />','<s:text name="calendar.week.fri" />','<s:text name="calendar.week.sat" />'],
		calendarTitle: '<s:text name="calendar.button.title" />',
		//prevTitle: '',
		//nextTitle: '',
		prevText: "<s:text name="calendar.label.prevText" />",	//Mese precedente
		nextText: "<s:text name="calendar.label.nextText" />",	//Mese successivo
		introText: "<s:text name="calendar.label.introText" />"	//Benvenuto nel calendario
	});});
	</s:elseif>

</s:iterator>
<s:set name="attributeTracer" value="#masterAttributeTracer" />
<s:set name="attribute" value="#masterAttribute" />
</s:elseif>

</s:iterator>
//fine attributo Date



<s:if test="#myClient == 'advanced'">
window.addEvent('domready', function(){
	var myTips = new Tips('.attribute-meta-tip', {
		className: 'tip-container',
		offset: {'x': 22, 'y': -8},
		fixed: true
	});

	$$('.attribute-meta-tip').each(function(el) {
		var myTitle = '<s:text name="label.info" />'
		var myTipText = "<ul>";
		//myTipText = el.innerHTML;
		el.getElements("abbr").each(function(abbr) {
			myTipText = myTipText + "<li>";
			myTipText = myTipText + abbr.get("title");
			if ( abbr.getNext(".attribute-meta-tip-info").get('text') != "") {
				myTipText = myTipText + ": " + abbr.getNext(".attribute-meta-tip-info").get('text');
			}
			myTipText = myTipText + "</li>";
		});

		myTipText = myTipText + "</ul>"

		el.innerHTML = "?";

		el.store('tip:title', myTitle);
		el.store('tip:text', myTipText);

		el.addClass('tip-handler');
	});

	/* text-overflow for attributes name's labels more than 10 chars */
	var mainLabels = document.getElements('.attribute-main-label');
	mainLabels.ellipsis();
	$each(mainLabels, function(label) {
		label.set('title', label.get('html'));
	});

});
</s:if>

//--><!]]></script>
--%>

<wpsa:hookPoint key="jacms.entryContent.extraResources" objectName="hookPointElements_jacms_entryContent_extraResources">
	<s:iterator value="#hookPointElements_jacms_entryContent_extraResources" var="hookPointElement">
		<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
	</s:iterator>
</wpsa:hookPoint>
