<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:text name="title.categoryManagement" /></span></h1>

<div id="main">

<s:form cssClass="action-form">

<s:if test="hasActionErrors()">
<div class="message message_error">
<h2><s:text name="message.title.ActionErrors" /></h2>
<ul>
	<s:iterator value="actionErrors">
		<li><s:property escape="false" /></li>
	</s:iterator>
</ul>
</div>
</s:if>
<s:if test="hasActionMessages()">
	<div class="message message_confirm">
	<h3><s:text name="messages.confirm" /></h3>
	<ul>
		<s:iterator value="actionMessages">
			<li><s:property escape="false" /></li>
		</s:iterator>
	</ul>
	</div>
</s:if>

<fieldset class="margin-more-top"><legend><s:text name="title.categoryTree" /></legend>

<s:set var="categoryTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_category" /></s:set>

<ul id="categoryTree">
	<s:set name="inputFieldName" value="'selectedNode'" />
	<s:set name="selectedTreeNode" value="selectedNode" />
	<s:set name="liClassName" value="'category'" />
	<s:if test="#categoryTreeStyleVar == 'classic'">
	<s:set name="currentRoot" value="treeRootNode" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
	</s:if>
	<s:elseif test="#categoryTreeStyleVar == 'request'">
	<s:set name="openTreeActionName" value="'openCloseCategoryTree'" />
	<s:set name="closeTreeActionName" value="'openCloseCategoryTree'" />
	<s:set name="currentRoot" value="showableTree" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-links.jsp" />
	</s:elseif>
</ul>

</fieldset>

<fieldset data-toggle="tree-toolbar"><legend><s:text name="title.categoryActions" /></legend>
<p class="sr-only"><s:text name="title.categoryActionsIntro" /></p>

<p data-toggle="tree-toolbar-actions">
	<s:set var="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/page-new.png</s:set>
	<wpsf:submit useTabindexAutoIncrement="true" action="new" type="image" src="%{#iconImagePath}" value="%{getText('category.options.new')}" title="%{getText('category.options.new')}" />
	<s:set var="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/page-edit.png</s:set>
	<wpsf:submit useTabindexAutoIncrement="true" action="edit" type="image" src="%{#iconImagePath}" value="%{getText('category.options.modify')}" title="%{getText('category.options.modify')}" />
	<s:set var="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/detail.png</s:set>
	<wpsf:submit useTabindexAutoIncrement="true" action="detail" type="image" src="%{#iconImagePath}" value="%{getText('category.options.detail')}" title="%{getText('category.options.detail')}" />
	<s:set var="iconImagePath"><wp:resourceURL/>administration/common/img/icons/32x32/delete.png</s:set>
	<wpsf:submit useTabindexAutoIncrement="true" action="trash" type="image" src="%{#iconImagePath}" value="%{getText('category.options.delete')}" title="%{getText('category.options.delete')}" />
</p>
</fieldset>
</s:form>

</div>