<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

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
<s:if test="%{#serviceFlavoursVar != null && #serviceFlavoursVar.size() > 0}">
	<s:set var="servicesEmptyVar" value="true" />
	<s:iterator var="resourceFlavour" value="#resourceFlavoursVar" status="varStatus">
		<s:set var="serviceGroupVar" value="#resourceFlavour.get(0).getSectionCode()" />
		<s:set var="servicesByGroupVar" value="#serviceFlavoursVar[#serviceGroupVar]" />
		<s:if test="null != #servicesByGroupVar && #servicesByGroupVar.size() > 0">
			<s:set var="servicesEmptyVar" value="false" />
				<table class="generic">
					<caption id="<s:property value="#serviceGroupVar" />"><span>
						<s:text name="%{#serviceGroupVar}.name" />
					</span></caption>
					<tr>
						<th><s:text name="name.api.service" /></th>
						<th><s:text name="label.description" /></th>
					</tr>
					<s:iterator var="service" value="#servicesByGroupVar" >
						<tr>
							<td class="monospace">
								<wp:action path="/ExtStr2/do/Front/Api/Service/detail.action" var="detailActionURL">
									<wp:parameter name="serviceKey"><s:property value="#service.key" /></wp:parameter>
								</wp:action>
								<a title="<s:text name="label.detail" />: <s:property value="#service.key" />" 
								   href="<c:out value="${detailActionURL}" escapeXml="false" />"><s:property value="#service.key" /></a>
							</td>
							<td>
								<s:property value="#service.value" />
							</td>
						</tr>
					</s:iterator>
				</table>
		</s:if>
		<s:else>
			<p><s:text name="note.api.noServiceFromFlavour" />: <span class="monospace"><s:property value="#serviceGroupVar" /></span></p>
			<p><a href="<s:url action="list" namespace="/do/Api/Resource" />"><s:text name="note.goToSomewhere" />&#32;<s:text name="menu.apisAdmin.resources" /></a>&#32;<s:text name="note.api.noServices.createOne" /></p>
		</s:else>
	</s:iterator>
</s:if>
<s:else>
	<p><wp:i18n key="ENTANDO_API_NO_SERVICES" /></p>
	<a href="<wp:action path="/ExtStr2/do/Front/Api/Resource/list.action" />"><wp:i18n key="ENTANDO_API_GOTO_LIST" /></a>
</s:else>