<%@ taglib prefix="s" uri="/struts-tags" %>

<h1><s:text name="menu.database.admin" /></h1>

<div id="main">

<s:set var="subFolderNameVar" value="subFolderName" />
<h2>BACKUP</h2>


<s:if test="managerStatus != 0" >
DUMPING/RESTORE IN PROGRESS
<br />
<a href="<s:url namespace="/do/Admin/Database" action="backupIntro" />">REFRESH</a>
</s:if>
<s:else>

<s:set var="currentComponentsVar" value="currentComponents" />

<strong>
Note..... TODO...
</strong>

<br /><br />

<strong>
COMPONENT CORE
</strong>
<br />
<s:set var="tableMappingVar" value="entandoTableMapping" />
<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />

<br />

<s:set var="currentComponentsVar" value="currentComponents" />

<s:iterator var="currentComponentVar" value="#currentComponentsVar" >
	<strong>
	COMPONENT '<s:property value="#currentComponentVar.description" />' (<s:property value="#currentComponentVar.code" />) 
	</strong>
	<br />
	<s:set var="tableMappingVar" value="#currentComponentVar.tableMapping" />
	<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
	<br />
</s:iterator>

<br />
<a href="<s:url namespace="/do/Admin/Database" action="executeBackup" />">EXECUTE BACKUP</a>

</s:else>

</div>