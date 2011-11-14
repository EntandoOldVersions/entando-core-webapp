<%@ taglib prefix="s" uri="/struts-tags" %>

<s:set var="targetNS" value="%{'/do/Role'}" />
<h1><s:text name="title.roleManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.roleManagement.assignToUsers" />: <s:property value="authName" /></h2>

<s:include value="/WEB-INF/apsadmin/jsp/user/include_configAuthority.jsp" />

</div>