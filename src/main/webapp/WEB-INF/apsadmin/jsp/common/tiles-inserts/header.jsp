<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<div class="navbar navbar-fixed-top navbar-inverse">
	<div class="container">

		<!-- .navbar-toggle is used as the toggle for collapsed navbar content -->
		<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>

		<!-- Be sure to leave the brand out there if you want it shown -->

		<a class="navbar-brand">
			<img src="<wp:resourceURL/>administration/img/entando-logo.png" width="91" height="20" alt="Entando Enterprise Edition" />
		</a>

		<!-- Place everything within .navbar-collapse to hide it until above 768px -->
		<div class="nav-collapse collapse navbar-responsive-collapse">

			<p class="navbar-text pull-left col-12 col-lg-3">
				<a class="navbar-link" href="http://www.entando.com/<s:property value="currentLang.code"/>/updates/" title="<s:text name="note.checkForUpdates" />">version <wp:info key="systemParam" paramName="version" /></a>
			</p>

			<ul class="nav navbar-nav pull-right col-2">
				<li>
					<a href="<s:url action="main" namespace="/do" />" title="<s:text name="note.goToMainPage" />"><span class="glyphicon glyphicon-home"></span></a>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">bla bla admin <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="#">Action</a></li>
						<li><a href="#">Another action</a></li>
						<li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li><a href="#">Separated link</a></li>
					</ul>
				</li>
			</ul>

		</div><!-- /.nav-collapse -->
	</div><!-- /.container -->
</div><!-- /.navbar -->


<div id="header-2">
<p>
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
