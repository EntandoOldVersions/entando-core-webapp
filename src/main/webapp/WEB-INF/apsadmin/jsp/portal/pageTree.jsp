<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><s:text name="title.pageManagement" /></h1>

<div id="main">

<p><s:text name="note.pageTree.intro" /></p>

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

<%-- Inclusione del form di ricerca per codice --%>
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageSearchForm.jsp" />

<div class="subsection">

<s:form cssClass="action-form">

<fieldset><legend><s:text name="title.pageTree" /></legend>

<s:set var="pageTreeStyleVar" ><wp:info key="systemParam" paramName="treeStyle_page" /></s:set>

<ul id="pageTree" class="icons-ul list-unstyled">
	<s:set name="inputFieldName" value="'selectedNode'" />
	<s:set name="selectedTreeNode" value="selectedNode" />
	<s:set name="liClassName" value="'page'" />
	<s:set name="treeItemIconName" value="'icon-folder-close'" />

	<s:if test="#pageTreeStyleVar == 'classic'">
	<s:set name="currentRoot" value="allowedTreeRootNode" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder.jsp" />
	</s:if>
	<s:elseif test="#pageTreeStyleVar == 'request'">
	<s:set name="currentRoot" value="showableTree" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/treeBuilder-request-links.jsp" />
	</s:elseif>
</ul>

</fieldset>

<p class="sr-only"><wpsf:hidden name="copyingPageCode" /></p>

<fieldset id="actions-container"><legend><s:text name="title.pageActions" /></legend>
<p class="sr-only"><s:text name="title.pageActionsIntro" /></p>

<div id="actions-container">
	<div class="buttons btn-toolbar">
		<div class="btn-group btn-group-sm margin-small-top margin-small-bottom">
			<s:submit action="configure" type="button" title="%{getText('page.options.configure')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-cog"></span>
			</s:submit>
			<s:submit action="detail" type="button" title="%{getText('page.options.detail')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-info"></span>
			</s:submit>
		</div>
		<div class="btn-group btn-group-sm margin-small-top margin-small-bottom">
			<s:submit action="copy" type="button" title="%{getText('page.options.copy')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-copy"></span>
			</s:submit>
			<s:submit action="paste" type="button" title="%{getText('page.options.paste')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-paste"></span>
			</s:submit>
			<s:submit action="moveUp" type="button" title="%{getText('page.options.moveUp')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-sort-up"></span>
			</s:submit>
			<s:submit action="moveDown" type="button" title="%{getText('page.options.moveDown')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-sort-down"></span>
			</s:submit>
		</div>
		<div class="btn-group btn-group-sm margin-small-top margin-small-bottom">
			<s:submit action="new" type="button" title="%{getText('page.options.new')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-plus-sign"></span>
			</s:submit>
			<s:submit action="edit" type="button" title="%{getText('page.options.modify')}" cssClass="btn btn-info" data-toggle="tooltip">
				<span class="icon icon-edit"></span>
			</s:submit>
		</div>
		<div class="btn-group btn-group-sm margin-small-top margin-small-bottom">
			<s:submit action="trash" type="button" title="%{getText('page.options.delete')}" cssClass="btn btn-warning" data-toggle="tooltip">
				<span class="icon icon-remove-sign"></span>
			</s:submit>
		</div>
	</div>
</div>
</fieldset>
</s:form>

</div>
</div>