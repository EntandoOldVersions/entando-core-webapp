<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h2><wp:i18n key="ENTANDO_API_RESOURCES" /></h2>
<s:if test="hasActionErrors()">
	<div class="message message_error">
		<h3><wp:i18n key="ENTANDO_API_ERROR" /></h3>
		<ul>
			<s:iterator value="actionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>
<s:set var="resourceFlavoursVar" value="resourceFlavours" />
<s:if test="#resourceFlavoursVar!=null && #resourceFlavoursVar.size()> 0">
	<ul>
		<s:iterator value="#resourceFlavoursVar" var="resGroupVar">
			<s:iterator var="resourceVar" value="#resGroupVar" status="statusVar" >
				<s:if test="#statusVar.first">
					<s:if test="#resourceVar.source=='core'"><s:set var="captionVar" value="#resourceVar.source" /></s:if>
					<s:else><s:set var="captionVar" value="%{getText(#resourceVar.sectionCode+'.name')}" /></s:else>
					<li>
						<a href="#api-flavour-<s:property value='%{#captionVar.toLowerCase().replaceAll("[^a-z0-9-]", "")}' />"><s:property value='%{#captionVar}' /></a>
					</li>
				</s:if>
			</s:iterator>
		</s:iterator>
	</ul>
</s:if>
<s:if test="#resourceFlavoursVar.size() > 0">
	<s:set var="icon_off"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<wp:i18n key="ENTANDO_API_METHOD_STATUS_OFF" />" /></s:set>
	<s:set var="title_off"><wp:i18n key="ENTANDO_API_METHOD_STATUS_OFF" />. <wp:i18n key="ENTANDO_API_GOTO_DETAILS" /></s:set>
	<s:set var="icon_free"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ok.png" alt="<wp:i18n key="ENTANDO_API_METHOD_STATUS_FREE" />" /></s:set>
	<s:set var="title_free"><wp:i18n key="ENTANDO_API_METHOD_STATUS_FREE" />. <wp:i18n key="ENTANDO_API_GOTO_DETAILS" /></s:set>
	<s:set var="icon_auth"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authentication.png" alt="<wp:i18n key="ENTANDO_API_METHOD_STATUS_AUTH" />" /></s:set>
	<s:set var="title_auth"><wp:i18n key="ENTANDO_API_METHOD_STATUS_AUTH" />. <wp:i18n key="ENTANDO_API_GOTO_DETAILS" /></s:set>
	<s:set var="icon_lock"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authorization.png"  alt="<wp:i18n key="ENTANDO_API_METHOD_STATUS_LOCK" />" /></s:set>
	<s:set var="title_lock"><wp:i18n key="ENTANDO_API_METHOD_STATUS_LOCK" />. <wp:i18n key="ENTANDO_API_GOTO_DETAILS" /></s:set>
	<s:iterator var="resourceFlavourVar" value="#resourceFlavoursVar" status="resourceFlavourStatusVar">
		<table class="generic" summary="<wp:i18n key="ENTANDO_API_TABLE_SUMMARY" />">
			<s:iterator value="#resourceFlavourVar" var="resourceVar" status="statusVar" >
				<s:if test="#statusVar.first">
					<%-- if we're evaluating the first resource, setup the caption title and table headers --%>
					<s:if test="#resourceVar.source=='core'"><s:set var="captionVar"><s:property value="#resourceVar.source" escapeHtml="false" /></s:set></s:if>
					<s:else><s:set var="captionVar"><s:property value="%{getText(#resourceVar.sectionCode+'.name')}" escapeHtml="false" /></s:set></s:else>
					<caption id="api-flavour-<s:property value='%{#captionVar.toLowerCase().replaceAll("[^a-z0-9]", "")}' />">
						<s:property value="#captionVar" />
					</caption>
					<tr>
						<th><wp:i18n key="ENTANDO_API_RESOURCE" /></th>
						<th><wp:i18n key="ENTANDO_API_DESCRIPTION" /></th>
						<th>GET</th>
						<th>POST</th>
						<th>PUT</th>
						<th>DELETE</th>
					</tr>
				</s:if>
				<tr>
					<%-- CODE and link to edit --%>
					<td>
						<wp:action path="/ExtStr2/do/Front/Api/Resource/detail.action" var="detailActionURL">
							<wp:parameter name="resourceName"><s:property value="#resourceVar.resourceName" /></wp:parameter>
							<wp:parameter name="namespace"><s:property value="#resourceVar.namespace" /></wp:parameter>
						</wp:action>
						<a title="<wp:i18n key="ENTANDO_API_GOTO_DETAILS" />:&#32;/<s:property value="%{#resourceVar.namespace.length()>0?#resourceVar.namespace+'/':''}" /><s:property value="#resourceVar.resourceName" />" href="<c:out value="${detailActionURL}" escapeXml="false" />" ><s:property value="#resourceVar.resourceName" /></a>
					</td>
					<%-- DESCRIPTION --%>
					<td><s:property value="#resourceVar.description" /></td>
					<%-- GET --%>
					<td class="icon">
						<s:if test="#resourceVar.getMethod != null && #resourceVar.getMethod.active" >
							<s:if test="#resourceVar.getMethod.requiredPermission != null" ><s:set var="icon" value="#icon_lock" /><s:set var="title" value="#title_lock" /></s:if>
							<s:elseif test="#resourceVar.getMethod.requiredAuth" ><s:set var="icon" value="#icon_auth" /><s:set var="title" value="#title_auth" /></s:elseif>
							<s:else><s:set var="icon" value="#icon_free" /><s:set var="title" value="#title_free" /></s:else>
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#api_method_GET" title="<s:property value="#title" />">
								<s:property value="#icon" escapeHtml="false" />
							</a>
						</s:if>
						<s:else><abbr title="<wp:i18n key="ENTANDO_API_METHOD_STATUS_NA" />">&ndash;</abbr></s:else>
					</td>
					<%-- POST --%>
					<td class="icon">
						<s:if test="#resourceVar.postMethod != null && #resourceVar.postMethod.active" >
							<s:if test="#resourceVar.postMethod.requiredPermission != null" ><s:set var="icon" value="#icon_lock" /><s:set var="title" value="#title_lock" /></s:if>
							<s:elseif test="#resourceVar.postMethod.requiredAuth" ><s:set var="icon" value="#icon_auth" /><s:set var="title" value="#title_auth" /></s:elseif>
							<s:else><s:set var="icon" value="#icon_free" /><s:set var="title" value="#title_free" /></s:else>
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#api_method_POST" title="<s:property value="#title" />">
								<s:property value="#icon" escapeHtml="false" />
							</a>
						</s:if>
						<s:else><abbr title="<wp:i18n key="ENTANDO_API_METHOD_STATUS_NA" />">&ndash;</abbr></s:else>
					</td>
					<%-- PUT --%>
					<td class="icon">
						<s:if test="#resourceVar.putMethod != null && #resourceVar.putMethod.active" >
							<s:if test="#resourceVar.putMethod.requiredPermission != null" ><s:set var="icon" value="#icon_lock" /><s:set var="title" value="#title_lock" /></s:if>
							<s:elseif test="#resourceVar.putMethod.requiredAuth" ><s:set var="icon" value="#icon_auth" /><s:set var="title" value="#title_auth" /></s:elseif>
							<s:else><s:set var="icon" value="#icon_free" /><s:set var="title" value="#title_free" /></s:else>
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#api_method_PUT" title="<s:property value="#title" />">
								<s:property value="#icon" escapeHtml="false" />
							</a>
						</s:if>
						<s:else><abbr title="<wp:i18n key="ENTANDO_API_METHOD_STATUS_NA" />">&ndash;</abbr></s:else>
					</td>
					<%-- DELETE --%>
					<td class="icon">
						<s:if test="#resourceVar.deleteMethod != null && #resourceVar.deleteMethod.active" >
							<s:if test="#resourceVar.deleteMethod.requiredPermission != null" ><s:set var="icon" value="#icon_lock" /><s:set var="title" value="#title_lock" /></s:if>
							<s:elseif test="#resourceVar.deleteMethod.requiredAuth" ><s:set var="icon" value="#icon_auth" /><s:set var="title" value="#title_auth" /></s:elseif>
							<s:else><s:set var="icon" value="#icon_free" /><s:set var="title" value="#title_free" /></s:else>
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#api_method_DELETE" title="<s:property value="#title" />">
								<s:property value="#icon" escapeHtml="false" />
							</a>
						</s:if>
						<s:else><abbr title="<wp:i18n key="ENTANDO_API_METHOD_STATUS_NA" />">&ndash;</abbr></s:else>
					</td>
				</tr>
			</s:iterator>
		</table>
	</s:iterator>
</s:if>
<s:else>
	<p><wp:i18n key="ENTANDO_API_NO_RESOURCES" /></p>
</s:else>