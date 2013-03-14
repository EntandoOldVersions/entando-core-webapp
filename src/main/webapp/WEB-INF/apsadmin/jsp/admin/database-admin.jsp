<%@ page contentType="charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1><s:text name="title.databaseManagement" /></h1>
<div id="main">
	<h2 class="margin-more-bottom"><s:text name="title.databaseBackup" /></h2>
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
			<s:text name="database.management.note.dump.in.progress" /> ( <a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="database.management.refresh" /></a> )
		</p>
	</s:if>
	<s:else>
		<s:set var="dumpReportsVar" value="dumpReports" />
		<s:if test="null == #dumpReportsVar || #dumpReportsVar.isEmpty()">
			<p>
				<s:text name="database.management.note.no.backups" />
			</p>
		</s:if>
		<s:else>
			<table class="generic margin-more-top" summary="<s:text name="database.backup.list.summary" />">
				<caption><span><s:text name="database.management.label.backup.list" /></span></caption>
				<tr>
					<th><abbr title="<s:text name="database.management.label.number" />"><s:text name="database.management.label.number.short" /></abbr></th>
					<th><s:text name="database.management.label.date" /></th>
					<th><s:text name="database.management.label.time.required" /></th>
					<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
				<tr>
				<s:iterator var="dumpReportVar" value="#dumpReportsVar" status="status">
					<tr>
						<td class="icon rightText monospace"><s:property value="#status.count" /></td>
						<td class="rightText monospace">
							<a
								title="<s:text name="database.management.label.details" />:&#32;<s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
								href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" >
							   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
						   		</s:url>"><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></a>
						</td>
						<td class="rightText monospace">
							<s:property value="#dumpReportVar.requiredTime" />&#32;<s:text name="database.management.label.milliseconds" />
						</td>
						<td class="icon">
							<a
								title="<s:text name="database.management.label.remove" />:&#32;<s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
								href="<s:url namespace="/do/Admin/Database" action="trashBackup" >
								   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
							   </s:url>"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a>
						</td>
					</tr>
				</s:iterator>
			</table>
		</s:else>
		<form action="<s:url namespace="/do/Admin/Database" action="backupIntro" />" method="get">
			<p class="centerText">
				<input type="submit" value="<s:text name="database.management.label.backup.create" />" class="button" />
			</p>
		</form>
	</s:else>
</div>
