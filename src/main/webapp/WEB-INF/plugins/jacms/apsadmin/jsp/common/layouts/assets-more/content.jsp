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

<wpsa:hookPoint key="jacms.entryContent.extraResources" objectName="hookPointElements_jacms_entryContent_extraResources">
	<s:iterator value="#hookPointElements_jacms_entryContent_extraResources" var="hookPointElement">
		<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
	</s:iterator>
</wpsa:hookPoint>
