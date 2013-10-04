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
	<s:set var="resourceFlavoursVar" value="resourceFlavours" />
	<s:set var="serviceFlavoursVar" value="serviceFlavours" />

	<s:form action="newService" cssClass="margin-more-bottom">
		<p class="centerText margin-bit-top">
			<label for="service-list" class="basic-mint-label" style="width: 200px"><s:text name="label.api.service.createNew" />:</label>
			<select id="service-list" name="resourceCode" tabindex="<wpsa:counter />">
				<s:iterator value="#resourceFlavoursVar" var="resourceFlavourGroup">
					<optgroup label="<s:property value="%{getText(#resourceFlavourGroup.get(0).getSectionCode()+'.name')}" escapeHtml="false" />">
						<s:iterator value="#resourceFlavourGroup" var="resource">
							<option value="<s:property value="#resource.code" />">
								<s:property value="#resource.code" /> - <s:property value="#resource.description" />
							</option>
						</s:iterator>
					</optgroup>
				</s:iterator>
			</select>
			&#32;
			<wpsf:submit useTabindexAutoIncrement="true" cssClass="button" value="%{getText('api.button.create')}" action="newService" />
		</p>
	</s:form>

	<div class="subsection-light margin-more-top">
	<s:if test="#serviceFlavoursVar.size()>0">
		<s:iterator var="resourceFlavour" value="#resourceFlavoursVar" status="varStatus">
			<s:set var="serviceGroupVar" value="#resourceFlavour.get(0).getSectionCode()" />
			<s:set var="servicesByGroupVar" value="#serviceFlavoursVar[#serviceGroupVar]" />
				<s:if test="null != #servicesByGroupVar && #servicesByGroupVar.size() > 0">
					<p class="sr-only">
						<wpsf:hidden name="serviceGroup" value="%{#serviceGroupVar}" />
					</p>
						<table class="generic <s:property value="%{(!#varStatus.first) ? ' margin-more-bottom ' : ''}" />">
							<caption id="<s:property value="#serviceGroupVar" />"><span>
								<%-- <s:property value="#serviceGroupVar" /> --%>
								<s:text name="%{#serviceGroupVar}.name" />
							</span></caption>
							<tr>
								<th><s:text name="name.api.service" /></th>
								<th><s:text name="label.description" /></th>
								<th class="icon"><abbr title="<s:text name="label.active" />">A</abbr></th>
								<th class="icon"><abbr title="<s:text name="label.public" />">P</abbr></th>
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
									<td class="icon">
										<s:if test="#service.activeItem">
											<img
												title="<s:text name="label.active" />"
												alt="<s:text name="label.active" />"
												src="<wp:resourceURL />administration/common/img/icons/content-isonline.png" />
										</s:if>
										<s:else>
											<img
												title="<s:text name="label.api.notactive" />"
												alt="<s:text name="label.api.notactive" />"
												src="<wp:resourceURL />administration/common/img/icons/content-isnotonline.png" />
										</s:else>
									</td>
									<td class="icon">
										<s:if test="#service.publicItem">
											<img
												title="<s:text name="label.public" />"
												alt="<s:text name="label.public" />"
												src="<wp:resourceURL />administration/common/img/icons/content-isonline.png" />
										</s:if>
										<s:else>
											<img
												title="<s:text name="label.api.notpublic" />"
												alt="<s:text name="label.api.notpublic" />"
												src="<wp:resourceURL />administration/common/img/icons/content-isnotonline.png" />
										</s:else>
									</td>
									<td class="icon">
										<a href="<s:url action="trash"><s:param name="serviceKey"><s:property value="#service.key" /></s:param></s:url>" title="<s:text name="label.remove" />: <s:property value="#service.key" />"><img src="<wp:resourceURL />administration/common/img/icons/delete.png" alt="<s:text name="label.alt.clear" />" /></a>
									</td>
								</tr>
							</s:iterator>
						</table>
				</s:if>
		</s:iterator>
	</s:if>
	<s:else>
		<p><s:text name="note.api.noServices" /></p>
	</s:else>
	</div>
</div>