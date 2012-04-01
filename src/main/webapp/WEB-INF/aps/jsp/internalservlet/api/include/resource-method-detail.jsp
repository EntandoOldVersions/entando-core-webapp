<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<dl class="table-display">
	<dt>
		<s:text name="label.api.resourceMethod" />
	</dt>
		<dd>
			<s:if test="#methodVar != null">
				<s:text name="label.api.resource.method.status.ok" />
			</s:if>
			<s:else>
				<s:text name="label.api.resource.method.status.ko" />
			</s:else>
		</dd>
	<s:if test="#methodVar != null">
		<dt>
			<s:text name="label.api.resource.method.description" />
		</dt>
			<dd><s:property value="#methodVar.description" /></dd>
			<dt>
				<s:text name="label.api.authorization" />
			</dt>
				<dd>
					<s:if test="%{null != #methodVar.requiredPermission}">
						<s:text name="label.method.authority.permission" />&#32;<s:property value="#methodVar.requiredPermission" />
					</s:if>
					<s:elseif test="%{#methodVar.requiredAuth}">
						<s:text name="label.method.authority.autenticationRequired" />
					</s:elseif>
					<s:else>
						<s:text name="label.none" />
					</s:else>
				</dd>
		<dt>
			<s:text name="label.api.resource.method.schemas" />
		</dt>
			<dd class="schemas">
				<s:if test='%{#methodVar.httpMethod.toString().equalsIgnoreCase("POST") || #methodVar.httpMethod.toString().equalsIgnoreCase("PUT")}'>
					<p class="schema-get">
						<wp:action path="/ExtStr2/do/Front/Api/Resource/requestSchema.action" var="requestSchemaURLVar" >
							<wp:parameter name="resourceName"><s:property value="#methodVar.resourceName" /></wp:parameter>
							<wp:parameter name="namespace"><s:property value="#methodVar.namespace" /></wp:parameter>
							<wp:parameter name="httpMethod"><s:property value="#methodVar.httpMethod" /></wp:parameter>
						</wp:action>
						<a title="" href="<c:out value="${requestSchemaURLVar}" escapeXml="false" />" >
							<s:text name="label.api.resource.method.schemas.req" />
						</a>
					</p>
				</s:if>
				<p class="schema-post">
					<wp:action path="/ExtStr2/do/Front/Api/Resource/responseSchema.action" var="responseSchemaURLVar" >
						<wp:parameter name="resourceName"><s:property value="#methodVar.resourceName" /></wp:parameter>
						<wp:parameter name="namespace"><s:property value="#methodVar.namespace" /></wp:parameter>
						<wp:parameter name="httpMethod"><s:property value="#methodVar.httpMethod" /></wp:parameter>
					</wp:action>
					<a title="" href="<c:out value="${responseSchemaURLVar}" escapeXml="false" />" >
						<s:text name="label.api.resource.method.schemas.resp" />
					</a>
				</p>
			</dd>
	</s:if>
</dl>

<s:if test="#methodVar != null">
	<s:set var="methodParametersVar" value="#methodVar.parameters" />
	<s:if test="null != #methodParametersVar && #methodParametersVar.size() > 0">
		<table class="generic" summary="<s:text name="label.api.resource.method.requestParameters.summary" />">
			<caption><span><s:text name="label.api.resource.method.requestParameters" /></span></caption>
			<tr>
				<th><s:text name="label.name" /></th>
				<th><s:text name="label.description" /></th>
				<th class="icon"><s:text name="label.required" /></th>
			</tr>
			<s:iterator value="#methodParametersVar" var="apiParameter" >
				<tr>
					<td class="monospace"><label for="<s:property value="%{#apiParameter.key + '_apiParam'}" />"><s:property value="#apiParameter.key" /></label></td>
					<td><s:property value="#apiParameter.description" /></td>
					<td class="icon"><img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#apiParameter.required" />.png" alt="<s:property value="#apiParameter.required" />" /></td>
				</tr>
			</s:iterator>
		</table>
	</s:if>
	<s:set name="selectFieldValue" />
</s:if>