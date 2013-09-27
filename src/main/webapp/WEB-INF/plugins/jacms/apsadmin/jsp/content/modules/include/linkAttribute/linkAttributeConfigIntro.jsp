<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/jacms/Content"/>">
			<s:text name="jacms.menu.contentAdmin" />
		</a>
		&#32;/&#32;
		<s:if test="#thirdTitleVar==null">
			<s:text name="title.contentEditing" />
		</s:if>
		<s:else>
			<%--//TODO: we need a back to content link here --%>
			<s:text name="title.contentEditing" />
			&#32;/&#32;
			<s:property value="#thirdTitleVar" escapeXml="false" escapeHtml="false" />
		</s:else>
	</span>
</h1>
<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />