<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/jacms/Resource'}" />
<s:set var="targetParamName" value="%{'resourceTypeCode'}" />
<s:set var="targetParamValue" value="resourceTypeCode" />
<h1 class="panel panel-default title-page"><span class="panel-body display-block"><s:property value="%{getText('title.' + resourceTypeCode + 'Management')}" />
<s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></span></h1>

<div id="main">

<div class="intro resource<s:property value="resourceTypeCode" />">
<s:property escapeHtml="false" value="%{getText('note.' + resourceTypeCode + '.intro.html')}" />
</div>

</div>