<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>" title="<s:text name="note.goToSomewhere" />: <s:text name="title.entityAdmin.manager" />&#32;<s:property value="entityManagerName" />">
		<s:text name="%{'title.' + entityManagerName + '.management'}" />
		</a>&#32;/&#32;
		<s:text name="title.entityTypes.editType.remove" />
	</span>
</h1>

<s:form action="removeEntityType">
	<p class="sr-only">
		<s:hidden name="entityManagerName" />
		<s:hidden name="entityTypeCode" />
	</p>
	<div class="alert alert-warning">
		<p>
			<s:text name="note.entityTypes.deleteType.areYouSure" />:&#32;
			<code><s:property value="entityTypeCode" /><code>
			<s:property value="%{getEntityPrototype(entityTypeCode).typeDescr}" />?
		</p>
		<div class="text-center margin-large-top">
		<s:submit type="button" cssClass="btn btn-warning btn-lg">
			<span class="icon icon-remove-sign"></span>&#32;
            <s:text name="label.remove" />
        </s:submit>
		<a class="btn btn-link" href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName"><s:property value="entityManagerName" /></s:param></s:url>">
		<s:text name="note.goToSomewhere" />: <s:text name="%{'title.' + entityManagerName + '.management'}" /></a>
		</div>
	</div>
</s:form>
