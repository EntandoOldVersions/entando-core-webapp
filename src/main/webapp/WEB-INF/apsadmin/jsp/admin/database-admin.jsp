<%@ page contentType="charset=UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> 
		/ 
		<s:text name="title.databaseManagement" />
	</span>
</h1>
<s:if test="hasActionErrors()">
	<div class="alert alert-warning alert-dismissable fade in">
		<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
		<ul class="margin-base-vertical">
			<s:iterator value="actionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>
<s:if test="hasFieldErrors()">
	<div class="alert alert-warning alert-dismissable fade in">
		<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
		<ul class="margin-base-vertical">
			<s:iterator value="fieldErrors">
					<s:iterator value="value">
						<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
		</ul>
	</div>
</s:if>
<s:if test="hasActionMessages()">
	<div class="alert alert-warning alert-dismissable fade in">
		<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
		<h2 class="h4 margin-none"><s:text name="messages.confirm" /></h2>
		<ul class="margin-base-vertical">
			<s:iterator value="actionMessages">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>

<s:if test="managerStatus != 0" >
	<div class="alert alert-warning alert-dismissable fade in">
			<s:text name="database.management.note.dump.in.progress" /> ( <a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="database.management.refresh" /></a> )
	</div>
</s:if>
<s:else>
		<s:set var="dumpReportsVar" value="dumpReports" />
		<s:if test="null == #dumpReportsVar || #dumpReportsVar.isEmpty()">
			<p>
				<s:text name="database.management.note.no.backups" />
			</p>
		</s:if>
		<s:else>
			<div class="table-responsive">
				<table class="table table-bordered table-hover table-condensed table-striped" summary="<s:text name="database.backup.list.summary" />">
					<caption><span><s:text name="database.management.label.backup.list" /></span></caption>
					<tr>
						<th class="text-center"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
						<th><abbr title="<s:text name="database.management.label.number" />"><s:text name="database.management.label.number.short" /></abbr></th>
						<th><s:text name="database.management.label.date" /></th>
						<th><s:text name="database.management.label.time.required" /></th>
					<tr>
					<s:iterator var="dumpReportVar" value="#dumpReportsVar" status="status">
						<tr>
							<td class="text-center">
								<a
									title="<s:text name="database.management.label.remove" />:&#32;<s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
									href="<s:url namespace="/do/Admin/Database" action="trashBackup" >
									   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
								   </s:url>">
								   <span class="icon icon-remove-circle"></span>
								  </a>
							</td>
							<td class="text-nowrap"><s:property value="#status.count" /></td>
							<td class="text-nowrap">
								<a
									title="<s:text name="database.management.label.details" />:&#32;<s:property value="#status.count" />&#32;&ndash;&#32;<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />"
									href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" >
								   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
							   		</s:url>"><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></a>
							</td>
							<td class="text-center text-nowrap">
								<code><s:property value="#dumpReportVar.requiredTime" /></code>&#32;<s:text name="database.management.label.milliseconds" />
							</td>
						</tr>
					</s:iterator>
				</table>
			</div>
		</s:else>
		<form action="<s:url namespace="/do/Admin/Database" action="backupIntro" />" method="get">
			<p class="text-center">
				<button type="submit" class="btn btn-primary">
					<s:text name="database.management.label.backup.create" />
				</button>
			</p>
		</form>
</s:else>