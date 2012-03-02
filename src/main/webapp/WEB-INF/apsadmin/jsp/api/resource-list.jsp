<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><s:text name="title.apiResourceManagement" /></h1>
<div id="main">
	<s:if test="hasActionMessages()">
		<div class="message message_confirm">
			<h2><s:text name="messages.confirm" /></h2>
			<ul>
				<s:iterator value="actionMessages">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
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
		<table class="generic" summary="<s:text name="note.api.apiResourceList.summary" />">
			<caption><span><s:text name="title.api.apiResourcesList" /></span></caption>
			<tr>
				<th><s:text name="name.api.resource" /></th>
				<th><s:text name="label.description" /></th>
				<th><s:text name="label.flavour" /></th>
				<th class="icon"><abbr title="GET">G</abbr></th>
				<th class="icon">POST</th>
				<th class="icon">PUT</th>
				<th class="icon"><abbr title="DELETE">D</abbr></th>
			</tr>
			<s:iterator var="resourceFlavourVar" value="#resourceFlavoursVar">
				<s:iterator var="resourceVar" value="#resourceFlavourVar" >
					<tr>
						<td class="monospace">
							<s:url var="detailActionURL" action="detail" namespace="/do/Api/Resource"><s:param name="resourceName" value="#resourceVar.resourceName" /></s:url>
							<a href="<s:url action="detail" namespace="/do/Api/Resource"><s:param name="resourceName" value="#resourceVar.resourceName" /></s:url>" ><s:property value="#resourceVar.resourceName" /></a>
							<s:if test="#resourceVar.getMethod != null" >
								<s:if test="#resourceVar.getMethod.canSpawnOthers">&emsp;<a class="icon noborder" href="<s:url action="newService" namespace="/do/Api/Service"><s:param name="apiMethodName" value="#resourceVar.resourceName" /></s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#resourceVar.resourceName" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a></s:if>
							</s:if>
						</td>

						<td><s:property value="#resourceVar.description" /></td>

						<td class="monospace"><s:property value="#resourceVar.source" />&#32;/&#32;<s:property value="%{#resourceVar.sectionCode}" /></td>

						<s:set var="icon_off"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ko.png" alt="<s:text name="api.resource.status.off" />" title="<s:text name="api.resource.status.off" />" /></s:set>
						<s:set var="icon_free"><img src="<wp:resourceURL />administration/common/img/icons/generic-status-ok.png" alt="<s:text name="api.resource.status.free" />" title="<s:text name="api.resource.status.free" />" /></s:set>
						<s:set var="icon_auth"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authentication.png" alt="<s:text name="api.resource.status.auth.alt" />" title="<s:text name="api.resource.status.auth" />" /></s:set>
						<s:set var="icon_lock"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-authorization.png"  alt="<s:text name="api.resource.status.lock.alt" />" title="<s:text name="api.resource.status.lock" />" /></s:set>
						<%-- GET --%>
						<td class="icon">
							<s:if test="#resourceVar.getMethod != null" >
								<a href="<s:property value="#detailActionURL" escapeHtml="false" />#GET_tab">
									<s:if test="!#resourceVar.getMethod.active" ><s:property value="#icon_off" escapeHtml="false" /></s:if>
									<s:elseif test="#resourceVar.getMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:elseif>
									<s:elseif test="#resourceVar.getMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
									<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
								</a>
							</s:if>
							<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
						</td>
						<%-- POST --%>
						<td class="icon">
							<s:if test="#resourceVar.postMethod != null" >
								<a href="<s:property value="#detailActionURL" escapeHtml="false" />#POST_tab">
									<s:if test="!#resourceVar.postMethod.active" ><s:property value="#icon_off" escapeHtml="false" /></s:if>
									<s:elseif test="#resourceVar.postMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:elseif>
									<s:elseif test="#resourceVar.postMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
									<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
								</a>
							</s:if>
							<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
						</td>
						<%-- PUT --%>
						<td class="icon">
							<s:if test="#resourceVar.putMethod != null" >
								<a href="<s:property value="#detailActionURL" escapeHtml="false" />#PUT_tab">
									<s:if test="!#resourceVar.putMethod.active" ><s:property value="#icon_off" escapeHtml="false" /></s:if>
									<s:elseif test="#resourceVar.putMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:elseif>
									<s:elseif test="#resourceVar.putMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
									<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
								</a>
							</s:if>
							<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
						</td>
						<%-- DELETE --%>
						<td class="icon">
							<s:if test="#resourceVar.deleteMethod != null" >
								<a href="<s:property value="#detailActionURL" escapeHtml="false" />#DELETE_tab">
									<s:if test="!#resourceVar.deleteMethod.active" ><s:property value="#icon_off" escapeHtml="false" /></s:if>
									<s:elseif test="#resourceVar.deleteMethod.requiredPermission != null" ><s:property value="#icon_lock" escapeHtml="false" /></s:elseif>
									<s:elseif test="#resourceVar.deleteMethod.requiredAuth" ><s:property value="#icon_auth" escapeHtml="false" /></s:elseif>
									<s:else><s:property value="#icon_free" escapeHtml="false" /></s:else>
								</a>
							</s:if>
							<s:else><abbr title="<s:text name="api.resource.status.na" />">&ndash;</abbr></s:else>
						</td>
						<%--
						<td class="monospace">
							<wpsf:checkbox useTabindexAutoIncrement="true" id="%{#methodItemVar.key + '_active'}" name="%{#methodItemVar.key + '_active'}" value="%{#methodVar.active}" />
							<label for="<s:property value="%{#methodItemVar.key + '_active'}" />"><s:if test="#methodVar.active"><s:text name="label.yes" /></s:if><s:else><s:text name="label.no" /></s:else></label>
						</td>
						<td class="icon">
							<s:if test="#methodVar.canSpawnOthers"><a href="<s:url action="newService" namespace="/do/Api/Service"><s:param name="apiMethodName" value="#methodItemVar.key" /></s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#methodItemVar.key" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a></s:if>
							<s:else>&nbsp;</s:else>
							</td>
						</tr>
						--%>
					<tr>
				</s:iterator>
			</s:iterator>
		</table>
	</s:if>
	<s:else>
		<p><s:text name="note.api.noResources" /></p>
	</s:else>
</div>