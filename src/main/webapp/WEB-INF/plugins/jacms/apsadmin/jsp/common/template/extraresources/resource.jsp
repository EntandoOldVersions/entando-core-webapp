<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<script type="text/javascript">
<!--//--><![CDATA[//><!--
//per categorie
window.addEvent('domready', function(){
<s:if test="#categoryTreeStyleVar == 'classic'">
	var catTree  = new Wood({
		menuToggler: "subTreeToggler",
		rootId: "categoryTree",
		openClass: "node_open",
		closedClass: "node_closed",
		showTools: "true",
		expandAllLabel: "<s:text name="label.expandAll" />",
		collapseAllLabel: "<s:text name="label.collapseAll" />",
		type: "tree",
		<s:if test="%{categoryCode != null && !(categoryCode.equalsIgnoreCase(''))}">
		startIndex: "fagianonode_<s:property value="categoryCode" />",
		</s:if>
		toolTextIntro: "<s:text name="label.introExpandAll" />",
		toolexpandAllLabelTitle: "<s:text name="label.expandAllTitle" />",
		toolcollapseLabelTitle: "<s:text name="label.collapseAllTitle" />"
	});
</s:if>

<s:if test="#myClient == 'advanced'">
	<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/js_trees_context_menu.jsp" />
</s:if>

});
<s:if test='#myClient== "advanced" && !onEditContent'>
	window.addEvent("domready", function(){
		var imageInfos = document.getElements("dl.gallery dd.imageInfo");
		if (imageInfos.length>0) {
			Array.each(imageInfos, function(item){
				var parent = item.getParent("dl.gallery");
				var toggler = parent.getElement("a.imageInfoToggler");
				//item.setStyle("display", "none");
				toggler.addEvent("click", function(ev){ev.preventDefault();});
				var slider = new SlideCrab(item,toggler, {
					fxStartValues: {
						"opacity": 0
					}
				});
				item.getElement(".slidecrab-closer").addEvent("click", function(ev){
					ev.preventDefault();
					slider.close();
				});
			});
		}
	});
</s:if>

//--><!]]></script>