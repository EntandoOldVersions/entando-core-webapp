<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />">Database Management</a></h1>
<div id="main">
	<h2>Remove Backup</h2>
	<s:set var="subFolderNameVar" value="subFolderName" />
	<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
	<s:form action="deleteBackup">
		<p>
			<wpsf:hidden name="subFolderName" />
			Are you sure you want to delete the backup 
			<em><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></em>?
			<wpsf:submit value="%{getText('label.confirm')}" cssClass="button" />
		</p>
		<p>
			If You don't want to remove this backup, go to the 
			<a href="<s:url namespace="/do/Admin/Database" action="entry" />">Database Management</a>
		</p>
	</s:form>
</div>