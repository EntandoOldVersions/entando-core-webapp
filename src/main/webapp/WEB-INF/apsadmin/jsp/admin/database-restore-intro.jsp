<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />">Database Management</a></h1>
<div id="main">
	<s:set var="subFolderNameVar" value="subFolderName" />
	<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
	<h2>Restore</h2>
	<s:if test="managerStatus != 0" >
		<p class="message message_error">	
			Dump/Restore in progress... ( <a href="<s:url namespace="/do/Admin/Database" action="restoreIntro" ><s:param name="subFolderName" value="subFolderName" /></s:url>">Refresh</a> )
		</p>
	</s:if>
	<s:else>
		<dl class="table-display">
			<dt>
				Date
			</dt>
				<dd>
					<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />
				</dd>
		</dl>
		<p>
			Below the details of the components installed in this portal and the components data present in the backup.
		</p>
		<s:set var="dumpReportVar" value="getDumpReport(subFolderName)" />
		<s:set var="currentComponentsVar" value="currentComponents" />
			<h3>
				Current Components
			</h3>
			<p>
				The components currently installed in this portal:
				<em>entandoCore</em>
				<s:iterator var="currentComponentVar" value="#currentComponentsVar" status="status" >
					<s:if test="%{!(#status.last) || #status.first}">,&#32;</s:if>
					<em><s:property value="#currentComponentVar.code" /></em>
				</s:iterator>
			</p>

			<h3>Backup Components</h3>
			<p>
				The components data within this backup:
				<s:iterator var="componentHistoryVar" value="#dumpReportVar.componentsHistory" status="status">
					<em><s:property value="#componentHistoryVar.componentCode" /></em>
					<s:if test="%{!(#status.last)}">,&#32;</s:if>
				</s:iterator>
			</p>

		<s:set var="restoreCheckVar" value="%{checkRestore(#currentComponentsVar, #dumpReportVar)}" />
		<s:if test="#restoreCheckVar">
			<p class="message message_confirm">
				The backup fits the components installed in this portal. No problem detected.
			</p>
		</s:if>
		<s:else>
			<p class="message message_error">
				This backup don't fits the installed components. Problems may occur while restoring.
			</p>
		</s:else>

		<s:form action="restoreBackup" method="get" namespace="/do/Admin/Database">
			<p class="centerText">
				<wpsf:hidden name="subFolderName" value="%{subFolderName}" />
				<wpsf:submit value="Restore Backup" cssClass="button" />
			</p>
		</s:form>
	</s:else>
	<p>
		<a href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" ><s:param name="subFolderName" value="%{subFolderName}" /></s:url>">
			Go to backup details
		</a>
	</p>
</div>