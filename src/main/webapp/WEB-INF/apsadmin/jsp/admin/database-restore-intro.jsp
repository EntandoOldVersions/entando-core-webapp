<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">

<s:set var="subFolderNameVar" value="subFolderName" />
<h2>RESTORE</h2>


<s:if test="managerStatus != 0" >
DUMPING/RESTORE IN PROGRESS
<br />
<a href="<s:url namespace="/do/Admin/Database" action="restoreIntro" >
	   <s:param name="subFolderName" value="subFolderName" />
   </s:url>">REFRESH</a>
</s:if>
<s:else>

<s:set var="dumpReportVar" value="getDumpReport(subFolderName)" />

<br />
<s:set var="currentComponentsVar" value="currentComponents" />

<strong>CURRENT COMPONENTS</strong>

<br />

'entandoCore'
<s:iterator var="currentComponentVar" value="#currentComponentsVar" >
, '<s:property value="#currentComponentVar.code" />'
</s:iterator>
<br />

<strong>COMPONENT HISTORY</strong>
<br />
<s:iterator var="componentHistoryVar" value="#dumpReportVar.componentsHistory" status="statusVar">
	'<s:property value="#componentHistoryVar.componentName" />'<s:if test="!#statusVar.last">, </s:if>
</s:iterator>

<s:set var="restoreCheckVar" value="%{checkRestore(#currentComponentsVar, #dumpReportVar)}" />
<s:property value="#restoreCheckVar" />
<br /><br />

INFO: Current components<s:if test="!#restoreCheckVar" > NOT</s:if> fits with this dump

<br /><br />
<strong>
Note..... TODO...
</strong>

<br /><br /><br />
<a href="<s:url namespace="/do/Admin/Database" action="restoreBackup" >
	   <s:param name="subFolderName" value="subFolderName" />
   </s:url>">RESTORE BACKUP</a>

</s:else>

</div>