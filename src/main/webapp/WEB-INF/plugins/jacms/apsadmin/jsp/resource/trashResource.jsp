<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>
<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
<s:set var="targetParamValue" value="resourceTypeCode" />

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/Resource">
		<s:param name="resourceTypeCode">
			<s:property value="resourceTypeCode" />
		</s:param>
		</s:url>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.resourceManagement" />"> <s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />
		</a>
		&#32;/&#32;
		<s:text name="title.resourceManagement.resourceTrash" />
	</span>
</h1>

<s:form action="delete">
	<p class="sr-only">
		<s:hidden name="resourceId" />
		<s:hidden name="text" value="%{#parameters['text']}" />
		<s:hidden name="categoryCode" value="%{#parameters['categoryCode']}" />
		<s:hidden name="resourceTypeCode" />
		<s:hidden name="fileName" value="%{#parameters['fileName']}" />
		<s:hidden name="ownerGroupName" value="%{#parameters['ownerGroupName']}" />
		<s:if test="#categoryTreeStyleVar == 'request'">
			<s:iterator value="%{#parameters['treeNodesToOpen']}" var="treeNodeToOpenVar"><s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/></s:iterator>
		</s:if>
	</p>

	<div class="alert alert-warning">
		<p>
			<s:text name="note.deleteResource.areYouSure" />:&#32;
			<code><s:property value="%{loadResource(resourceId).descr}" /></code>?
		</p>
		<div class="text-center margin-large-top">
			<s:submit type="button" cssClass="btn btn-warning btn-lg">
				<span class="icon icon-remove-sign"></span>&#32;
				<s:text name="label.remove" />
			</s:submit>
			<a class="btn btn-link" href="<s:url action="list" namespace="/do/jacms/Resource"><s:param name="resourceTypeCode"><s:property value="resourceTypeCode" /></s:param></s:url>"><s:text name="note.goToSomewhere" />: <s:text name="title.resourceManagement" /></a>
		</div>
	</div>
</s:form>