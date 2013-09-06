<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="title.databaseManagement" /></a>
		&#32;/&#32;
		<s:text name="title.databaseBackup.remove" />
	</span>
</h1>
<s:set var="subFolderNameVar" value="subFolderName" />
<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
<s:form action="deleteBackup">
	<div class="panel panel-default">
		<span class="panel-body display-block">
			<s:hidden name="subFolderName" />
			<a
				href="<s:url namespace="/do/Admin/Database" action="entry" />"
				title="<s:text name="title.databaseManagement" />">
				<span class="icon icon-reply"></span></a>
				&#32;
				<s:text name="database.management.label.remove.areyousure" />&#32;
				<code><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></code>?
		</span>
		<p class="panel-body display-block text-center">
				<s:submit
					type="button"
					cssClass="btn btn-default">
					<s:text name="label.confirm" />
				</s:submit>
		</p>
	</div>
</s:form>