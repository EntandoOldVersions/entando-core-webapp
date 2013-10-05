<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<s:text name="title.apiServiceManagement" />&#32;/&#32;
		<s:text name="title.api.apiService.trash" />
	</span>
</h1>

<div id="main">
	<s:form action="delete">
		<p class="sr-only">
			<wpsf:hidden name="serviceKey" />
		</p>
		<div class="alert alert-warning">
			<p>
				<s:text name="note.api.apiService.trash" />:&#32;
				<code><s:property value="serviceKey" /></code>?
			</p>
			<div class="text-center margin-large-top">
				<s:submit type="button" action="delete" cssClass="btn btn-warning btn-lg">
					<span class="icon icon-remove-sign"></span>&#32;
					<s:text name="label.remove" />
				</s:submit>
				<a class="btn btn-link" href="<s:url action="list" namespace="/do/Api/Service"/>" ><s:text name="note.goToSomewhere" />: <s:text name="menu.apisAdmin.services" /></a>
			</div>
		</div>
	</s:form>
</div>