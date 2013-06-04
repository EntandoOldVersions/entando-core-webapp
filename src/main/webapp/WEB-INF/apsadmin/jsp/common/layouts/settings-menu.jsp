<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<ul>
<wp:ifauthorized permission="superuser">
	<li><a href="<s:url action="intro" namespace="/do/User" />"><s:text name="menu.accountAdmin.users" /></a></li>
	<li><a href="<s:url action="intro" namespace="/do/Role" />"><s:text name="menu.accountAdmin.roles" /></a></li>
	<li><a href="<s:url action="list" namespace="/do/Lang" />"><s:text name="menu.languageAdmin.languages" /></a></li>
	<li><a href="<s:url action="intro" namespace="/do/LocaleString" />"><s:text name="menu.languageAdmin.labels" /></a></li>
</wp:ifauthorized>

<wp:ifauthorized permission="editContents">
	<li><a href="<s:url action="openIndexProspect" namespace="/do/jacms/Content/Admin" />"><s:text name="menu.reload.contents" /></a></li>
</wp:ifauthorized>

<wp:ifauthorized permission="superuser">
	<li><a href="<s:url namespace="/do/BaseAdmin" action="reloadConfig" />" id="menu_ricarica_configurazione"><s:text name="menu.reload.config" /></a></li>
	<li><a href="<s:url namespace="/do/Admin/Database" action="entry" />" id="menu_database_admin"><span lang="en">Database</span></a></li>
	<%--
	<li><a href="<s:url namespace="/do/Entity" action="viewManagers" />" id="menu_entita"><s:text name="menu.entityAdmin" /></a></li>
	--%>
</wp:ifauthorized>
</ul>