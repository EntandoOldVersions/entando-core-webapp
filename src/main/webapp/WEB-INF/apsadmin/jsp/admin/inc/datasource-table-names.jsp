<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="%{null != #tableMappingVar && !#tableMappingVar.isEmpty()}">
	<s:iterator var="dataSourceNameVar" value="#tableMappingVar.keySet()" >
		DATASOURCE <s:property value="#dataSourceNameVar" />
		<s:set var="tableNamesVar" value="%{getTableNames(#tableMappingVar[#dataSourceNameVar])}" />
		<s:if test="null != #tableNamesVar">
		<br />
		<s:iterator var="tableNameVar" value="#tableNamesVar" status="statusVar">
			<s:property value="#tableNameVar" /><s:if test="!#statusVar.last">, </s:if>
		</s:iterator>
		<br />
		</s:if>
		<s:else>NO TABLES for datasource <s:property value="#dataSourceNameVar" /></s:else>
	</s:iterator>
</s:if>
<s:else>NO TABLES for data backup</s:else>

