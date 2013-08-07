<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:include value="/WEB-INF/apsadmin/jsp/common/layouts/assets-common.jsp" />

<s:if test="#myClient == 'advanced'">
<script type="text/javascript"><!--
//--><![CDATA[//>
window.addEvent('domready', function(){
	<s:include value="/WEB-INF/apsadmin/jsp/common/template/extraresources/inc/js_trees_context_menu.jsp" />
});
//<!]]>-->--</script>
</s:if>