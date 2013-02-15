<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="title.databaseManagement" /></a></h1>
<div id="main">
	<s:set var="subFolderNameVar" value="subFolderName" />
	<h2><s:text name="title.databaseBackup.new" /></h2>
	<s:if test="managerStatus != 0" >
		<p class="message message_error">
			<s:text name="database.management.note.dump.in.progress" />&#32;( <a href="<s:url namespace="/do/Admin/Database" action="backupIntro" />"><s:text name="database.management.refresh" /></a> )
		</p>
	</s:if>
	<s:else>
		<s:set var="currentComponentsVar" value="currentComponents" />
		<p>
			<s:text name="database.management.note.backup" />
		</p>
		<div class="block-column-container">
			<div class="block-column-left">
				<h3 class="centerText">
					<s:text name="database.management.label.component" />&#32;Core
				</h3>
				<s:set var="tableMappingVar" value="entandoTableMapping" />
				<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />

				<s:set var="currentComponentsVar" value="currentComponents" />
				<s:iterator var="currentComponentVar" begin="0" end="%{#currentComponentsVar.size()/2-1}" value="#currentComponentsVar" >
					<div class="subsection-light margin-more-top">
						<h3 class="centerText">
							<s:text name="database.management.label.component" />&#32;<em><s:property value="#currentComponentVar.description" /></em> (<s:property value="#currentComponentVar.code" />)
						</h3>
						<s:set var="tableMappingVar" value="#currentComponentVar.tableMapping" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
					</div>
				</s:iterator>
			</div>
			<div class="block-column-right">
				<s:iterator var="currentComponentVar" begin="%{#currentComponentsVar.size()/2}" value="#currentComponentsVar" status="statusVar">
					<s:if test="%{!(#statusVar.first)}">
						<div class="subsection-light margin-more-top">
					</s:if>
						<h3 class="centerText">
							<s:text name="database.management.label.component" />&#32;<em><s:property value="#currentComponentVar.description" /></em> (<s:property value="#currentComponentVar.code" />)
						</h3>
						<s:set var="tableMappingVar" value="#currentComponentVar.tableMapping" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/datasource-table-names.jsp" />
					<s:if test="%{!(#statusVar.first)}">
						</div>
					</s:if>
				</s:iterator>
			</div>
		</div>
		<s:form action="executeBackup" namespace="/do/Admin/Database" method="get">
				<p class="centerText">
					<wpsf:submit action="executeBackup" value="%{getText('database.management.label.backup.execute')}" cssClass="button" />
				</p>
				<p>
					<a href="<s:url namespace="/do/Admin/Database" action="entry" />"><s:text name="database.management.label.go.to.list" /></a>
				</p>
		</s:form>
	</s:else>
</div>