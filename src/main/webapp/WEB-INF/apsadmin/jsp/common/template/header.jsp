<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<div id="header-1">
	<a href="<s:url action="main" namespace="/do" />" class="noborder outlineNone" title="<s:text name="note.goToMainPage" />"><img src="<wp:resourceURL/>administration/common/img/menu-button-round.png" width="51" height="49" alt="<s:text name="note.goToMainPage" />" /></a>
</div>

<div id="header-2">
<p>
	<a class="noborder" href="http://www.entando.com/<s:property value="currentLang.code"/>/updates/" title="<s:text name="note.checkForUpdates" />">
		<img src="<wp:resourceURL/>administration/common/img/entando-logo.png" width="97" height="60" alt="Entando" /> <span class="monospace version">version <wp:info key="systemParam" paramName="version" /></span>
	</a>
	<a href="<s:url namespace="/do/BaseAdmin" action="configSystemParams" />" style="display: inline-block; background-color: #5bb75b; text-transform: uppercase; float: right; padding: 8px; line-height: 1; margin: 26px 28px 0 0; border-bottom: none;">** <s:text name="menu.configure" /> **</a>
</p>
</div>

<div id="header-3">
<h2 class="noscreen"><s:text name="note.superMenu" /></h2>
<div class="accordion_toggler-menu">
<p class="welcome"><span>
	<em><s:text name="note.userbar.welcome"/></em><s:if test="#myClient == 'normal'">,</s:if>&#32;
	<strong><c:out value="${sessionScope.currentUser}"/></strong>!
	</span>
</p><s:if test="#myClient == 'advanced'"><span id="welcome-cap">&nbsp;</span></s:if>
</div>

<s:if test="#myClient == 'normal'">
<ul class="menu accordion_element-menu">
</s:if>

<s:if test="#myClient == 'advanced'">
<div class="accordion_element-menu">
<ul class="menu">
</s:if>

	<li><a id="userbar-start" href="<s:url action="main" namespace="/do" />"><s:text name="note.goToMain" /></a></li>
	<li class="noscreen"><a href="#manage"><s:text name="note.goToManageMenu" /></a></li>
	<li class="noscreen"><a href="#fagiano_mainContent"><s:text name="note.skipToMainContent" /></a></li>
	<c:if test="${sessionScope.currentUser.japsUser}">
	<li><a id="userbar-myprofile" href="<s:url action="editProfile" namespace="/do/CurrentUser" />"><s:text name="note.changeYourPassword" /></a></li></c:if>
	<li><a id="userbar-portal" href="<s:url value="/" />" title="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )"><s:text name="note.goToPortal" /></a></li>
	<li><a id="userbar-signout" href="<s:url action="logout" namespace="/do" />"><s:text name="menu.exit" /></a></li>
</ul>

<s:if test="#myClient == 'advanced'">
</div>
</s:if>

</div>