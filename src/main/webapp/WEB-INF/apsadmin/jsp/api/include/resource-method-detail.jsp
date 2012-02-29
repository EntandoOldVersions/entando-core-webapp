<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<dl class="table-display">
	<dt>
		<s:text name="label.api.resource.method.status" />
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
			<s:text name="label.api.resource.method.required.authentication" />
		</dt>
			<dd><s:property value="#methodVar.requiredAuth || (null != #methodVar.requiredPermission)" /> (<s:text name="label.default" />&#32;<s:property value="#methodVar.defaultRequiredAuth || (null != #methodVar.defaultRequiredPermission)" />)</dd>
		<s:if test="null != #methodVar.requiredPermission" >
		<dt>
			<s:text name="label.api.resource.method.required." />
			<s:text name="label.api.resource.method.required.authorization" />
		</dt>
			<dd><s:property value="#methodVar.requiredPermission" /> (<s:text name="label.default" />&#32;<s:property value="#methodVar.defaultRequiredPermission" />)</dd>
		</s:if>

		<dt>
			<s:text name="label.api.resource.method.schemas" />
		</dt>
			<dd class="schemas">
				<s:if test='%{#methodVar.httpMethod.toString().equalsIgnoreCase("POST") || #methodVar.httpMethod.toString().equalsIgnoreCase("PUT")}'>
					<p class="schema-get">
						<s:url action="requestSchema" namespace="/do/Api/Resource" var="requestSchemaURLVar">
							<s:param name="resourceName" value="#methodVar.resourceName" />
							<s:param name="httpMethod" value="#methodVar.httpMethod" />
						</s:url>
						<a title="<s:property value="#requestSchemaURL" escapeHtml="false" />" href="<s:property value="#requestSchemaURLVar" escapeHtml="false" />" >
							<s:text name="label.api.resource.method.schemas.req" />
						</a>
					</p>
				</s:if>
				<p class="schema-post">
					<s:url action="responseSchema" namespace="/do/Api/Resource" var="responseSchemaURLVar">
						<s:param name="resourceName" value="#methodVar.resourceName" />
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

	<div class="subsection margin-more-top">
		<s:if test="null != #methodVar.requiredPermission" ><s:set name="selectFieldValue" value="#methodVar.requiredPermission" /></s:if>
		<s:elseif test="#methodVar.requiredAuth"><s:set name="selectFieldValue">0</s:set></s:elseif>

		<s:url namespace="/do/Api/Resource" action="updateMethodStatus" var="updateMethodStatusURL" />
		<form action="<s:url namespace="/do/Api/Resource" action="updateMethodStatus" />#<s:property value="#methodVar.httpMethod" />_tab" >
			<fieldset>
				<legend><s:text name="label.options" /></legend>
				<p>
					<s:set name="activeFieldValue" value="#methodVar.active" />
					<wpsf:hidden name="resourceName" value="%{#methodVar.resourceName}" />
					<wpsf:hidden name="httpMethod" value="%{#methodVar.httpMethod}" />
					<wpsf:checkbox name="%{#methodVar.httpMethod}_active" value="%{#activeFieldValue}" cssClass="radiocheck" id="active_%{#methodVar.httpMethod}"/>
					&#32;
					<label for="active_<s:property value="%{#methodVar.httpMethod}" />"><s:text name="label.active" /></label>
				</p>
				<p>
					<label class="basic-mint-label" for="methodAuthority_<s:property value="%{#methodVar.httpMethod}" />"><s:text name="label.api.authorization" />:</label>
					<s:select name="%{#methodVar.httpMethod}_methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" value="%{selectFieldValue}" id="methodAuthority_%{#methodVar.httpMethod}" />
				</p>
				<p class="centerText">
					<wpsf:submit action="updateMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.update')}" cssClass="button" />
					&#32;
					<wpsf:submit action="resetMethodStatus" useTabindexAutoIncrement="true" value="%{getText('label.reset.default')}" cssClass="button" />
				</p>
			</fieldset>
		</form>
	</div>
	<s:set name="selectFieldValue" />
</s:if>

