<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<s:set var="activeItem"><c:out value="${param.activeItem}" /></s:set>
<ul class="nav nav-pills nav-stacked">
	<li <s:if test="%{#activeItem=='configSystemParams'}">class="active"</s:if> >
		<a href="<s:url namespace="/do/BaseAdmin" action="configSystemParams" />" title="<s:text name="menu.settings.general.keywords" />">
			<span class="icon icon-cogs"></span>&#32;
			<s:text name="menu.settings.general" />
		</a>
	</li>

	<wp:ifauthorized permission="superuser">
			<li>
				<a href="<s:url action="intro" namespace="/do/User" />" classs="btn btn-default btn-block text-left" title="<s:text name="menu.accountAdmin.users.keyworkds" />">
					<span class="icon icon-user"></span>&#32;
					<s:text name="menu.accountAdmin.users" />
				</a>
			</li>

			<li>
				<a href="<s:url action="intro" namespace="/do/Role" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-group"></span>&#32; 
					<s:text name="menu.accountAdmin.roles" />
				</a>
			</li>

			<li>
				<a href="<s:url action="list" namespace="/do/Lang" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-globe"></span>&#32;
					<s:text name="menu.languageAdmin.languages" />
				</a>
			</li>

			<li>
				<a href="<s:url action="intro" namespace="/do/LocaleString" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-th-list"></span>&#32;
					<s:text name="menu.languageAdmin.labels" />
				</a>
			</li>
	</wp:ifauthorized>


	<wp:ifauthorized permission="editContents">
			<li>
				<a href="<s:url action="openIndexProspect" namespace="/do/jacms/Content/Admin" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-rotate-left"></span>&#32;
						<s:text name="menu.reload.contents" />
				</a>
			</li>
	</wp:ifauthorized>
	
	<wp:ifauthorized permission="superuser">
			<li>
				<a href="<s:url namespace="/do/BaseAdmin" action="reloadConfig" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-refresh"></span>&#32;
						<s:text name="menu.reload.config" />
				</a>
			</li>

			<li>
				<a href="<s:url namespace="/do/Admin/Database" action="entry" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-archive"></span>&#32;
					<s:text name="menu.settings.database" />
				</a>
			</li>
		<%--
			<li>
				<a href="<s:url namespace="/do/Entity" action="viewManagers" />" classs="btn btn-default btn-block text-left">
					<span class="icon icon-cog"></span>&#32;
					<s:text name="menu.entityAdmin" />
				</a>
			</li>
		--%>
	</wp:ifauthorized>
	
