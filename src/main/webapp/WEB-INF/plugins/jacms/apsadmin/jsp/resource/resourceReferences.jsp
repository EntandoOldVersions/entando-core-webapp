<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>

<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
<s:set var="targetParamValue" value="resourceTypeCode" />	
<h1 class="panel panel-default title-page"><span class="panel-body display-block">
<s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />&#32;/&#32;
<s:text name="title.resourceManagement.resourceTrash" />
<s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></span></h1>

<div id="main">

<div class="message message_error">
<h2><s:text name="message.title.ActionErrors" /></h2>
<p><s:text name="message.note.resolveReferences" />:</p>

</div>

<s:form>
<p class="sr-only">
	<wpsf:hidden name="resourceId" />
</p>

<s:if test="references['jacmsContentManagerUtilizers']">
<s:set var="referencingContentsId" value="references['jacmsContentManagerUtilizers']" />
<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/portal/include/referencingContents.jsp" />
</s:if>

<wpsa:hookPoint key="jacms.resourceReferences" objectName="hookPointElements_jacms_resourceReferences">
<s:iterator value="#hookPointElements_jacms_resourceReferences" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

</s:form>

</div>