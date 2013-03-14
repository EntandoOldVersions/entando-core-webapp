<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:if test="onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
	<h1><s:text name="jacms.menu.contentAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
	
	<div id="main">
	
	<h2 class="margin-more-bottom"><s:text name="title.contentEditing" /></h2>
	
	<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />
	<!--
	 	<s:if test="content.id == null"> NUOVO </s:if>
		<s:else> CON ID '<s:property value="content.id" />' </s:else>
	 -->
	<h3 class="margin-bit-bottom"><s:text name="title.resourceManagement" />: <s:text name="title.resourceManagement.resourceNew" /></h3> 	
</s:if>

<s:if test="!onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
	<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
	<s:set var="targetParamValue" value="resourceTypeCode" />	
	<h1><s:property value="%{getText('title.resourceManagement.' + resourceTypeCode)}" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

	<div id="main">
	<h2 class="margin-more-bottom">
		<s:if test="getStrutsAction() == 1"><s:text name="title.resourceManagement.resourceNew" /></s:if>
		<s:else><s:text name="title.resourceManagement.resourceEdit" /></s:else>
		<%-- 
		<s:text name="resourceType.%{resourceTypeCode}"></s:text>
		--%>
	</h2>
</s:if>

<s:form action="save" method="post" enctype="multipart/form-data" cssClass="action-form">

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<s:if test="hasFieldErrors()">
<div class="message message_error">
<h3><s:text name="message.title.FieldErrors" /></h3>
<ul>
<s:iterator value="fieldErrors">
	<s:iterator value="value">
	<li><s:property escape="false" /></li>
	</s:iterator>
</s:iterator>
</ul>
</div>
</s:if>
<p class="noscreen">
	<wpsf:hidden name="strutsAction" />
	<wpsf:hidden name="resourceTypeCode" />
<s:iterator value="categoryCodes" id="categoryCode" status="rowstatus">
<input type="hidden" name="categoryCodes" value="<s:property value="#categoryCode" />" id="categoryCodes-<s:property value="#rowstatus.index" />"/>
</s:iterator>
<s:if test="strutsAction != 1">
	<wpsf:hidden name="resourceId" />
</s:if>
<s:if test="#categoryTreeStyleVar == 'request'">
	<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><wpsf:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"></wpsf:hidden></s:iterator>
</s:if>
</p>

<fieldset><legend><s:text name="label.info" /></legend>
<p>
	<label for="descr" class="basic-mint-label"><s:text name="label.description" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" name="descr" id="descr" cssClass="text" />
</p>

<s:set name="lockGroupSelect" value="%{resourceId != null && resourceId != 0}"></s:set>
<p>
	<label for="mainGroup" class="basic-mint-label"><s:text name="label.group" />:</label>
	<wpsf:select useTabindexAutoIncrement="true" name="mainGroup" id="mainGroup" list="allowedGroups" value="mainGroup" 
		listKey="name" listValue="descr" disabled="%{lockGroupSelect}" cssClass="text" />
</p>

<s:if test="%{lockGroupSelect}">
<p class="noscreen">
	<wpsf:hidden name="mainGroup" />
</p>
</s:if>

<s:if test="strutsAction == 2">
<div class="subsection-light">
<s:set var="referencingContentsId" value="references['jacmsContentManagerUtilizers']" />
<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/portal/include/referencingContents.jsp" />
</div>
</s:if>

</fieldset>
<fieldset>
	<legend><s:text name="title.resourceCategoriesManagement"/></legend>
<ul id="categoryTree">
	<s:set name="inputFieldName" value="'categoryCode'" />
	<s:set name="selectedTreeNode" value="selectedNode" />
	<s:set name="liClassName" value="'category'" />
	<s:if test="#categoryTreeStyleVar == 'classic'">
	<s:set name="currentRoot" value="categoryRoot" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
	</s:if>
	<s:elseif test="#categoryTreeStyleVar == 'request'">
	<s:set name="currentRoot" value="showableTree" />
	<s:set name="openTreeActionName" value="'openCloseCategoryTreeNodeOnEntryResource'" />
	<s:set name="closeTreeActionName" value="'openCloseCategoryTreeNodeOnEntryResource'" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
	</s:elseif>
</ul>
<div id="actions-container">
	<p class="buttons">
		<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/join-to-resource.png</s:set>
		<wpsf:submit useTabindexAutoIncrement="true" action="joinCategory" type="image" src="%{#iconImagePath}" value="%{getText('label.join')}" title="%{getText('label.join')}" />		
	</p>
</div>

<s:if test="categoryCodes != null && categoryCodes.size() > 0">

<table class="generic" summary="<s:text name="note.resourceCategories.summary"/>">
<caption><span><s:text name="title.resourceCategories.list"/></span></caption>
<tr>	
	<th><s:text name="label.category"/></th>
	<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
</tr>
<s:iterator value="categoryCodes" id="categoryCode">
<s:set name="resourceCategory" value="%{getCategory(#categoryCode)}"></s:set>
<tr>
	<td><s:property value="#resourceCategory.getFullTitle(currentLang.code)"/></td>
	<td class="icon">
		<wpsa:actionParam action="removeCategory" var="actionName" >
			<wpsa:actionSubParam name="categoryCode" value="%{#resourceCategory.code}" />
		</wpsa:actionParam>
		<s:set name="iconImagePath" id="iconImagePath"><wp:resourceURL />administration/common/img/icons/delete.png</s:set>
		<wpsf:submit useTabindexAutoIncrement="true" type="image" src="%{#iconImagePath}" action="%{#actionName}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />
	</td>
</tr>
</s:iterator>
</table>
</s:if>

</fieldset>

<fieldset><legend><s:text name="label.file" /></legend>
<p>
	<label for="upload" class="basic-mint-label"><s:text name="label.file" />:</label>
	<s:file name="upload" id="upload" label="label.file"/>
</p>
<p>
	<wpsf:checkbox useTabindexAutoIncrement="true" name="normalizeFileName" id="normalizeFileName" cssClass="radiocheck" />&#32;<label for="normalizeFileName"><s:text name="label.normalize" />&#32;<s:text name="label.filename" /></label>
</p>
</fieldset>

<p class="centerText">
	<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
</p>

</s:form>

</div>