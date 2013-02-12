<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="title.databaseManagement" /></a></h1>
<div id="main">
	<h2><s:text name="title.databaseBackup.remove" /></h2>
	<s:set var="subFolderNameVar" value="subFolderName" />
	<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
	<s:form action="deleteBackup">
		<p>
			<wpsf:hidden name="subFolderName" />
			<s:text name="database.management.label.remove.areyousure" />&#32;
			<em><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></em>?
			<wpsf:submit value="%{getText('label.confirm')}" cssClass="button" />
		</p>
		<p>
			<s:text name="database.management.note.not.sure" />
			<a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="title.databaseManagement" /></a>
		</p>
	</s:form>
</div>