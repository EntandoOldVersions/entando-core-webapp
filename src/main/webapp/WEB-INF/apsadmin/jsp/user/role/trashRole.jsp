<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/Role'}" />
<h1><s:text name="title.roleManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.roleManagement.roleTrash" /></h2>

<s:form action="delete">
	<p class="sr-only"><wpsf:hidden name="name"/></p>
	
	<p> 
		<s:text name="note.roleConfirm.trash" />&#32;<em class="important"><s:property value="name" /></em>? 
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>

	<p><s:text name="note.roleConfirm.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Role" />"><s:text name="menu.accountAdmin.roles" /></a></p>
</s:form>

</div>