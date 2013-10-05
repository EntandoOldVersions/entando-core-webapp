<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a>&#32;/&#32;
		<s:text name="title.pageManagement.pageTrash" />
	</span>
</h1>

<div id="main">

<s:form action="delete">
	<p class="sr-only">
		<wpsf:hidden name="selectedNode"/>
		<wpsf:hidden name="nodeToBeDelete" />
	</p>
	<div class="alert alert-warning">
		<p>
			<s:text name="note.deletePage.areYouSure" />&#32;
			<code><s:property value="%{getPage(nodeToBeDelete).getTitle(currentLang.getCode())}" /></code>?
		</p>
		<div class="text-center margin-large-top">
		<s:submit type="button" action="delete" cssClass="btn btn-warning btn-lg">
			<span class="icon icon-remove-sign"></span>&#32;
			<s:text name="label.remove" />
		</s:submit>
		<a class="btn btn-link" href="<s:url action="viewTree" namespace="/do/Page"/>" ><s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" /></a>
		</div>
	</div>
</s:form>

</div>