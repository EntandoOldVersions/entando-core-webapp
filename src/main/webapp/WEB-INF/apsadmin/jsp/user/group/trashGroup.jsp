<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/Group"></s:url>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.groupManagement" />">
		<s:text name="title.groupManagement" />
		</a>
		&#32;/&#32;
		<s:text name="title.groupManagement.groupTrash" />
	</span>
</h1>

<div id="main">
 
<s:form action="delete">
	<p class="sr-only"><wpsf:hidden name="name"/></p>

	<p>
		<s:text name="note.groupConfirm.trash" />&#32;<em class="important"><s:property value="name" /></em>? 
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.remove')}" cssClass="button" />
	</p>

	<p>
		<s:text name="note.groupConfirm.trash.goBack" />&#32;<a href="<s:url action="list" namespace="/do/Group" />"><s:text name="menu.accountAdmin.groups" /></a>
	</p>

</s:form>

</div>