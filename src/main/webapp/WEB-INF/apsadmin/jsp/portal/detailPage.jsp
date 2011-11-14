<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>

<div id="main">

<h2><s:text name="title.detailPage" /></h2>

<s:set var="breadcrumbs_pivotPageCode" value="selectedNode" />
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />

<div class="subsection-light">
<s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true"><s:param name="selectedNode" value="selectedNode"></s:param></s:action>
</div>

<wpsa:hookPoint key="core.detailPage" objectName="hookPointElements_core_detailPage">
<s:iterator value="#hookPointElements_core_detailPage" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>

</div>