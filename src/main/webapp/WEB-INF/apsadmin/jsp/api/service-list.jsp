<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1><s:text name="title.apiServiceManagement" /></h1>
<div id="main">
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
	<s:set var="methodFlavoursVar" value="methodFlavours" />
	<s:set var="serviceFlavoursVar" value="serviceFlavours" />
	<s:if test="%{#methodFlavoursVar!=null}">
		<s:set var="servicesEmptyVar" value="true" />
		<s:iterator var="methodFlavour" value="#methodFlavoursVar" status="varStatus">
			<s:set var="serviceGroupVar" value="#methodFlavour.get(0).optgroup" />
			<s:set var="servicesByGroupVar" value="#serviceFlavoursVar[#serviceGroupVar]" />
			<s:if test="null != #servicesByGroupVar && #servicesByGroupVar.size() > 0">
				<s:set var="servicesEmptyVar" value="false" />
				<s:form action="updateAllStatusOfGroup" cssClass="%{(!#varStatus.first) ? 'margin-more-bottom' : ''}">
					<p class="noscreen">
						<wpsf:hidden name="serviceGroup" value="%{#serviceGroupVar}" />
					</p>
					<table class="generic">
						<caption id="<s:property value="#serviceGroupVar" />"><span>
							<%-- <s:property value="#serviceGroupVar" /> --%>
							<s:text name="%{#serviceGroupVar}.name" />
						</span></caption>
						<tr>
							<th><s:text name="name.api.service" /></th>
							<th><s:text name="label.description" /></th>
							<th><s:text name="label.active" /></th>
							<th><s:text name="label.public" /></th>
							<th class="icon"><abbr title="<s:text name="label.remove" />">&ndash;</abbr></th>
						</tr>
						<s:iterator var="service" value="#servicesByGroupVar" >
							<tr>
								<td class="monospace">
									<wpsf:hidden name="%{#service.key + '_checkField'}" value="true" />
									<a title="<s:text name="label.edit" />: <s:property value="#service.key" />" href="<s:url action="edit"><s:param name="serviceKey"><s:property value="#service.key" /></s:param></s:url>"><s:property value="#service.key" /></a>
							 	</td>
								<td>
							 		<s:property value="#service.value" />
							 	</td>
								<td class="monospace">
									<wpsf:checkbox useTabindexAutoIncrement="true" id="%{#service.key + '_active'}" name="%{#service.key + '_active'}" value="%{#service.activeItem}" />
									<label for="<s:property value="%{#service.key + '_active'}" />"><s:if test="#service.activeItem"><s:text name="label.yes" /></s:if><s:else><s:text name="label.no" /></s:else></label>
								</td>
								<td class="monospace">
									<wpsf:checkbox useTabindexAutoIncrement="true" id="%{#service.key + '_public'}" name="%{#service.key + '_public'}" value="%{#service.publicItem}" />
									<label for="<s:property value="%{#service.key + '_public'}" />"><s:if test="#service.publicItem"><s:text name="label.yes" /></s:if><s:else><s:text name="label.no" /></s:else></label>
								</td>
								<td class="icon">
									<a href="<s:url action="trash"><s:param name="serviceKey"><s:property value="#service.key" /></s:param></s:url>" title="<s:text name="label.remove" />: <s:property value="#service.key" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a>
								</td>
							</tr>
						</s:iterator>
					</table>
					<p class="centerText">
						<wpsf:submit useTabindexAutoIncrement="true" cssClass="button" value="%{getText('label.api.service.update') + ' ' + getText(#serviceGroupVar+ '.name')}" />
					</p>
				</s:form>
			</s:if>
			<s:else>
				<%--
				<p><s:text name="note.api.noServiceFromFlavour" />: <span class="monospace"><s:property value="#serviceGroupVar" /></span></p>
				<p><a href="<s:url action="list" namespace="/do/Api/Method" />"><s:text name="note.goToSomewhere" /> <s:text name="menu.apisAdmin.methods" /></a> <s:text name="note.api.noServiceFromFlavour.createOne" />.</p>
				--%>
			</s:else>
		</s:iterator>
	</s:if>
	<s:else>
		<p><s:text name="note.api.noServices" /></p>
		<p><a href="<s:url action="list" namespace="/do/Api/Resource" />"><s:text name="note.goToSomewhere" />&#32;<s:text name="menu.apisAdmin.resources" /></a> <s:text name="note.api.noServices.createOne" /></p>
	</s:else>
</div>