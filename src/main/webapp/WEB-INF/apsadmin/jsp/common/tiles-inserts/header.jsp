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

		<a class="navbar-brand" href="<s:url action="main" namespace="/do" />" title="<s:text name="note.goToMainPage" />">
			<img src="<wp:resourceURL/>administration/img/entando-logo.png" width="91" height="20" alt="Entando Enterprise Edition" />
		</a>

		<!-- Place everything within .navbar-collapse to hide it until above 768px -->
		<div class="nav-collapse collapse navbar-responsive-collapse">

			<p class="navbar-text pull-left text-center col-12 col-lg-3">
				<a class="navbar-link" href="http://www.entando.com/<s:property value="currentLang.code"/>/updates/" title="<s:text name="note.checkForUpdates" />">version <wp:info key="systemParam" paramName="version" /></a>
			</p>
			<p class="pull-right">
				<a class="btn btn-info navbar-btn" href="<s:url namespace="/do/BaseAdmin" action="configSystemParams" />" title="<s:text name="menu.configure" />"><span class="icon icon-cog"></span></a>
			</p>

			<ul class="nav navbar-nav pull-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle text-right" data-toggle="dropdown">
						<em><s:text name="note.userbar.welcome"/></em>&#32;
						<strong><c:out value="${sessionScope.currentUser}"/></strong>
						<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
					<c:if test="${sessionScope.currentUser.japsUser}">
						<li>
							<a href="<s:url action="editProfile" namespace="/do/CurrentUser" />">
								<span class="icon icon-lock"></span>&#32;
								<s:text name="note.changeYourPassword" />
							</a>
						</li>
					</c:if>
						<li>
							<a href="<s:url value="/" />" title="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )">
								<span class="icon icon-globe"></span>&#32;
								<s:text name="note.goToPortal" />
							</a>
						</li>
						<li class="divider"></li>
						<li>
							<a href="<s:url action="logout" namespace="/do" />">
								<span class="icon icon-off"></span>&#32;
								<s:text name="menu.exit" />
							</a>
						</li>
					</ul>
				</li>
			</ul>

		</div><!-- /.nav-collapse -->
	</div><!-- /.container -->
</div><!-- /.navbar -->
