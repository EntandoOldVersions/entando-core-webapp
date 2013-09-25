<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:property value="%{'title.' + entityManagerName + '.management'}" />
	</span>
</h1>

<div id="main">
<h2><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />"><s:text name="title.entityAdmin.manager" />: <s:property value="entityManagerName" /></a></h2>
<h3><s:text name="title.entityTypes.editType.delete" />: <span class="monospace"><s:property value="entityTypeCode" /> - <s:property value="%{getEntityPrototype(entityTypeCode).typeDescr}" /></span></h3>

<div class="message message_error">	
	<h4><s:text name="message.title.ActionErrors" /></h4>
	<p>
		<s:property value="references.size()" />&#32;<s:text name="note.entityTypes.deleteType.references" />
	</p>
</div>

	<p><s:text name="note.entityTypes.deleteType.references.outro" />:</p>

	<ol>
<s:iterator value="references" id="entityId">
		<li><s:property value="#entityId" /></li>
</s:iterator>
	</ol>

<s:if test="entityManagerName == 'jacmsContentManager'">
	<p>
		<a href="<s:url action="search" namespace="/do/jacms/Content"><s:param name="contentType"><s:property value="entityTypeCode" /></s:param><s:param name="viewCode"><s:property value="true" /></s:param><s:param name="viewTypeDescr"><s:property value="true" /></s:param></s:url>"><s:text name="note.goToSomewhere" />: <s:text name="jacms.menu.contentAdmin.list" /></a>
	</p>
</s:if>

<p>
	<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>"><s:text name="note.backToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" /></a>
</p>

</div>