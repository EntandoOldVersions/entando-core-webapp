<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
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
						<s:url action="requestSchema" namespace="/do/Front/Api/Resource" var="requestSchemaURLVar">
							<s:param name="resourceName" value="#methodVar.resourceName" />
							<s:param name="namespace" value="#methodVar.namespace" />
							<s:param name="httpMethod" value="#methodVar.httpMethod" />
						</s:url>
						<a title="<s:property value="#requestSchemaURL" escapeHtml="false" />" href="<s:property value="#requestSchemaURLVar" escapeHtml="false" />" >
							<s:text name="label.api.resource.method.schemas.req" />
						</a>
					</p>
				</s:if>
				<p class="schema-post">
					<s:url action="responseSchema" namespace="/do/Front/Api/Resource" var="responseSchemaURLVar">
						<s:param name="resourceName" value="#methodVar.resourceName" />
						<s:param name="namespace" value="#methodVar.namespace" />
						<s:param name="httpMethod" value="#methodVar.httpMethod" />
					</s:url>
					<a title="<s:property value="#responseSchemaURL" escapeHtml="false" />" href="<s:property value="#responseSchemaURLVar" escapeHtml="false" />" >
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

