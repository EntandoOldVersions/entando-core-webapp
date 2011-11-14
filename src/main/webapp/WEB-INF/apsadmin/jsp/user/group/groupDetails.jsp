<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<s:set var="targetNS" value="%{'/do/Group'}" />
<h1><s:text name="title.groupManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.groupDetail" /></h2>

<dl class="table-display">
	<dt><s:text name="label.group" /></dt>
		<dd><s:property value="name" /></dd>
	<dt><s:text name="label.description" /></dt>
		<dd><s:property value="description" /></dd>
</dl>

<wpsa:hookPoint key="core.groupDetails" objectName="hookPointElements_core_groupDetails">
<s:iterator value="#hookPointElements_core_groupDetails" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

<s:include value="/WEB-INF/apsadmin/jsp/user/group/include/groupInfo-references.jsp" />

</div>