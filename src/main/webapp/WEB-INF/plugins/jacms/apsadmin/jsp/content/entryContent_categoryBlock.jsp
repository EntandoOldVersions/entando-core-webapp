<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<s:if test="#categoryTreeStyleVar == 'request'">
<p class="sr-only">
<s:iterator value="treeNodesToOpen" var="treeNodeToOpenVar"><s:hidden name="treeNodesToOpen" value="%{#treeNodeToOpenVar}"></s:hidden></s:iterator>
</p>
</s:if>

<fieldset class="margin-base-vertical" id="category-content-block">
	<legend><span class="icon icon-tags"></span>&#32;<s:text name="title.categoriesManagement"/></legend>
	<div class="well">
		<ul id="categoryTree" class="icons-ul list-unstyled">
			<s:set name="inputFieldName" value="'categoryCode'" />
			<s:set name="selectedTreeNode" value="categoryCode" />
			<s:set name="liClassName" value="'category'" />
			<s:set name="treeItemIconName" value="'icon-folder-close'" />

			<s:if test="#categoryTreeStyleVar == 'classic'">
				<s:set name="currentRoot" value="categoryRoot" />
			 	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
			</s:if>
			<s:elseif test="#categoryTreeStyleVar == 'request'">
				<s:set name="currentRoot" value="showableTree" />
				<s:set name="openTreeActionName" value="'entryContent'" />
				<s:set name="closeTreeActionName" value="'entryContent'" />
				<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-submits.jsp" />
			</s:elseif>
		</ul>
		<div data-toggle="tree-toolbar">
			<div data-toggle="tree-toolbar-actions">
				<s:submit action="joinCategory" type="button" title="%{getText('label.join')}" cssClass="btn btn-info btn-sm margin-small-vertical" data-toggle="tooltip">
					<span class="icon icon-plus"></span>
				</s:submit>
			</div>
		</div>
	</div>
<s:set var="contentCategories" value="content.categories" />

<s:if test="#contentCategories != null && #contentCategories.size() > 0">

<h4 class="margin-base-vertical"><s:text name="note.contentCategories.summary"/></h4>

<s:iterator value="#contentCategories" id="contentCategory">
	<span class="label label-default label-sm pull-left padding-small-top padding-small-bottom margin-small-right margin-small-bottom">
		<span class="icon icon-tag"></span>&#32;
		<abbr title="<s:property value="#contentCategory.getFullTitle(currentLang.code)"/>"><s:property value="#contentCategory.getShortFullTitle(currentLang.code)" /></abbr>&#32;
		<wpsa:actionParam action="removeCategory" var="actionName" >
			<wpsa:actionSubParam name="categoryCode" value="%{#contentCategory.code}" />
		</wpsa:actionParam>
		<s:submit type="button" action="%{#actionName}" title="%{getText('label.remove') + ' ' + #contentCategory.defaultFullTitle}" cssClass="btn btn-default btn-xs badge">
			<span class="icon icon-remove"></span>
			<span class="sr-only">x</span>
		</s:submit>
	</span>
</s:iterator>
</s:if>

</fieldset>