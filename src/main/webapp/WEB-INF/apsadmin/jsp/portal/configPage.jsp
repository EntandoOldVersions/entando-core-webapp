<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><a href="<s:url action="viewTree" namespace="/do/Page" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.pageManagement" />"><s:text name="title.pageManagement" /></a></h1>

<div id="main">

<h2><s:text name="title.configPage" /></h2>

<s:set var="breadcrumbs_pivotPageCode" value="currentPage.code" />
<s:include value="/WEB-INF/apsadmin/jsp/portal/include/pageInfo_breadcrumbs.jsp" />
<div class="subsection-light">
<h3><s:text name="title.configPage.youAreDoing" /></h3>

<s:action namespace="/do/Page" name="printPageDetails" executeResult="true" ignoreContextParams="true"><s:param name="selectedNode" value="currentPage.code"></s:param></s:action>

<table class="generic" summary="<s:text name="note.page.pageConfig.summary" />">
<caption><span><s:text name="title.configPage" /></span></caption>
<tr>
	<th><abbr title="<s:text name="name.position" />">P</abbr></th>
	<th><s:text name="label.description" /></th>
	<th><s:text name="name.showlet" /></th>
	<th class="icon <wp:ifauthorized permission="superuser">tinyColumn90</wp:ifauthorized>"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>	
</tr>

<s:set var="showletTypeApiMappingsVar" value="showletTypeApiMappings" />

<s:iterator var="showlet" value="currentPage.showlets" status="rowstatus">
<s:set var="showletType" value="#showlet.getType()" ></s:set>
<tr>
	<td class="rightText">
		<s:if test="currentPage.getModel().getMainFrame() == #rowstatus.index"><img src="<wp:resourceURL/>administration/common/img/icons/16x16/emblem-important.png" alt="<s:text name="name.mainFrame" />: " title="<s:text name="name.mainFrame" />" /><s:property value="#rowstatus.index"/></s:if>
		<s:else><s:property value="#rowstatus.index"/></s:else>
	</td>
	<td>
		<a href="
		<s:url action="editFrame" namespace="/do/Page">
			<s:param name="pageCode"><s:property value="currentPage.code"/></s:param>
			<s:param name="frame"><s:property value="#rowstatus.index"/></s:param>
		</s:url>
		"><s:property value="currentPage.getModel().getFrames()[#rowstatus.index]"/></a>
	</td>
	<td>
		<s:if test="null != #showletType.code">
		<a class="noborder" href="<s:url namespace="/do/Portal/ShowletType" action="viewShowletUtilizers"><s:param name="showletTypeCode" value="{#showletType.getCode()}" /></s:url>" title="<s:text name="title.showletManagement.howmanypages.goToSee" />: <s:property value="%{getTitle(#showletType.getCode(), #showletType.getTitles())}" />"><img src="<wp:resourceURL />administration/common/img/icons/16x16/detail.png" alt=" " /></a>
		</s:if>
		<s:property value="%{getTitle(#showletType.getCode(), #showletType.getTitles())}" />
	</td>
	<td class="<wp:ifauthorized permission="superuser">tinyColumn90 rightText</wp:ifauthorized>">
		<wp:ifauthorized permission="superuser">
		<s:if test="!#showletType.isLogic() && null != #showletType.typeParameters && #showletType.typeParameters.size() > 0">
			<a href="<s:url namespace="/do/Portal/ShowletType" action="copy"><s:param name="pageCode" value="currentPage.code" /><s:param name="framePos" value="#rowstatus.index" /></s:url>" title="<s:text name="label.userShowlet.new.from" />: <s:property value="%{getTitle(#showletType.getCode(), #showletType.getTitles())}" />" class="noborder"><img src="<wp:resourceURL/>administration/common/img/icons/22x22/showlet-user-new.png" alt="<s:text name="label.userShowlet.new" />" /></a>
		</s:if>
		</wp:ifauthorized>
		<s:if test="null != #showletType.code">
		<wp:ifauthorized permission="superuser">
		<s:if test="!#showletType.isLogic()">
			<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#showletType.code]" />
		</s:if>
		<s:else>
			<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#showletType.parentType.code]" />
		</s:else>
		<s:if test="null != #relatedApiMethodVar">		
			<a href="
			<s:url action="copyFromShowlet" namespace="/do/Api/Service">
				<s:param name="pageCode" value="currentPage.code" />
				<s:param name="framePos" value="#rowstatus.index" />
				<s:param name="resourceName" value="#relatedApiMethodVar.resourceName" />
				<s:param name="namespace" value="#relatedApiMethodVar.namespace" />
			</s:url>
			" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#relatedApiMethodVar.methodName" />" class="noborder"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a>
		</s:if>
		<s:set var="relatedApiMethodVar" />
		</wp:ifauthorized>
		<a href="
		<s:url action="trashShowletFromPage" namespace="/do/Page">
			<s:param name="pageCode" value="currentPage.code" />
			<s:param name="frame" value="#rowstatus.index" />
			<s:param name="showletTypeCode" value="#showletType.code" />
		</s:url>
		" title="<s:text name="label.clear" />: <s:property value="%{getTitle(#showletType.code, #showletType.titles)}" />" class="noborder"><img src="<wp:resourceURL/>administration/common/img/icons/clear.png" alt="<s:text name="label.alt.clear" />" /></a>
		</s:if>
		<s:else>&#32;</s:else>
	</td>
</tr>
<s:set var="showletType" />
</s:iterator>
</table>

</div>
</div>