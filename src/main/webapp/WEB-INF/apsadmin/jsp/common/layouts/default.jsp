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

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<wp:resourceURL />administration/js/html5shiv.js"></script>
  <script src="<wp:resourceURL />administration/js/respond.min.js"></script>
<![endif]-->

	<!-- QUA' FUORI LE COSE COMUNI. DENTRO L'EXTRA LE DIFFERENZE -->
	<tiles:insertAttribute name="extraResources"/>

</head>
<body>

<div id="topbar">
<tiles:insertAttribute name="topbar"/>
</div>

<div id="header" class="clear">
<h1 class="noscreen" id="fagiano_start"><s:text name="title.mainFunctions" /></h1>
<tiles:insertAttribute name="header"/>
</div>
<div id="corpo">
	<div id="colonna1">
	<tiles:insertAttribute name="menu"/>
	</div>
	<div id="colonna2">
	<p class="noscreen"><a href="#fagiano_start" id="fagiano_mainContent"><s:text name="note.backToStart" /></a></p>
	<tiles:insertAttribute name="body"/>
	<p class="noscreen"><a href="#fagiano_mainContent"><s:text name="note.backToMainContent" /></a></p>
	<p class="noscreen"><a href="#fagiano_start"><s:text name="note.backToStart" /></a></p>
	</div>
</div>
<div id="footer">
<tiles:insertAttribute name="footer"/>
</div>

<!-- Bootstrap core JavaScript
================================================== -->
<!-- Placed at the end of the document so the pages load faster -->
<script src="<wp:resourceURL />administration/js/jquery-1.9.1.min.js"></script>
<script src="<wp:resourceURL />administration/bootstrap/js/bootstrap.js"></script>

</body>
</html>