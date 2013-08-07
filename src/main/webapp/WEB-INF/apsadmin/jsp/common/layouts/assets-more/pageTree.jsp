<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />

<script type="text/javascript"><!--
//--><![CDATA[//>
window.addEvent('domready', function(){
<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/snippet-pageTree.jsp" />

<s:if test="#myClient == 'advanced'">
	<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/js_trees_context_menu.jsp" />
</s:if>

});
//<!]]>-->--</script>