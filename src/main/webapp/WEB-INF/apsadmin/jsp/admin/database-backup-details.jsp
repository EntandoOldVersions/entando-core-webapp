<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">
	
<s:set var="subFolderNameVar" value="subFolderName" />
<h2>BACKUP</h2>


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

<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />

<s:if test="null == #dumpReportVar">
DUMP NON AVAILABLE
</s:if>
<s:else>

<strong>DATE <s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" /></strong>
<br />
Required Time <s:property value="#dumpReportVar.requiredTime" /> ms

	
<br /><br />
<strong>COMPONENT HISTORY</strong>
<br />
<s:iterator var="componentHistoryVar" value="#dumpReportVar.componentsHistory">
	Component <s:property value="#componentHistoryVar.componentCode" /> - 
	date <s:date name="#componentHistoryVar.date" format="dd/MM/yyyy HH:mm:ss" />
	<br />
</s:iterator>
<br />

<s:iterator var="dataSourceNameVar" value="#dumpReportVar.dataSourceNames">
<br />
<strong>DATASOURCE <s:property value="#dataSourceNameVar" /></strong>
<br />
<s:set var="tableReportsVar" value="#dumpReportVar.dataSourcesReports[#dataSourceNameVar]" />
<s:iterator var="tableReportVar" value="#tableReportsVar">
	Table
	<strong>
	<s:if test="#tableReportVar.rows == 0"><s:property value="#tableReportVar.tableName" /></s:if>
	<s:else>
	<a href="<s:url namespace="/do/Admin/Database" action="extractTableDump" >
		   <s:param name="tableName" value="#tableReportVar.tableName" />
		   <s:param name="dataSourceName" value="#dataSourceNameVar" />
		   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
	   </s:url>"><s:property value="#tableReportVar.tableName" /></a>
	</s:else></strong> - rows <s:property value="#tableReportVar.rows" /> - 
	dump time <s:property value="#tableReportVar.requiredTime" /> ms
	<br />
</s:iterator>
</s:iterator>

<br />
<a href="<s:url namespace="/do/Admin/Database" action="restoreIntro" >
		   <s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
	   </s:url>">RESTORE BACKUP</a>

</s:else>

<br />
<a href="<s:url namespace="/do/Admin/Database" action="entry" />">Back to Backups list</a>

</s:else>

</div>
