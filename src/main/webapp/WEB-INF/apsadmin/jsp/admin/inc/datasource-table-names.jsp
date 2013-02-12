<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{null != #tableMappingVar && !#tableMappingVar.isEmpty()}">
	<s:iterator var="dataSourceNameVar" value="#tableMappingVar.keySet()" >
		<p>
			<strong>Datasource <s:property value="#dataSourceNameVar" /></strong>:
			<s:set var="tableNamesVar" value="%{getTableNames(#tableMappingVar[#dataSourceNameVar])}" />
			<s:if test="null != #tableNamesVar">
				<s:iterator var="tableNameVar" value="#tableNamesVar" status="statusVar">
					<em><s:property value="#tableNameVar" /></em>
					<s:if test="%{!(#statusVar.last)}">,&#32;</s:if>
				</s:iterator>
			</s:if>
			<s:else>
				<p>No table for backup.</p>
			</s:else>
		</p>
	</s:iterator>
</s:if>
<s:else>
	<p>
		No table for backup.
	</p>
</s:else>

