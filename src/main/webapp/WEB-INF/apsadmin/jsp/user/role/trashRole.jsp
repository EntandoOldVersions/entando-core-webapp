<%@ taglib prefix="s" uri="/struts-tags" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<a href="<s:url namespace="/do/Role" action="list" />">
			<s:text name="title.roleManagement" />
		</a>
		&#32;/&#32;
		<s:text name="title.roleManagement.roleTrash" />
	</span>
</h1>
<s:form action="delete">
	<div class="panel panel-default">
			<div class="panel-body display-block">
				<s:hidden name="name"/>
				<a 
					title="<s:text name="note.roleConfirm.trash.goBack" />&#32;<s:text name="menu.accountAdmin.roles" />"
					href="<s:url action="list" namespace="/do/Role" />">
					<span class="icon icon-reply"></span>
					<span class="sr-only"><s:text name="note.roleConfirm.trash.goBack" />&#32;<s:text name="menu.accountAdmin.roles" /></span>
				</a>
				&#32;
				<s:text name="note.roleConfirm.trash" />&#32;
				<code><s:property value="name" /></code>&#32;
				?
				<div class="text-center margin-small-top">
					<s:submit type="button" cssClass="btn btn-default">
						<s:text name="label.remove" />
					</s:submit>
				</div>
			</div>
	</div>
</s:form>
