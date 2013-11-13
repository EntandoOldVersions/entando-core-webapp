<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<s:form>
<p class="sr-only">
	<wpsf:hidden name="selectedNode" />
</p>

<wpsa:hookPoint key="core.categoryReferences" objectName="hookPointElements_core_categoryReferences">
<s:iterator value="#hookPointElements_core_categoryReferences" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>
</s:form>