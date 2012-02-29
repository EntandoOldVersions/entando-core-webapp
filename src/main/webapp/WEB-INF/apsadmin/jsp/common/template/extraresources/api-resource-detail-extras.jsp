<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<s:include value="/WEB-INF/apsadmin/jsp/common/template/defaultExtraResources.jsp" />
<script type="text/javascript">
<!--//--><![CDATA[//><!--
//for tabs
window.addEvent('domready', function(){
	 var tabSet = new Taboo({
			tabs: "tab",
			tabTogglers: "tab-toggle",
			activeTabClass: "tab-current"
		});
});
//--><!]]>
</script>
<style>
	.schema-get {
		margin-top: 0;
		margin-bottom: 0.5em;
	}
	.schema-post {
		margin: 0;
	}
	<s:if test="#myClient == 'normal'">
		.schema-get, .schema-post {
			font-size: 1em;
		}
	</s:if>
</style>
