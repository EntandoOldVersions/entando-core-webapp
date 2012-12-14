<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<wp:headInfo type="CSS" info="showlets/api.css"/>
<div class="entando-api api-resource-list">
<h2><wp:i18n key="ENTANDO_API_SERVICES" /></h2>
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
<s:if test="hasFieldErrors()">
	<div class="message message_error">
		<h2><s:text name="message.title.FieldErrors" /></h2>
		<ul>
			<s:iterator value="fieldErrors">
				<s:iterator value="value">
				<li><s:property escape="false" /></li>
				</s:iterator>
			</s:iterator>
		</ul>
	</div>
</s:if>
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
<s:set var="resourceFlavoursVar" value="resourceFlavours" />
<s:set var="serviceFlavoursVar" value="serviceFlavours" />

<s:if test="#serviceFlavoursVar != null && #serviceFlavoursVar.size() > 0">
	<ul class="api-summary">
		<s:iterator var="resourceFlavour" value="#resourceFlavoursVar" status="statusVar">
			<s:set var="serviceGroupVar" value="#resourceFlavour.get(0).getSectionCode()" />
			<s:set var="servicesByGroupVar" value="#serviceFlavoursVar[#serviceGroupVar]" />
			<s:if test="null != #servicesByGroupVar && #servicesByGroupVar.size() > 0">
				<s:if test="#serviceGroupVar == 'core'"><s:set var="captionVar" value="%{#serviceGroupVar}" /></s:if>
				<s:else><s:set var="captionVar" value="%{getText(#serviceGroupVar + '.name')}" /></s:else>
				<li>
					<a href="#api-flavour-<s:property value='%{#captionVar.toLowerCase().replaceAll("[^a-z0-9-]", "")}' />"><s:property value='%{#captionVar}' /></a>
				</li>
			</s:if>
		</s:iterator>
	</ul>
</s:if>

<s:if test="%{#serviceFlavoursVar != null && #serviceFlavoursVar.size() > 0}">
	<s:set var="servicesEmptyVar" value="true" />
	<s:iterator var="resourceFlavour" value="#resourceFlavoursVar">
		<s:set var="serviceGroupVar" value="#resourceFlavour.get(0).getSectionCode()" />
		<s:set var="servicesByGroupVar" value="#serviceFlavoursVar[#serviceGroupVar]" />
		<s:if test="null != #servicesByGroupVar && #servicesByGroupVar.size() > 0">
			<s:set var="servicesEmptyVar" value="false" />
			<s:if test="#serviceGroupVar == 'core'"><s:set var="captionVar" value="%{#serviceGroupVar}" /></s:if>
			<s:else><s:set var="captionVar" value="%{getText(#serviceGroupVar + '.name')}" /></s:else>
			<table class="generic" summary="<wp:i18n key="ENTANDO_API_TABLE_SUMMARY" />">
				<caption id="api-flavour-<s:property value='%{#captionVar.toLowerCase().replaceAll("[^a-z0-9]", "")}' />">
					<s:property value="#captionVar" />
				</caption>
				<tr>
					<th><wp:i18n key="ENTANDO_API_SERVICE_KEY" /></th>
					<th><wp:i18n key="ENTANDO_API_SERVICE_DESCRIPTION" /></th>
				</tr>
				<s:iterator var="serviceVar" value="#servicesByGroupVar" >
					<tr>
						<td class="monospace">
							<wp:action path="/ExtStr2/do/Front/Api/Service/detail.action" var="detailActionURL">
								<wp:parameter name="serviceKey"><s:property value="#serviceVar.key" /></wp:parameter>
							</wp:action>
							<a href="<c:out value="${detailActionURL}" escapeXml="false" />"><s:property value="#serviceVar.key" /></a>
						</td>
						<td><s:property value="#serviceVar.value" /></td>
					</tr>
				</s:iterator>
			</table>
		</s:if>
	</s:iterator>
</s:if>
<s:else>
	<p><wp:i18n key="ENTANDO_API_NO_SERVICES" /></p>
</s:else>
	<p class="back">
		<a href="<wp:action path="/ExtStr2/do/Front/Api/Resource/list.action" />">
			<wp:i18n key="ENTANDO_API_GOTO_LIST" />
		</a>
	</p>
</div>