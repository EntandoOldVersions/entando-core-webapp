<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
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
<s:form action="delete">
	<p class="sr-only"><wpsf:hidden name="name"/></p>
	<div class="panel panel-default">
		<span class="panel-body display-block">
			<a
				href="<s:url action="list" />"
				title="<s:text name="note.groupConfirm.trash.goBack" />&#32;<s:text name="menu.accountAdmin.groups" />"
				>
					<span class="fa fa-reply"></span>
				</a>
				&#32;<s:text name="note.groupConfirm.trash" />&#32;
				<code><s:property value="name" /></code>
				?
		</span>
		<p class="panel-body display-block text-center">
				<wpsf:submit
					type="button"
					cssClass="btn btn-default">
					<s:text name="label.confirm" />
				</wpsf:submit>
		</p>
	</div>
</s:form>