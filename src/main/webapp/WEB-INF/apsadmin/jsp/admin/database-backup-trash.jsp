<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">

<h2>TRASH BACKUP</h2>

<s:set var="subFolderNameVar" value="subFolderName" />
<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />

<s:form action="deleteBackup">
	<wpsf:hidden name="subFolderName" />
	ARE YOU SURE TO DELETE BACKUP OF <strong><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></strong>?
	<p class="centerText">
		<wpsf:submit value="%{getText('label.confirm')}" cssClass="button" />
	</p>
</s:form>


</div>