<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">

<s:if test="managerStatus != 0" >
DUMPING IN PROGRESS
</s:if>
<s:else>
<s:set var="lastDumpReportVar" value="lastDumpReport" />

<s:if test="null == #lastDumpReportVar">
DUMP NON AVAILABLE
</s:if>
<s:else>

DATE <s:date name="#lastDumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />
<br />
<s:iterator var="dataSourceNameVar" value="#lastDumpReportVar.dataSourceNames">
<br />
DATASOURCE <s:property value="#dataSourceNameVar" />
<br />
<s:set var="tableReportsVar" value="#lastDumpReportVar.dataSourcesReports[#dataSourceNameVar]" />
<s:iterator var="tableReportVar" value="#tableReportsVar">
	Table <s:property value="#tableReportVar.tableName" /> - 
	rows <s:property value="#tableReportVar.rows" /> - 
	dump time <s:property value="#tableReportVar.requiredTime" /> ms
	<br />
</s:iterator>
	
</s:iterator>

</s:else>

</s:else>

<%--
<p class="message message_confirm">
	<span class="noscreen"><s:text name="messages.confirm" />: </span> BACKUP DONE!!!!.
</p>
--%>
</div>