<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<s:set var="targetNS" value="%{'/do/jacms/ContentModel'}" />
<h1><s:text name="title.generalSettings.contentModels" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
<h2><s:text name="title.generalSettings.contentModels.remove" /></h2>

<div class="message message_error">
<h3><s:text name="message.title.ActionErrors" /></h3>
<p><s:text name="contentModel.reference"><s:param><s:property value="modelId" /></s:param></s:text>:</p>

<ul>
	<s:iterator id="contentId" value="referencedContentsOnPages">
		<li> 
			<s:if test="%{referencingPages[#contentId].size == 1}">
				<s:text name="contentModel.reference.page" />
			</s:if>
			<s:else>
				<s:text name="contentModel.reference.pages" />:
			</s:else>
			<s:iterator id="page" value="referencingPages[#contentId]">
			
			<s:set name="pageGroup" value="#page.group"></s:set>
			<wp:ifauthorized groupName="${pageGroup}">&#32;<a href="<s:url action="new" namespace="/do/Page"/>?selectedNode=<s:property value="#page.code" />&amp;action:configure=true"></wp:ifauthorized>
			<s:property value="#page.titles[currentLang.code]" />
			<wp:ifauthorized groupName="${pageGroup}"></a></wp:ifauthorized>
			<s:if test="%{referencingPages[#contentId].size > 1}">,</s:if>&#32;
			</s:iterator>
			<s:set name="content" value="%{getContentVo(#contentId)}"></s:set>
			<s:text name="contentModel.reference.by" />&#32;<s:property value="#content.id" /> &ndash; <s:property value="#content.descr" />
			
		</li>
	</s:iterator>
</ul>

<p><s:text name="contentModel.tip" />.</p>
</div>

</div>