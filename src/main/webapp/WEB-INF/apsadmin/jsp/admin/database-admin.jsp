<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">

<h2>AVAILABLE DUMPS</h2>

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
DUMPING IN PROGRESS

<br />
<a href="<s:url namespace="/do/Admin/Database" action="entry" />">REFRESH</a>

</s:if>
<s:else>

<s:set var="dumpReportsVar" value="dumpReports" />

<s:if test="null == #dumpReportsVar || #dumpReportsVar.isEmpty()">
DUMP NON AVAILABLE
</s:if>
<s:else>

<br /><br />

<s:iterator var="dumpReportVar" value="#dumpReportsVar">
	<a href="<s:url namespace="/do/Admin/Database" action="entryBackupDetails" >
		   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
	   </s:url>"><s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></a> 
	(required Time <s:property value="#dumpReportVar.requiredTime" /> ms) - 
	<a href="<s:url namespace="/do/Admin/Database" action="trashBackup" >
		   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
	   </s:url>">**delete**</a> 
	<br />
</s:iterator>

</s:else>

<br />
<a href="<s:url namespace="/do/Admin/Database" action="executeBackup" />">EXECUTE BACKUP</a>

</s:else>

</div>