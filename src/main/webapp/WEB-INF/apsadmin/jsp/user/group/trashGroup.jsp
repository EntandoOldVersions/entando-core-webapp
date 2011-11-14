<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set var="targetNS" value="%{'/do/Group'}" />
<h1><s:text name="title.groupManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>

<div id="main">

<h2><s:text name="title.groupManagement.groupTrash" /></h2>
 
<s:form action="delete">
	<p class="noscreen"><wpsf:hidden name="name"/></p>

	<p>
		<s:text name="note.groupConfirm.trash" />&#32;<em class="important"><s:property value="name" /></em>? 
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>

	<p>
		<s:text name="note.groupConfirm.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Group" />"><s:text name="menu.accountAdmin.groups" /></a>
	</p>

</s:form>

</div>