<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<h1><s:text name="title.apiMethodManagement" /></h1>
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

	<s:set var="methodFlavoursVar" value="methodFlavours" />
		<s:if test="#methodFlavoursVar.size() > 0">
			<s:form action="updateAllStatus">
				<table class="generic" summary="<s:text name="note.api.apiMethodList.summary" />">
					<caption><span><s:text name="title.api.apiMethodList" /></span></caption>
					<tr>
						<th><s:text name="name.api.method" /></th>
						<th><s:text name="label.description" /></th>
						<th><s:text name="label.flavour" /></th>
						<th><s:text name="label.active" /></th>
						<th class="icon"><abbr title="<s:text name="label.actions" />">&ndash;</abbr></th>						
					</tr>
					<s:iterator var="methodFlavour" value="#methodFlavoursVar">
						<s:iterator var="methodItemVar" value="#methodFlavour" >
							<s:set var="methodVar" value="%{getMethod(#methodItemVar.key)}" /> 
							<tr>
								<td class="monospace">
									<wpsf:hidden name="%{#methodItemVar.key + '_checkField'}" value="true" />
									<s:property value="#methodItemVar.key" />
								</td>
								<td>
									<s:property value="#methodItemVar.value" />
								</td>
								<td class="monospace">
									<s:if test="#methodVar.canSpawnOthers"><a href="<s:url action="list" namespace="/do/Api/Service" anchor="%{#methodItemVar.optgroup}" />" title="<s:text name="note.api.viewServicesFromMethod" />: <s:property value="#methodItemVar.optgroup" />"><s:property value="#methodVar.source" />/<s:property value="#methodItemVar.optgroup" /></a></s:if>
									<s:else><s:property value="#methodVar.source" />/<s:property value="#methodItemVar.optgroup" /></s:else>
								</td>
								<td class="monospace">
									<wpsf:checkbox useTabindexAutoIncrement="true" id="%{#methodItemVar.key + '_active'}" name="%{#methodItemVar.key + '_active'}" value="%{#methodVar.active}" />
									<label for="<s:property value="%{#methodItemVar.key + '_active'}" />"><s:if test="#methodVar.active"><s:text name="label.yes" /></s:if><s:else><s:text name="label.no" /></s:else></label>
								</td>
								<td class="icon">
									<s:if test="#methodVar.canSpawnOthers"><a href="<s:url action="newService" namespace="/do/Api/Service"><s:param name="apiMethodName" value="#methodItemVar.key" /></s:url>" title="<s:text name="note.api.apiMethodList.createServiceFromMethod" />: <s:property value="#methodItemVar.key" />"><img src="<wp:resourceURL />administration/common/img/icons/22x22/api-service-new.png" alt="<s:text name="label.new" />" /></a></s:if>
									<s:else>&nbsp;</s:else>
								</td>
							</tr>
						</s:iterator>
					</s:iterator>
				</table>
				<p class="centerText">
					<wpsf:submit useTabindexAutoIncrement="true" cssClass="button" value="%{getText('label.refresh')}" />
				</p>
			</s:form>
		</s:if>
	<s:else>
		<p><s:text name="note.api.noMethods" /></p>
	</s:else>
</div>