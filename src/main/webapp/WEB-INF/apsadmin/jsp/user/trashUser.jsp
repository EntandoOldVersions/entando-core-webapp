<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/User'}" />
<h1><s:text name="title.userManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.userManagement.userTrash" /></h2>
 
<s:form action="delete" namespace="/do/User" >
	<p class="noscreen"><wpsf:hidden name="username"/></p>
	
	<p>
		<s:text name="note.userConfirm.trash" />&#32;<em class="important"><s:property value="username" /></em>?
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>
	
	<p><s:text name="note.userConfirm.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/User" />"><s:text name="menu.accountAdmin.users" /></a></p>
</s:form>

</div>