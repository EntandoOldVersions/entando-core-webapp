<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<dl class="table-display">
	<dt>
		Status
	</dt>
		<dd>
			<s:if test="#methodVar != null">
				Available
			</s:if>
			<s:else>
				Not Available
			</s:else>
		</dd>
	<s:if test="#methodVar != null">
		<dt>
			Description
		</dt>
			<dd><s:property value="#methodVar.description" /></dd>
		<dt>
			Requires Authentication
		</dt>
			<dd><s:property value="#methodVar.requiredAuth || (null != #methodVar.requiredPermission)" /> (DEFAULT <s:property value="#methodVar.defaultRequiredAuth || (null != #methodVar.defaultRequiredPermission)" />)</dd>
		<s:if test="null != #methodVar.requiredPermission" >
		<dt>
			Requires Authorization
		</dt>
			<dd><s:property value="#methodVar.requiredPermission" /> (DEFAULT <s:property value="#methodVar.defaultRequiredPermission" />)</dd>
		</s:if>

		<dt>
			Schemas
		</dt>
			<dd class="schemas">
				<s:if test='%{!#methodVar.httpMethod.toString().equalsIgnoreCase("GET")}'>
					<p class="schema-get">
						<s:url action="requestSchema" namespace="/do/Api/Resource" var="requestSchemaURL">
							<s:param name="resourceName" value="#methodVar.resourceName" />
							<s:param name="httpMethod" value="#methodVar.httpMethod" />
						</s:url>
						<a title="<s:property value="#requestSchemaURL" escapeHtml="false" />" href="<s:property value="#requestSchemaURL" escapeHtml="false" />" >
							Request
						</a>
					</p>
				</s:if>
				<%--
					<s:else>
						<abbr title="Request Schema not available">&ndash;</abbr>
					</s:else>
				--%>
				<p class="schema-post">
					<s:url action="responseSchema" namespace="/do/Api/Resource" var="responseSchema">
						<s:param name="resourceName" value="#methodVar.resourceName" />
						<s:param name="httpMethod" value="#methodVar.httpMethod" />
					</s:url>
					<a title="<s:property value="#responseSchemaURL" escapeHtml="false" />" href="<s:property value="#responseSchemaURL" escapeHtml="false" />" >
						Response
					</a>
				</p>
			</dd>
	</s:if>
</dl>

<s:if test="#methodVar != null">
	<s:set var="methodParametersVar" value="#methodVar.parameters" />
	<s:if test="null != #methodParametersVar && #methodParametersVar.size() > 0">
		<table class="generic" summary="<s:text name="note.api.apiMethodParameters.summary" />">
			<caption><span><s:text name="label.requestParameters" /></span></caption>
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
					<label for="active_<s:property value="%{#methodVar.httpMethod}" />">Active</label>
				</p>
				<p>
					<label class="basic-mint-label" for="methodAuthority_<s:property value="%{#methodVar.httpMethod}" />">Authorization:</label>
					<s:select name="%{#methodVar.httpMethod}_methodAuthority" list="methodAuthorityOptions" listKey="key" listValue="value" value="%{selectFieldValue}" id="methodAuthority_%{#methodVar.httpMethod}" />
				</p>
				<p class="centerText">
					<wpsf:submit action="updateMethodStatus" useTabindexAutoIncrement="true" value="%{getText('Update')}" cssClass="button" />
					&#32;
					<wpsf:submit action="resetMethodStatus" useTabindexAutoIncrement="true" value="%{getText('Reset to Default')}" cssClass="button" />
				</p>
			</fieldset>
		</form>
	</div>
	<s:set name="selectFieldValue" />
</s:if>

