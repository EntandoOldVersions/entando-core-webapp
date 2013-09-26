<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />">
		<s:text name="%{'title.' + entityManagerName + '.management'}" />
		</a>&#32;|&#32;
		<s:text name="title.entityTypes.editType.delete" />: <span class="monospace"><s:property value="entityTypeCode" /> - <s:property value="%{getEntityPrototype(entityTypeCode).typeDescr}" /></span>
	</span>
</h1>

<s:form action="removeEntityType">
	<p class="sr-only">
		<wpsf:hidden name="entityManagerName" />
		<wpsf:hidden name="entityTypeCode" />
	</p>

	<p>
		<s:text name="note.entityTypes.deleteType.areYouSure" />:&#32;<em class="important"><span class="monospace"><s:property value="entityTypeCode" /> - <s:property value="%{getEntityPrototype(entityTypeCode).typeDescr}" /></span></em>&#32;?
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>
	
	<p><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>"><s:text name="note.backToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" /></a></p>

</s:form>