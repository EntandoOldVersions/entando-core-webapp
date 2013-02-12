<%@ page contentType="charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1>Database Management</h1>
<div id="main">
	<h2 class="margin-more-bottom">Database Backups</h2>

	<s:if test="hasActionErrors()">
		<div class="message message_error">
			<h3><s:text name="message.title.ActionErrors" /></h3>	
			<ul>
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<s:if test="hasFieldErrors()">
		<div class="message message_error">
			<h3><s:text name="message.title.FieldErrors" /></h3>	
			<ul>
				<s:iterator value="fieldErrors">
					<s:iterator value="value">
						<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<s:if test="hasActionMessages()">
		<div class="message message_confirm">
			<h3><s:text name="messages.confirm" /></h3>	
			<ul>
				<s:iterator value="actionMessages">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>

	<s:if test="managerStatus != 0" >
		<p class="message message_error">	
			Dump in progress... ( <a href="<s:url namespace="/do/Admin/Database" action="entry" />">Refresh</a> )
		</p>
	</s:if>
	<s:else>
		<s:set var="dumpReportsVar" value="dumpReports" />
		<s:if test="null == #dumpReportsVar || #dumpReportsVar.isEmpty()">
			<p>
				No backups available.
			</p>
		</s:if>
		<s:else>
			<table class="generic margin-more-top">
				<caption><span>Backup List</span></caption>
				<tr>
					<th><abbr title="Number">N</abbr></th>
					<th>Date</th>
					<th>Required Time</th>
					<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>	
				<tr>
				<s:iterator var="dumpReportVar" value="#dumpReportsVar" status="status">
					<td class="icon rightText monospace"><s:property value="#status.count" /></td>
					<td class="monospace">
						<a 
							title="Details: <s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
							href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" >
						   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
					   		</s:url>"><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></a> 
					</td>
					<td class="monospace">
						<s:property value="#dumpReportVar.requiredTime" /> milliseconds
					</td>
					<td class="icon">
						<a 
							title="Remove the backup: <s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
							href="<s:url namespace="/do/Admin/Database" action="trashBackup" >
							   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
						   </s:url>"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a>
					</td> 
				</s:iterator>
			</table>
		</s:else>
		<form action="<s:url namespace="/do/Admin/Database" action="backupIntro" />" method="get">
			<p class="centerText">
				<input type="submit" value="Create a Backup" class="button" />
			</p>
		</form>
	</s:else>
</div>