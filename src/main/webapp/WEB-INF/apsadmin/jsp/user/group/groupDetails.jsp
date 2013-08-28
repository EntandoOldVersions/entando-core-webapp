<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/Group"></s:url>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.groupManagement" />">
		<s:text name="title.groupManagement" />
		</a>
		&#32;/&#32;
		<s:text name="title.groupDetail" />
	</span>
</h1>

<div id="main">

<dl class="dl-horizontal">
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