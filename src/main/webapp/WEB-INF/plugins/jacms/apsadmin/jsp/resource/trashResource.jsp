<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
<s:set var="targetParamValue" value="resourceTypeCode" />
<h1><s:property value="%{getText('title.resourceManagement.' + resourceTypeCode)}" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">
<h2><s:text name="title.resourceManagement.resourceTrash" /></h2>

<s:form action="delete">
	<p class="sr-only">
		<wpsf:hidden name="resourceId" />
		<wpsf:hidden name="text" value="%{#parameters['text']}" />
		<wpsf:hidden name="categoryCode" value="%{#parameters['categoryCode']}" />
		<wpsf:hidden name="resourceTypeCode" />
		<wpsf:hidden name="fileName" value="%{#parameters['fileName']}" />
		<wpsf:hidden name="ownerGroupName" value="%{#parameters['ownerGroupName']}" />
	<s:if test="#categoryTreeStyleVar == 'request'">
		<s:iterator value="%{#parameters['treeNodesToOpen']}" var="treeNodeToOpenVar"><wpsf:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"></wpsf:hidden></s:iterator>
	</s:if>
	</p>
	<p>
		<s:text name="note.deleteResource.areYouSure" />:&#32;<em class="important"><s:property value="%{loadResource(resourceId).descr}" /></em>&#32;?
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>
	<p><s:text name="note.deleteResource.areYouSure.goBack" />&#32;<a href="<s:url action="list" namespace="/do/jacms/Resource"><s:param name="resourceTypeCode"><s:property value="resourceTypeCode" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.resourceManagement" />"><s:text name="title.resourceManagement" /></a></p>
</s:form>

</div>