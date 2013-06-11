<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<!DOCTYPE html>
<html lang="<s:property value="currentLang.code" />">
<head>

	<title>Entando - <s:set name="documentTitle"><tiles:getAsString name="title"/></s:set><s:property value="%{getText(#documentTitle)}" escape="false" /></title>

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" href="<wp:resourceURL />administration/bootstrap/css/bootstrap.min.css" media="screen" />
	<link rel="stylesheet" href="<wp:resourceURL />administration/css/bootstrap-override.css" media="screen" />
	<link rel="stylesheet" href="<wp:resourceURL />administration/css/bootstrap-offcanvas.css" media="screen" />

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<wp:resourceURL />administration/js/html5shiv.js"></script>
  <script src="<wp:resourceURL />administration/js/respond.min.js"></script>
<![endif]-->

	<style>
		body {
			padding-top: 60px;
		}
	</style>

	<!-- QUA' FUORI LE COSE COMUNI. DENTRO L'EXTRA LE DIFFERENZE -->
	<tiles:insertAttribute name="extraResources"/>

</head>
<body>

<tiles:insertAttribute name="header"/>

<div class="container">

<%--
	<tiles:insertAttribute name="shortcuts-quickbar"/>
--%>

<%--
	<h1 id="fagiano_start"><s:text name="title.mainFunctions" /></h1>
--%>
<div class="row row-offcanvas row-offcanvas-right">
	<div class="col-sm-9">
		<p class="pull-right visible-sm">
			<a href="#sidebar" class="btn btn-info btn-offcanvas" data-toggle="offcanvas">
				&hellip;
			</a></p>
		<tiles:insertAttribute name="body"/>
	</div>
	<nav class="col-sm-3 sidebar-offcanvas" id="sidebar" role="navigation">
		<tiles:insertAttribute name="menu"/>
		<p class="noscreen">
			<a href="#fagiano_start" id="fagiano_mainContent"><s:text name="note.backToStart" /></a>
		</p>
	</nav>
</div>

<div class="row margin-large-top">
	<ul class="noscreen">
		<li><a href="#fagiano_mainContent"><s:text name="note.backToMainContent" /></a></li>
		<li><a href="#fagiano_start"><s:text name="note.backToStart" /></a></li>
	</ul>
	<div class="text-center">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>

</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<wp:resourceURL />administration/js/jquery-1.9.1.min.js"></script>
<script src="<wp:resourceURL />administration/bootstrap/js/bootstrap.js"></script>
<script src="<wp:resourceURL />administration/js/bootstrap-offcanvas.js"></script>

</body>
</html>