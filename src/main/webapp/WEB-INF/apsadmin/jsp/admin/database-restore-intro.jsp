<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="title.databaseManagement" /></a></h1>
<div id="main">
	<s:set var="subFolderNameVar" value="subFolderName" />
	<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
	<h2><s:text name="title.databaseBackup.restore" /></h2>
	<s:if test="managerStatus != 0" >
		<p class="message message_error">
			<s:text name="database.management.note.dump.in.progress" />&#32;(&#32;<a href="<s:url namespace="/do/Admin/Database" action="restoreIntro" ><s:param name="subFolderName" value="subFolderName" /></s:url>"><s:text name="database.management.refresh" /></a>&#32;)
		</p>
	</s:if>
	<s:else>
		<dl class="table-display">
			<dt>
				<s:text name="database.management.label.date" />
			</dt>
				<dd>
					<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />
				</dd>
		</dl>
		<p>
			<s:text name="database.management.note.installed.components" />
		</p>
		<s:set var="dumpReportVar" value="getDumpReport(subFolderName)" />
		<s:set var="currentComponentsVar" value="currentComponents" />
			<h3>
				<s:text name="database.management.label.components.current" />
			</h3>
			<p>
				<s:text name="database.management.note.components.current" />
				<em>entandoCore</em>
				<s:iterator var="currentComponentVar" value="#currentComponentsVar">
					,&#32;<em><s:property value="#currentComponentVar.code" /></em>
				</s:iterator>
			</p>
			<h3><s:text name="database.management.label.components.backup" /></h3>
			<p>
				<s:text name="database.management.note.components.backup" />
				<s:iterator var="componentHistoryVar" value="#dumpReportVar.componentsHistory" status="status">
					<em><s:property value="#componentHistoryVar.componentCode" /></em>
					<s:if test="%{!(#status.last)}">,&#32;</s:if>
				</s:iterator>
			</p>
		<s:set var="restoreCheckVar" value="%{checkRestore(#currentComponentsVar, #dumpReportVar)}" />
		<s:if test="#restoreCheckVar">
			<p class="message message_confirm">
				<s:text name="database.management.note.restore.do.fits" />
			</p>
		</s:if>
		<s:else>
			<p class="message message_error">
				<s:text name="database.management.note.restore.do.not.fits" />
			</p>
		</s:else>
		<s:form action="restoreBackup" method="get" namespace="/do/Admin/Database">
			<p class="centerText">
				<wpsf:hidden name="subFolderName" value="%{subFolderName}" />
				<wpsf:submit value="%{getText('database.management.label.restore')}" cssClass="button" />
			</p>
		</s:form>
	</s:else>
	<p>
		<a href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" ><s:param name="subFolderName" value="%{subFolderName}" /></s:url>">
			<s:text name="database.management.label.go.to.list" />
		</a>
	</p>
</div>