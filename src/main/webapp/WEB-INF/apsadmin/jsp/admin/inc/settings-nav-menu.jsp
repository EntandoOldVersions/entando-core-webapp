<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
	<a href="<s:url namespace="/do/BaseAdmin" action="configSystemParams" />" class="btn btn-default btn-block text-left <s:if test="%{#settingsNavMenuActiveItem=='configSystemParams'}"> disabled</s:if>">
			<span class="icon icon-cogs"></span>&#32;
			<s:text name="menu.settings.general" />
	</a>

	<wp:ifauthorized permission="superuser">
			<a href="<s:url action="intro" namespace="/do/User" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-user"></span>&#32;
					<s:text name="menu.accountAdmin.users" />
			</a>

			<a href="<s:url action="intro" namespace="/do/Role" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-group"></span>&#32; 
					<s:text name="menu.accountAdmin.roles" />
			</a>

			<a href="<s:url action="list" namespace="/do/Lang" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-globe"></span>&#32;
					<s:text name="menu.languageAdmin.languages" />
			</a>

			<a href="<s:url action="intro" namespace="/do/LocaleString" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-th-list"></span>&#32;
					<s:text name="menu.languageAdmin.labels" />
			</a>
	</wp:ifauthorized>


	<wp:ifauthorized permission="editContents">
			<a href="<s:url action="openIndexProspect" namespace="/do/jacms/Content/Admin" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-rotate-left"></span>&#32;
					<s:text name="menu.reload.contents" />
			</a>
	</wp:ifauthorized>
	
	<wp:ifauthorized permission="superuser">
			<a href="<s:url namespace="/do/BaseAdmin" action="reloadConfig" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-refresh"></span>&#32;
					<s:text name="menu.reload.config" />
			</a>

			<a href="<s:url namespace="/do/Admin/Database" action="entry" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-archive"></span>&#32;
					<s:text name="menu.settings.database" />
			</a>
		<%--
			<a href="<s:url namespace="/do/Entity" action="viewManagers" />" class="btn btn-default btn-block text-left">
					<span class="icon icon-cog"></span>&#32;
					<s:text name="menu.entityAdmin" />
			</a>
		--%>
	</wp:ifauthorized>
	
