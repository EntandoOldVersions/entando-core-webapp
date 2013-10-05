<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<a href="<s:url namespace="/do/User" action="list" />"><s:text name="title.userManagement" /></a>
		&#32;/&#32;
		<s:text name="title.userManagement.userTrash" />
	</span>
</h1>
<s:form action="delete" namespace="/do/User">
	<p class="sr-only"><wpsf:hidden name="username"/></p>
	<div class="panel panel-default">
		<span class="panel-body display-block">
			<a
				href="<s:url action="list" namespace="/do/User" />"
				title="<s:text name="note.userConfirm.trash.goBack" />&#32;<s:text name="menu.accountAdmin.users" />">
				<span class="icon icon-reply"></span>
			</a>
			&#32;
			<s:text name="note.userConfirm.trash" />&#32;
			<code><s:property value="%{username}" /></code>&#32;
			?
		</span>
		<p class="panel-body display-block text-center">
				<s:submit
					type="button"
					cssClass="btn btn-default">
					<s:text name="label.confirm" />
				</s:submit>
		</p>
	</div>
</s:form>