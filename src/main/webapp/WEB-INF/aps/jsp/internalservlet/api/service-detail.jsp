<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<s:set var="apiServiceVar" value="%{getApiService(serviceKey)}" />

<h2><wp:i18n key="ENTANDO_API_SERVICE" />&#32;<s:property value="serviceKey" /></h2>
<s:if test="hasActionMessages()">
	<div class="message message_confirm">
		<h3><wp:i18n key="ENTANDO_API_ERROR" /></h3>
		<ul>
			<s:iterator value="actionMessages">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>
<s:if test="hasActionErrors()">
	<div class="message message_error">
		<h3><wp:i18n key="ENTANDO_API_ERROR" /></h3>
		<ul>
			<s:iterator value="actionErrors">
				<li><s:property escape="false" /></li>
			</s:iterator>
		</ul>
	</div>
</s:if>

<!-- DESCRIPTION -->
<p><s:property value="getTitle(serviceKey, #apiServiceVar.description)" /></p>

<p>
	<s:set var="masterMethodVar" value="#apiServiceVar.master" />
	<wp:i18n key="ENTANDO_API_SERVICE_PARENT_API" />: <em><s:property value="#masterMethodVar.description" />&#32;(/<s:if test="#masterMethodVar.namespace!=null && #masterMethodVar.namespace.length()>0"><s:property value="#masterMethodVar.namespace" />/</s:if><s:property value="#masterMethodVar.resourceName" />)</em>
</p>

<!-- INFO -->
<dl class="api-info">
	<dt><wp:i18n key="ENTANDO_API_SERVICE_KEY" /></dt>
		<dd><s:property value="serviceKey" /></dd>
	<dt>
		<wp:i18n key="ENTANDO_API_SERVICE_AUTHORIZATION" />
	</dt>
		<dd>
			<s:if test="%{!#apiServiceVar.requiredAuth}" >
				<wp:i18n key="ENTANDO_API_SERVICE_AUTH_FREE" />
			</s:if>
			<s:elseif test="%{null == #apiServiceVar.requiredPermission && null == #apiServiceVar.requiredGroup}">
				<wp:i18n key="ENTANDO_API_SERVICE_AUTH_SIMPLE" />
			</s:elseif>
			<s:else>
				<s:set var="serviceAuthGroupVar" value="%{getGroup(#apiServiceVar.requiredGroup)}" />
				<s:set var="serviceAuthPermissionVar" value="%{getPermission(#apiServiceVar.requiredPermission)}" />
				<s:if test="%{null != #serviceAuthPermissionVar}">
					<wp:i18n key="ENTANDO_API_SERVICE_AUTH_WITH_PERM" />&#32;<s:property value="#serviceAuthPermissionVar.description" />
				</s:if>
				<s:if test="%{null != #serviceAuthGroupVar}">
					<s:if test="%{null != #serviceAuthPermissionVar}"><br /></s:if>
					<wp:i18n key="ENTANDO_API_SERVICE_AUTH_WITH_GROUP" />&#32;<s:property value="#serviceAuthGroupVar.descr" />
				</s:if>
			</s:else>
		</dd>
	<dt><wp:i18n key="ENTANDO_API_SERVICE_URI" /></dt>
		<dd>
			<a href="<wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="currentLang" />/getService?key=<s:property value="serviceKey" />"><wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="currentLang" />/getService?key=<s:property value="serviceKey" /></a>
		</dd>
	<dt>
		<wp:i18n key="ENTANDO_API_EXTENSION" />
	</dt>
		<dd>
			<wp:i18n key="ENTANDO_API_EXTENSION_NOTE" />
		</dd>
	<dt>
		<wp:i18n key="ENTANDO_API_SERVICE_SCHEMAS" />
	</dt>
		<dd class="schemas">
			<wp:action path="/ExtStr2/do/Front/Api/Service/responseSchema.action" var="responseSchemaURLVar" >
				<wp:parameter name="serviceKey"><s:property value="serviceKey" /></wp:parameter>
			</wp:action>
			<a href="<c:out value="${responseSchemaURLVar}" escapeXml="false" />" >
				<wp:i18n key="ENTANDO_API_SERVICE_SCHEMA_RESP" />
			</a>
		</dd>
</dl>
<%--
<fieldset>
	<legend><s:text name="label.info" /></legend>
	<p>
		<label for="<s:property value="serviceKey" />" class="basic-mint-label"><s:text name="name.api.service" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="serviceKey" name="serviceKey" disabled="%{strutsAction == 2}" cssClass="text" />
	</p>
	<s:iterator value="systemLangs">
		<p>
			<label for="lang_<s:property value="code"/>" class="basic-mint-label"><span class="monospace">(<s:property value="code" />)</span>&#32;<s:text name="label.description" />:</label>
			<wpsf:textfield useTabindexAutoIncrement="true" id="%{'lang_'+code}" name="%{'lang_'+code}" value="%{descriptions[code]}" cssClass="text" />
		</p>
	</s:iterator>
	<ul class="noBullet">
		<li><wpsf:checkbox useTabindexAutoIncrement="true" name="activeService" id="activeService" cssClass="radiocheck" /><label for="activeService"><s:text name="label.active" /></label></li>
		<li><wpsf:checkbox useTabindexAutoIncrement="true" name="publicService" id="publicService" cssClass="radiocheck" /><label for="publicService"><s:text name="label.public" /></label></li>
		<li><wpsf:checkbox useTabindexAutoIncrement="true" name="myEntandoService" id="myEntandoService" cssClass="radiocheck" /><label for="myEntandoService"><s:text name="label.myEntando.compatible" /></label></li>
	</ul>
	<p>
		<label for="tag" class="basic-mint-label"><s:text name="label.tag" />:</label>
		<wpsf:textfield useTabindexAutoIncrement="true" id="tag" name="tag" cssClass="text" />
	</p>
</fieldset>
--%>
<%--
<fieldset>
	<legend><s:text name="label.api.authorities" /></legend>
	<ul class="noBullet">
		<li><wpsf:checkbox useTabindexAutoIncrement="true" name="requiredAuth" id="requiredAuth" cssClass="radiocheck" /><label for="requiredAuth"><s:text name="label.api.authority.autenticationRequired" /></label></li>
	</ul>
	<p>
		<label class="basic-mint-label" for="requiredPermission"><s:text name="label.api.authority.permission" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" headerKey="" headerValue="%{getText('label.none')}" name="requiredPermission" list="permissionAutorityOptions" listKey="key" listValue="value" id="requiredPermission" />
	</p>
	<p>
		<label class="basic-mint-label" for="requiredGroup"><s:text name="label.api.authority.group" />:</label>
		<wpsf:select useTabindexAutoIncrement="true" headerKey="" headerValue="%{getText('label.none')}" name="requiredGroup" list="groups" listKey="name" listValue="descr" id="requiredPermission" />
	</p>
</fieldset>
--%>

<s:if test="%{null != #apiServiceVar.freeParameters}" >
<table class="generic" summary="<wp:i18n key="ENTANDO_API_SERVICE_PARAMETERS_SUMMARY" />">
	<caption><span><wp:i18n key="ENTANDO_API_SERVICE_PARAMETERS" /></span></caption>
	<tr>
		<th><wp:i18n key="ENTANDO_API_SERVICE_PARAM_NAME" /></th>
		<th><wp:i18n key="ENTANDO_API_SERVICE_PARAM_DESCRIPTION" /></th>
		<th class="icon"><wp:i18n key="ENTANDO_API_SERVICE_PARAM_REQUIRED" /></th>
		<th><wp:i18n key="ENTANDO_API_SERVICE_PARAM_DEFAULT_VALUE" /></th>
	</tr>
	<s:iterator value="#apiServiceVar.freeParameters" var="apiParameterNameVar" >
		<s:set var="apiParameterValueVar" value="%{#apiServiceVar.parameters[#apiParameterNameVar]}" />
		<s:set var="apiParameterVar" value="%{#apiServiceVar.master.getParameter(#apiParameterNameVar)}" />
		<s:set var="apiParameterRequiredVar" value="%{#apiParameterVar.required && null == #apiParameterValueVar}" />
		<tr>
			<td class="monospace"><label for="<s:property value="#apiParameterNameVar" />"><s:property value="#apiParameterNameVar" /></label></td>
			<td><s:property value="%{#apiParameterVar.description}" /></td>
			<td class="icon">
				<img src="<wp:resourceURL />administration/common/img/icons/<s:property value="#apiParameterRequiredVar" />.png" alt="<s:property value="#apiParameterRequiredVar" />" />
			</td>
			<td><s:if test="null != #apiParameterValueVar"><s:property value="#apiParameterValueVar" /></s:if><s:else>-</s:else></td>
		</tr>
	</s:iterator>
</table>
</s:if>
<p class="api-back">
	<a href="<wp:action path="/ExtStr2/do/Front/Api/Resource/list.action" />"><wp:i18n key="ENTANDO_API_GOTO_LIST" /></a>
</p>
