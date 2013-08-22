<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:if test="onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
	<h1 class="panel panel-default title-page"><span class="panel-body display-block">
	<s:text name="jacms.menu.contentAdmin" />&#32;/&#32;
	<s:if test="getStrutsAction() == 1"><s:text name="label.new" /></s:if><s:else><s:text name="label.edit" /></s:else>&#32;/&#32;
	<s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />&#32;/&#32;
	<s:if test="getStrutsAction() == 1"><s:text name="label.new" /></s:if><s:else><s:text name="label.edit" /></s:else>
	</span></h1>
	<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />
</s:if>

<s:if test="!onEditContent">
	<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
	<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
	<s:set var="targetParamValue" value="resourceTypeCode" />
	<h1 class="panel panel-default title-page"><span class="panel-body display-block">
	<s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />&#32;/&#32;
	<s:if test="getStrutsAction() == 1"><s:text name="label.new" /></s:if><s:else><s:text name="label.edit" /></s:else>
	</span></h1>
</s:if>

<s:form action="save" method="post" enctype="multipart/form-data" cssClass="action-form">

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>
<s:if test="hasFieldErrors()">
	<div class="alert alert-danger alert-dismissable fade in">
		<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
		<ul clasS="margin-base-vertical">
		<s:iterator value="fieldErrors">
			<s:iterator value="value">
			<li><s:property escape="false" /></li>
			</s:iterator>
		</s:iterator>
		</ul>
	</div>
</s:if>

<p class="sr-only">
	<s:hidden name="strutsAction" />
	<s:hidden name="resourceTypeCode" />
	<s:hidden name="contentOnSessionMarker" />
	<s:iterator value="categoryCodes" id="categoryCode" status="rowstatus">
	<input type="hidden" name="categoryCodes" value="<s:property value="#categoryCode" />" id="categoryCodes-<s:property value="#rowstatus.index" />"/>
	</s:iterator>
	<s:if test="strutsAction != 1">
		<s:hidden name="resourceId" />
	</s:if>
	<s:if test="#categoryTreeStyleVar == 'request'">
		<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"/></s:iterator>
	</s:if>
</p>

<div class="panel panel-default">
	<div class="panel-body">
	 	<div class="form-group">
			<label class="control-label" for="descr"><s:text name="label.description" /></label>
			<s:textfield name="descr" id="descr" cssClass="form-control" />
		</div>

		<s:set name="lockGroupSelect" value="%{resourceId != null && resourceId != 0}"></s:set>
		<div class="form-group">
			<label class="control-label" for="mainGroup"><s:text name="label.group" /></label>
			<s:select name="mainGroup" id="mainGroup" list="allowedGroups" value="mainGroup"
			listKey="name" listValue="descr" disabled="%{lockGroupSelect}" cssClass="form-control" />
		</div>

		<s:if test="%{lockGroupSelect}">
			<p class="sr-only">
				<s:hidden name="mainGroup" />
			</p>
		</s:if>
		<div class="form-group">
			<label for="upload"><s:text name="label.file" /></label>
			<s:file name="upload" id="upload" label="label.file"/>
		</div>
  		<div class="checkbox">
    	<label>
			<input type="checkbox" name="normalizeFileName" id="normalizeFileName">&#32;<s:text name="label.normalize" />
		</label>
		</div>
	</div>
</div>

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
		<s:submit action="joinCategory" type="image" src="%{#iconImagePath}" value="%{getText('label.join')}" title="%{getText('label.join')}" />
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
		<s:submit type="image" src="%{#iconImagePath}" action="%{#actionName}" value="%{getText('label.remove')}" title="%{getText('label.remove')}" />
	</td>
</tr>
</s:iterator>
</table>
</s:if>

</fieldset>

<s:if test="strutsAction == 2">
	<s:set var="referencingContentsId" value="references['jacmsContentManagerUtilizers']" />
	<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/portal/include/referencingContents.jsp" />
</s:if>

<p class="text-center">
	<s:submit value="%{getText('label.save')}" cssClass="btn btn-default" />
</p>

</s:form>