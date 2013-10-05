<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<!DOCTYPE html>
<html lang="<s:property value="currentLang.code" />">
<head>

	<title>Entando - <s:set name="documentTitle"><tiles:getAsString name="title"/></s:set><s:property value="%{getText(#documentTitle)}" escape="false" /></title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<meta charset="utf-8" />

	<link rel="stylesheet" href="<wp:resourceURL />administration/bootstrap/css/bootstrap.min.css" media="screen" />
	<link rel="stylesheet" href="<wp:resourceURL />administration/css/bootstrap-override.css" media="screen" />
	<link rel="stylesheet" href="<wp:resourceURL />administration/css/bootstrap-offcanvas.css" media="screen" />
	<link rel="stylesheet" href="<wp:resourceURL />administration/css/bootstrap-addendum.css" media="screen" />
	<c:catch>
		<tiles:insertAttribute name="cssSpecial" />
	</c:catch>

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
	<script src="<wp:resourceURL />administration/js/html5shiv.js"></script>
	<script src="<wp:resourceURL />administration/js/respond.min.js"></script>
<![endif]-->

	<script src="<wp:resourceURL />administration/js/jquery-1.9.1.min.js"></script>
	<script src="<wp:resourceURL />administration/bootstrap/js/bootstrap.js"></script>
	<script src="<wp:resourceURL />administration/js/bootstrap-offcanvas.js"></script>

	<!-- QUA' FUORI LE COSE COMUNI. DENTRO L'EXTRA LE DIFFERENZE -->
	<tiles:insertAttribute name="extraResources"/>

</head>
<body>

	<div class="container">

	<%--
	<tiles:insertAttribute name="shortcuts-quickbar"/>
	--%>

	<%--
	<h1 id="fagiano_start"><s:text name="title.mainFunctions" /></h1>
	--%>
	<div class="row row-offcanvas row-offcanvas-right">
		<div class="col-sm-3 sidebar-offcanvas col-sm-push-9 col-md-push-9 col-lg-push-9" id="sidebar">

			<div class="panel-group margin-base-bottom">
				<div class="panel panel-default">
					<div class="panel-heading" id="user-avatar">
						<a data-toggle="collapse" href="#submenu-user" class="display-block">
							<c:out value="${sessionScope.currentUser}" />
							<img src="<s:url action="avatarStream" namespace="/do/currentuser/avatar">
							<s:param name="gravatarSize">34</s:param>
						</s:url>" alt=" " class="img-rounded" />
						</a>
					</div>
					<div id="submenu-user" class="panel-collapse collapse">
						<ul class="panel-body nav nav-pills nav-stacked">
							<c:if test="${sessionScope.currentUser.japsUser}">
							<li>
								<a href="<s:url action="editProfile" namespace="/do/CurrentUser" />">
									<span class="icon icon-fixed-width icon-user"></span>&#32;
									<s:text name="note.changeYourPassword" />
								</a>
							</li>
							</c:if>
							<li>
								<a href="<s:url value="/" />" title="<s:text name="note.goToPortal" /> ( <s:text name="note.sameWindow" /> )">
									<span class="icon icon-fixed-width icon-globe"></span>&#32;
									<s:text name="note.goToPortal" />
								</a>
							</li>
							<li>
								<a href="<s:url action="logout" namespace="/do" />">
									<span class="icon icon-fixed-width icon-off"></span>&#32;
									<s:text name="menu.exit" />
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>

			<nav role="navigation">
				<tiles:insertAttribute name="menu"/>
				<p class="sr-only">
					<a href="#fagiano_start" id="fagiano_mainContent"><s:text name="note.backToStart" /></a>
				</p>
			</nav>
		</div>
		<div class="col-sm-9 col-sm-pull-3 col-md-pull-3 col-lg-pull-3">
			<div class="navbar navbar-default navbar-static-top" id="navbar">
				<div class="navbar-header">
					<a href="#sidebar" class="btn-offcanvas navbar-toggle pull-right visible-xs" data-toggle="offcanvas">
						<span class="sr-only"><s:text name="label.menu" /></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</a>
					<a class="navbar-brand" href="<s:url action="main" namespace="/do" />"><img src="<wp:resourceURL />administration/img/entando-logo-symbol-70x42.png" alt="Entando - Simplifying Enterprise Portals" width="70" height="42" /></a>
				</div>
			</div>
			<tiles:insertAttribute name="body"/>
		</div>
		<div class="clearfix"></div>
		<div class="col-sm-12 margin-large-top">
			<ul class="sr-only">
				<li><a href="#fagiano_mainContent"><s:text name="note.backToMainContent" /></a></li>
				<li><a href="#fagiano_start"><s:text name="note.backToStart" /></a></li>
			</ul>
			<div class="text-center">
				<tiles:insertAttribute name="footer"/>
			</div>
		</div>
		</div>

	</div>

</body>
</html>
