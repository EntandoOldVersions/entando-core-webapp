<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="viewTree" namespace="/do/Category" />" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.categoryManagement" />">
		<s:text name="title.categoryManagement" />
		</a>
		&#32;/&#32;
		<s:text name="title.categoryDetail" />
	</span>
</h1>

<div id="main">

<s:set var="breadcrumbs_pivotCategoryCode" value="categoryCode" />
<s:include value="/WEB-INF/apsadmin/jsp/category/include/categoryInfo_breadcrumbs.jsp" />

<dl class="dl-horizontal">
	<dt><s:text name="name.categoryCode" /></dt>
		<dd><s:property value="categoryCode" /></dd>
	<dt><s:text name="name.categoryTitle" /></dt>
		<dd>
<s:iterator value="langs" status="categoryInfo_rowStatus" var="lang">
		<s:if test="#categoryInfo_rowStatus.index != 0">, </s:if><span class="monospace">(<abbr title="<s:property value="descr" />"><s:property value="code" /></abbr>)</span> <s:property value="titles[#lang.code]" />
</s:iterator>
		</dd>
</dl>

<wpsa:hookPoint key="core.categoryDetails" objectName="hookPointElements_core_categoryDetails">
<s:iterator value="#hookPointElements_core_categoryDetails" var="hookPointElement">
	<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
</s:iterator>
</wpsa:hookPoint>


<s:include value="/WEB-INF/apsadmin/jsp/category/include/categoryInfo-references.jsp" />

</div>