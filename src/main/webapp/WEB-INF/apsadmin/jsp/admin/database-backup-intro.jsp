<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />">Database Management</a></h1>
<div id="main">
	<s:set var="subFolderNameVar" value="subFolderName" />
	<h2>New Backup</h2>
	<s:if test="managerStatus != 0" >
		<p class="message message_error">	
			Dump/Restore in progress... ( <a href="<s:url namespace="/do/Admin/Database" action="backupIntro" />">Refresh</a> )
		</p>
	</s:if>
	<s:else>
		<s:set var="currentComponentsVar" value="currentComponents" />
		<p>
			Below the datasource and tables that will be dumped.
		</p>
		<div class="block-column-container">
			<div class="block-column-left">
				<h3 class="centerText">
					Component Core
				</h3>
				<s:set var="tableMappingVar" value="entandoTableMapping" />
				<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
			
				<s:set var="currentComponentsVar" value="currentComponents" />
				<s:iterator var="currentComponentVar" begin="0" end="%{#currentComponentsVar.size()/2-1}" value="#currentComponentsVar" >
						<h3 class="centerText">
							Component '<s:property value="#currentComponentVar.description" />' (<s:property value="#currentComponentVar.code" />) 
						</h3>
						<s:set var="tableMappingVar" value="#currentComponentVar.tableMapping" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
				</s:iterator>
			</div>
			<div class="block-column-right">
				<s:iterator var="currentComponentVar" begin="%{#currentComponentsVar.size()/2}" value="#currentComponentsVar" >
						<h3 class="centerText">
							Component '<s:property value="#currentComponentVar.description" />' (<s:property value="#currentComponentVar.code" />) 
						</h3>
						<s:set var="tableMappingVar" value="#currentComponentVar.tableMapping" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
				</s:iterator>
			</div>
		</div>
		<s:form action="executeBackup" namespace="/do/Admin/Database" method="get">
				<p class="centerText">
					<wpsf:submit action="executeBackup" value="Execute Backup" cssClass="button" />
				</p>
				<p>
					<a href="<s:url namespace="/do/Admin/Database" action="entry" />">Go to Backups list</a>
				</p>
		</s:form>
	</s:else>
</div>