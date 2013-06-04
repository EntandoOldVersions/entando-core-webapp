<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>

<s:set var="myClient"><wpsa:backendGuiClient /></s:set>
<%-- <?xml version="1.0" encoding="utf-8"?>  --%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="<s:property value="currentLang.code" />">
<head>

	<title>Entando - <s:set name="documentTitle"><tiles:getAsString name="title"/></s:set><s:property value="%{getText(#documentTitle)}" escape="false" /></title>

	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/menu.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/layout-general.css" media="screen" />

	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/menu-ie7.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/layout-general-ie7.css" media="screen" />
	<![endif]-->

	<!--[if IE 8]>
			<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/common/css/administration-ie8.css" media="screen" />
	<![endif]-->

<s:if test="#myClient == 'normal'">
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/menu.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/basic/css/layout-general.css" media="screen" />
</s:if>

<s:if test="#myClient == 'advanced'">
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/administration.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/menu.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/layout-general.css" media="screen" />

	<!--[if IE 7]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/menu-ie7.css" media="screen" />
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/layout-general-ie7.css" media="screen" />
	<![endif]-->

	<!--[if IE 8]>
		<link rel="stylesheet" type="text/css" href="<wp:resourceURL />administration/mint/css/administration-ie8.css" media="screen" />
	<![endif]-->

</s:if>

	<!-- QUA' FUORI LE COSE COMUNI. DENTRO L'EXTRA LE DIFFERENZE -->
	<tiles:insertAttribute name="extraResources"/>

</head>
<body class="client-<s:property value="#myClient" />">

<div id="topbar">
<tiles:insertAttribute name="topbar"/>
</div>

<div id="header" class="clear">
<h1 class="noscreen" id="fagiano_start"><s:text name="title.mainFunctions" /></h1>
<tiles:insertAttribute name="header"/>
</div>
<div id="corpo">
	<div id="colonna1">
	</div>
	<div id="colonna2">
	<p class="noscreen"><a href="#fagiano_start" id="fagiano_mainContent"><s:text name="note.backToStart" /></a></p>
	<tiles:insertAttribute name="menu"/>
	<tiles:insertAttribute name="body"/>
	<p class="noscreen"><a href="#fagiano_mainContent"><s:text name="note.backToMainContent" /></a></p>
	<p class="noscreen"><a href="#fagiano_start"><s:text name="note.backToStart" /></a></p>
	</div>
</div>
<div id="footer">
<tiles:insertAttribute name="footer"/>
</div>
</body>
</html>