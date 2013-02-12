<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<h1><a href="<s:url namespace="/do/Admin/Database" action="entry" />">Database Management</a></h1>
<div id="main">
	<s:set var="subFolderNameVar" value="subFolderName" />
	<h2>Backup Details</h2>
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
		<s:set var="dumpReportVar" value="getDumpReport(#subFolderNameVar)" />
		<s:if test="null == #dumpReportVar">
			<p>
				The requested dump is not available.
			</p>
		</s:if>
		<s:else>
			<dl class="table-display">
				<dt>
					Date
				</dt>
					<dd>
						<s:date name="#dumpReportVar.date" format="dd/MM/yyyy HH:mm:ss" />
					</dd>
				<dt>
					Required Time
				</dt>
					<dd><s:property value="#dumpReportVar.requiredTime" /> milliseconds</dd>
			</dl>

			<h3 class="centerText">
				Backup Components
			</h3>
			<dl class="table-display">
				<s:iterator var="componentHistoryVar" value="#dumpReportVar.componentsHistory">
					<dt>
						<s:property value="#componentHistoryVar.componentCode" />
					</dt>
						<dd>
							<s:date name="#componentHistoryVar.date" format="dd/MM/yyyy HH:mm:ss" />
						</dd>
				</s:iterator>
			</dl>
			<div class="block-column-container margin-more-bottom">
				<div class="block-column-left">
					<s:iterator var="dataSourceNameVar" value="#dumpReportVar.dataSourceNames" begin="0" end="%{(#dumpReportVar.dataSourceNames.size()/2)-1}" status="status">
						<table class="generic reset_<s:property value="#status.count%2" />">
							<caption>
								<span>
									Datasource <s:property value="#dataSourceNameVar" />
								</span>
							</caption>
							<s:set var="tableReportsVar" value="#dumpReportVar.dataSourcesReports[#dataSourceNameVar]" />
							<tr>
								<th>Table Name</th>
								<th>Rows</th>
								<th>Time</th>
							</tr>
							<s:iterator var="tableReportVar" value="#tableReportsVar">
								<tr>
									<td>
										<s:if test="#tableReportVar.rows == 0"><s:property value="#tableReportVar.tableName" /></s:if>
										<s:else>
												<a 
													title="Download: <s:property value="#dataSourceNameVar" />/<s:property value="#tableReportVar.tableName" />"
													href="<s:url namespace="/do/Admin/Database" action="extractTableDump" >
													<s:param name="tableName" value="#tableReportVar.tableName" />
													<s:param name="dataSourceName" value="#dataSourceNameVar" />
													<s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
												</s:url>"><s:property value="#tableReportVar.tableName" /></a>
										</s:else>
									</td>
									<td class="rightText monospace">
										<s:property value="#tableReportVar.rows" />
									</td>
									<td class="rightText monospace">
										<s:property value="#tableReportVar.requiredTime" /> ms
									</td>
								</tr>
							</s:iterator>
						</table>
					</s:iterator>
				</div>
				<div class="block-column-right">
					<s:iterator var="dataSourceNameVar" value="#dumpReportVar.dataSourceNames" begin="%{(#dumpReportVar.dataSourceNames.size()/2)}" status="status">
						<table class="generic reset_<s:property value="#status.count%2" />">
							<caption>
								<span>
									Datasource <s:property value="#dataSourceNameVar" />
								</span>
							</caption>
							<s:set var="tableReportsVar" value="#dumpReportVar.dataSourcesReports[#dataSourceNameVar]" />
							<tr>
								<th>Table Name</th>
								<th>Rows</th>
								<th>Time</th>
							</tr>
							<s:iterator var="tableReportVar" value="#tableReportsVar">
								<tr>
									<td>
										<s:if test="#tableReportVar.rows == 0"><s:property value="#tableReportVar.tableName" /></s:if>
										<s:else>
												<a 
													title="Download: <s:property value="#dataSourceNameVar" />/<s:property value="#tableReportVar.tableName" />"
													href="<s:url namespace="/do/Admin/Database" action="extractTableDump" >
													<s:param name="tableName" value="#tableReportVar.tableName" />
													<s:param name="dataSourceName" value="#dataSourceNameVar" />
													<s:param name="subFolderName" value="#dumpReportVar.subFolderName" />
												</s:url>"><s:property value="#tableReportVar.tableName" /></a>
										</s:else>
									</td>
									<td class="rightText monospace">
										<s:property value="#tableReportVar.rows" />
									</td>
									<td class="rightText monospace">
										<s:property value="#tableReportVar.requiredTime" /> ms
									</td>
								</tr>
							</s:iterator>
						</table>
					</s:iterator>
				</div>
			</div>
			<s:form namespace="/do/Admin/Database" method="get" cssClass="margin-more-top">
				<p class="centerText">
					<wpsf:hidden name="subFolderName" value="%{#dumpReportVar.subFolderName}" />
					<wpsf:submit action="restoreIntro" value="Restore Backup" cssClass="button" />
				</p>
			</s:form>
		</s:else>
		<p>
			<a href="<s:url namespace="/do/Admin/Database" action="entry" />">Go to Backups list</a>
		</p>
	</s:else>
</div>
