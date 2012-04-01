<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1><s:text name="title.apiResourceManagement" /></h1>

<s:if test="hasActionErrors()">
	<div class="message message_error">
		<h2><s:text name="message.title.ActionErrors" /></h2>
		<ul>
			<s:iterator value="actionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>
<s:set var="resourceFlavoursVar" value="resourceFlavours" />
<s:if test="#resourceFlavoursVar.size() > 0">
	<s:iterator var="resourceFlavourVar" value="#resourceFlavoursVar" status="resourceFlavourStatusVar">
		<table class="generic" summary="<s:text name="note.api.apiResourceList.summary" />">
			<s:iterator value="#resourceFlavourVar" var="resourceVar" status="statusVar" >
				<s:if test="#statusVar.first">
					<%-- if we're evaluating the first resource, setup the caption title and table headers --%>
					<s:if test="#resourceVar.source=='core'"><s:set var="captionVar"><s:property value="#resourceVar.source" escapeHtml="false" /></s:set></s:if>
					<s:else><s:set var="captionVar"><s:property value="%{getText(#resourceVar.sectionCode+'.name')}" escapeHtml="false" /></s:set></s:else>
					<caption><span title="<s:text name="label.flavour" />&#32;<s:property value="#captionVar" />"><s:property value="#captionVar" /></span></caption>
					<tr>
						<th><s:text name="name.api.resource" /></th>
						<th><s:text name="label.description" /></th>
						<th class="icon"><abbr title="GET">G</abbr></th>
						<th class="icon">POST</th>
						<th class="icon">PUT</th>
						<th class="icon"><abbr title="DELETE">D</abbr></th>
					</tr>
				</s:if>
				<tr>

					<%-- CODE and link to edit --%>
					<td class="monospace">
						<wp:action path="/ExtStr2/do/Front/Api/Resource/detail.action" var="detailActionURL" >
						<wp:parameter name="resourceName"><s:property value="#resourceVar.resourceName" /></wp:parameter>
						<wp:parameter name="namespace"><s:property value="#resourceVar.namespace" /></wp:parameter>
						</wp:action>
						<a title="<s:text name="label.edit" />: <s:property value="%{#resourceVar.namespace.length()>0?#resourceVar.namespace+'/':''}" /><s:property value="#resourceVar.resourceName" />" href="<c:out value="${detailActionURL}" escapeXml="false" />" ><s:property value="#resourceVar.resourceName" /></a>
					</td>
					<%-- DESCRIPTION --%>
					<td><s:property value="#resourceVar.description" /></td>
					<s:set var="icon_off"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<s:text name="api.resource.status.off" />" title="<s:text name="api.resource.status.off" />" /></s:set>
					<s:set var="icon_free"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ok.png" alt="<s:text name="api.resource.status.free" />" title="<s:text name="api.resource.status.free" />" /></s:set>
					<s:set var="icon_auth"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authentication.png" alt="<s:text name="api.resource.status.auth.alt" />" title="<s:text name="api.resource.status.auth" />" /></s:set>
					<s:set var="icon_lock"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authorization.png"  alt="<s:text name="api.resource.status.lock.alt" />" title="<s:text name="api.resource.status.lock" />" /></s:set>
					<%-- GET --%>
					<td class="icon">
						<s:if test="#resourceVar.getMethod != null && #resourceVar.getMethod.active" >
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#GET_tab">
								<s:if test="#resourceVar.getMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:if>
								<s:elseif test="#resourceVar.getMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
								<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
							</a>
						</s:if>
						<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
					</td>
					<%-- POST --%>
					<td class="icon">
						<s:if test="#resourceVar.postMethod != null && #resourceVar.postMethod.active" >
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#POST_tab">
								<s:if test="#resourceVar.postMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:if>
								<s:elseif test="#resourceVar.postMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
								<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
							</a>
						</s:if>
						<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
					</td>
					<%-- PUT --%>
					<td class="icon">
						<s:if test="#resourceVar.putMethod != null && #resourceVar.putMethod.active" >
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#PUT_tab">
								<s:if test="#resourceVar.putMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:if>
								<s:elseif test="#resourceVar.putMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
								<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
							</a>
						</s:if>
						<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
					</td>
					<%-- DELETE --%>
					<td class="icon">
						<s:if test="#resourceVar.deleteMethod != null && #resourceVar.deleteMethod.active" >
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />#DELETE_tab">
								<s:if test="#resourceVar.deleteMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:if>
								<s:elseif test="#resourceVar.deleteMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
								<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
							</a>
						</s:if>
						<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
					</td>
				</tr>
			</s:iterator>
		</table>
	</s:iterator>
</s:if>
<s:else>
	<p><s:text name="note.api.noResources" /></p>
</s:else>
