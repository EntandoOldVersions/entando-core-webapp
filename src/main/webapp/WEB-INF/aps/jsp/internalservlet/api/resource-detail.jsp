<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<s:set var="apiResourceVar" value="apiResource" />
<s:set var="GETMethodVar" value="#apiResourceVar.getMethod" />
<s:set var="POSTMethodVar" value="#apiResourceVar.postMethod" />
<s:set var="PUTMethodVar" value="#apiResourceVar.putMethod" />
<s:set var="DELETEMethodVar" value="#apiResourceVar.deleteMethod" />
<s:set var="apiNameVar" value="(#apiResourceVar.namespace!=null && #apiResourceVar.namespace.length()>0 ? '/' + #apiResourceVar.namespace : '')+'/'+#apiResourceVar.resourceName" />
<h2><wp:i18n key="ENTANDO_API_RESOURCE" />&#32;<s:property value="#apiNameVar" /></h2>
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
<p><s:property value="#apiResourceVar.description" /></p>

<s:if test='%{#apiResourceVar.resourceName.equalsIgnoreCase("getService") || #apiResourceVar.resourceName.equalsIgnoreCase("getServices")}' >
<a href="<wp:action path="/ExtStr2/do/Front/Api/Service/list.action" />"><wp:i18n key="ENTANDO_API_GOTO_SERVICE_LIST" /></a>
</s:if>

<!-- INFO -->
<dl class="table-display">
	<dt><wp:i18n key="ENTANDO_API_RESOURCE_NAME" /></dt>
		<dd><s:property value="#apiResourceVar.resourceName" /></dd>
	<dt><span lang="en"><wp:i18n key="ENTANDO_API_RESOURCE_NAMESPACE" /></span></dt>
		<dd>/<s:property value="#apiResourceVar.namespace" /></dd>
	<dt><wp:i18n key="ENTANDO_API_RESOURCE_SOURCE" /></dt>
		<dd>
			<s:property value="#apiResourceVar.source" /><s:if test="%{#apiResourceVar.pluginCode != null && #apiResourceVar.pluginCode.length() > 0}">,&#32;<s:property value="%{getText(#apiResourceVar.pluginCode+'.name')}" />&#32;(<s:property value="%{#apiResourceVar.pluginCode}" />)</s:if>
		</dd>
	<dt><wp:i18n key="ENTANDO_API_RESOURCE_URI" /></dt>
		<dd>
			<a href="<wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="currentLang" /><s:if test="null != #apiResourceVar.namespace">/<s:property value="#apiResourceVar.namespace" /></s:if>/<s:property value="#apiResourceVar.resourceName" />"><wp:info key="systemParam" paramName="applicationBaseURL" />api/rs/<wp:info key="currentLang" /><s:if test="null != #apiResourceVar.namespace">/<s:property value="#apiResourceVar.namespace" /></s:if>/<s:property value="#apiResourceVar.resourceName" /></a>
		</dd>
	<dt>
		<wp:i18n key="ENTANDO_API_EXTENSION" />
	</dt>
		<dd>
			<wp:i18n key="ENTANDO_API_EXTENSION_NOTE" />
		</dd>
</dl>
<%-- GET --%>
	<s:set var="methodVar" value="#GETMethodVar" />
	<s:set var="currentMethodNameVar" value="%{'GET'}" />
	<h3 id="api_method_GET">GET</h3>
	<s:include value="/WEB-INF/aps/jsp/internalservlet/api/include/resource-method-detail.jsp" />
<%-- POST --%>
	<s:set var="methodVar" value="#POSTMethodVar" />
	<s:set var="currentMethodNameVar" value="%{'POST'}" />
	<h3 id="api_method_POST">POST</h3>
	<s:include value="/WEB-INF/aps/jsp/internalservlet/api/include/resource-method-detail.jsp" />
<%-- PUT --%>
	<s:set var="methodVar" value="#PUTMethodVar" />
	<s:set var="currentMethodNameVar" value="%{'PUT'}" />
	<h3 id="api_method_PUT">PUT</h3>
	<s:include value="/WEB-INF/aps/jsp/internalservlet/api/include/resource-method-detail.jsp" />
<%-- DELETE --%>
	<s:set var="methodVar" value="#DELETEMethodVar" />
	<s:set var="currentMethodNameVar" value="%{'DELETE'}" />
	<h3 id="api_method_DELETE">DELETE</h3>
	<s:include value="/WEB-INF/aps/jsp/internalservlet/api/include/resource-method-detail.jsp" />
<p>
	<a href="<wp:action path="/ExtStr2/do/Front/Api/Resource/list.action" />"><wp:i18n key="ENTANDO_API_GOTO_LIST" /></a>
</p>