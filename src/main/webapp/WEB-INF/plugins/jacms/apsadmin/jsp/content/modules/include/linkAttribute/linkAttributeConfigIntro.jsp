<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="jacms" uri="/jacms-apsadmin-core" %>

<s:set var="targetNS" value="%{'/do/jacms/Content'}" />
<h1><s:text name="jacms.menu.contentAdmin" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
<h2><s:text name="title.contentEditing" /></h2>

<s:include value="/WEB-INF/plugins/jacms/apsadmin/jsp/content/include/snippet-content.jsp" />



