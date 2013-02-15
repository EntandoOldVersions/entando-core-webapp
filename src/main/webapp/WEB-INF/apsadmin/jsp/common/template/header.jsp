<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
<%--

<ul class="menu accordion_element">
	<li><a href="<s:url action="main" namespace="/do" />"><img src="<wp:resourceURL/>administration/img/icons/32x32/go-first.png" alt="<s:text name="note.goToMain" />" title="<s:text name="note.goToMain" />" /></a></li>
	<li class="noscreen"><a href="#manage"><s:text name="note.goToManageMenu" /></a></li>
	<li class="noscreen"><a href="#fagiano_mainContent"><s:text name="note.skipToMainContent" /></a></li>
	<c:if test="${sessionScope.currentUser.japsUser}">
	<li><a href="<s:url action="editPassword" namespace="/do/CurrentUser" />"><img src="<wp:resourceURL/>administration/img/icons/32x32/security.png" alt="<s:text name="note.changeYourPassword" />" title="<s:text name="note.changeYourPassword" />" /></a></li></c:if>
	<li><a href="<s:url value="/" />"><img src="<wp:resourceURL/>administration/img/icons/32x32/go-home.png" alt="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )" title="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )" /></a></li>
	<li><a href="<s:url action="logout" namespace="/do" />"><img src="<wp:resourceURL/>administration/img/icons/32x32/system-log-out.png" alt="<s:text name="menu.exit"/>" title="<s:text name="menu.exit"/>" /></a></li>
</ul>

 --%>
 
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
	<li><a id="userbar-myprofile" href="<s:url action="editPassword" namespace="/do/CurrentUser" />"><s:text name="note.changeYourPassword" /></a></li></c:if>
	<li><a id="userbar-portal" href="<s:url value="/" />" title="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )"><s:text name="note.goToPortal" /></a></li>
	<li><a id="userbar-signout" href="<s:url action="logout" namespace="/do" />"><s:text name="menu.exit" /></a></li>
</ul>

<s:if test="#myClient == 'advanced'"> 
</div>
</s:if>

</div>