<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<h1><a href="<s:url action="viewShowlets" namespace="/do/Portal/ShowletType" />" title="<s:text name="note.goToSomewhere" />: <s:text name="title.showletManagement" />"><s:text name="title.showletManagement" /></a></h1>

<div id="main">

<s:set var="showletTypeVar" value="getShowletType(showletTypeCode)"></s:set>

<h2 class="margin-more-bottom"><s:text name="title.showletManagement.pages" />: <s:property value="getTitle(#showletTypeVar.code, #showletTypeVar.titles)" /></h2>

<s:set var="showletTypeApiMappingsVar" value="showletTypeApiMappings" />
<s:set var="showletUtilizers" value="showletUtilizers"></s:set>
<s:if test="!#showletTypeVar.isLogic()">
<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#showletTypeVar.code]" />
</s:if>
<s:else>
<s:set var="relatedApiMethodVar" value="#showletTypeApiMappingsVar[#showletTypeVar.parentType.code]" />
<a href="<s:url action="newService" namespace="/do/Api/Service">
	<s:param name="showletTypeCode" value="showletTypeCode" />
	<s:param name="apiMethodName" value="#relatedApiMethodVar.methodName" />
</s:url>" title="** CREA SERVIZIO DA API : <s:property value="#relatedApiMethodVar.methodName" /> **">** API SERVICE <s:property value="#relatedApiMethodVar.methodName" /> FROM THIS LOGIC SHOWLET **</a>
</s:else>
<s:if test="#showletUtilizers != null && #showletUtilizers.size() > 0">

<s:form action="viewShowletUtilizers" >

<p class="noscreen">
	<wpsf:hidden name="showletTypeCode" />
</p>

<wpsa:subset source="#showletUtilizers" count="10" objectName="groupShowletUtilizers" advanced="true" offset="5">
<s:set name="group" value="#groupShowletUtilizers" />	
<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pagerInfo.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>

<table class="generic" summary="<s:text name="note.showletManagement.pages.summary" />">
<caption><span><s:text name="name.pages" /></span></caption>
<tr>
	<th><s:text name="title.pageActions" /></th>
	<th><s:text name="label.page" /></th>
	<th><s:text name="name.positions" /></th>
</tr>
<s:iterator var="singlePage">
<tr>
	<td class="icon_double">
	<s:if test="%{isUserAllowed(#singlePage)}">
		<a href="<s:url namespace="/do/Page" action="viewTree"><s:param name="selectedNode" value="#singlePage.code" /></s:url>"><img src="<wp:resourceURL />administration/common/img/icons/node-leaf.png" alt="<s:text name="note.goToSomewhere" />: <s:property value="%{#singlePage.getFullTitle(currentLang.code)}" />" title="<s:text name="note.goToSomewhere" />: <s:property value="%{#singlePage.getFullTitle(currentLang.code)}" />" /></a>
		<a href="<s:url namespace="/do/Page" action="configure"><s:param name="pageCode" value="#singlePage.code" /></s:url>"><img src="<wp:resourceURL />administration/common/img/icons/page-configure.png" alt="<s:text name="title.configPage" />: <s:property value="%{#singlePage.getFullTitle(currentLang.code)}" />" title="<s:text name="title.configPage" />: <s:property value="%{#singlePage.getFullTitle(currentLang.code)}" />" /></a>
	</s:if>
	<s:else><abbr title="<s:text name="label.none" />">&ndash;</abbr></s:else>
	</td>
	<td><s:property value="%{#singlePage.getFullTitle(currentLang.code)}" /></td>
	<td>
		<ul class="noBullet">
	<s:iterator value="#singlePage.showlets" id="showlet" status="rowstatus">
		<s:if test="#showlet != null && #showlet.type != null && #showlet.type.code.equals(showletTypeCode)">
			<li>
			<s:if test="null != #showlet.type.typeParameters && #showlet.type.typeParameters.size() > 0">
				<a href="<s:url namespace="/do/Portal/ShowletType" action="copy" ><s:param name="pageCode" value="#singlePage.code" /><s:param name="framePos" value="#rowstatus.index" /></s:url>" title="<s:text name="label.userShowlet.new" />" class="noborder"><img src="<wp:resourceURL/>administration/common/img/icons/16x16/showlet-user-new.png" alt="<s:text name="label.userShowlet.new" />" /></a>
			</s:if>
			<s:if test="%{isUserAllowed(#singlePage)}">
				<s:if test="null != #relatedApiMethodVar && !#showletTypeVar.isLogic()">
				<wp:ifauthorized permission="superuser">
				<a class="noborder" href="<s:url action="copyFromShowlet" namespace="/do/Api/Service">
						<s:param name="pageCode" value="#singlePage.code" />
						<s:param name="framePos" value="#rowstatus.index" />
						<s:param name="apiMethodName" value="#relatedApiMethodVar.methodName" />
					</s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#relatedApiMethodVar.methodName" />"><img src="<wp:resourceURL />administration/common/img/icons/16x16/api-service-new.png" alt="<s:text name="label.new" />" /></a>
				</wp:ifauthorized>
				</s:if>
				<a class="noborder" href="<s:url action="trashShowletFromPage" namespace="/do/Portal/ShowletType">
					<s:param name="pageCode"><s:property value="#singlePage.code"/></s:param>
					<s:param name="frame"><s:property value="#rowstatus.index"/></s:param>
					<s:param name="showletTypeCode"><s:property value="#showletTypeVar.code"/></s:param>
				</s:url>
				" title="<s:text name="label.clear" />: <s:property value="#rowstatus.index"/> &ndash; <s:property value="#singlePage.model.getFrames()[#rowstatus.index]"/>"><img src="<wp:resourceURL/>administration/common/img/icons/16x16/clear.png" alt="<s:text name="label.alt.clear" />" /></a>			
				&#32;<a href="<s:url action="editFrame" namespace="/do/Page"><s:param name="pageCode"><s:property value="#singlePage.code"/></s:param><s:param name="frame"><s:property value="#rowstatus.index"/></s:param></s:url>" title="<s:text name="title.editFrame" />: <s:property value="#rowstatus.index"/> &ndash; <s:property value="#singlePage.model.getFrames()[#rowstatus.index]"/>"><s:property value="#rowstatus.index"/> &ndash; <s:property value="#singlePage.model.getFrames()[#rowstatus.index]"/></a>
			</s:if>
			<s:else><s:property value="#rowstatus.index"/> &ndash; <s:property value="#singlePage.model.getFrames()[#rowstatus.index]"/></s:else>
			</li>
		</s:if>
	</s:iterator>
		</ul>
	</td>
</tr>
</s:iterator>
</table>

<div class="pager">
	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/pager_formBlock.jsp" />
</div>
</wpsa:subset>

</s:form>

</s:if>
<s:else>
<p><s:text name="note.showlet.noUse" /></p>
</s:else>

</div>