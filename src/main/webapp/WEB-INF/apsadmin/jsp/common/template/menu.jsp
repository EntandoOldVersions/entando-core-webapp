<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2 id="manage" class="noscreen"><s:text name="note.userbar.intro" />:</h2>

<div id="menubar">
<s:if test="#myClient == 'advanced'">
<div id="menubar_content"><div id="menubar_content-1"><div id="menubar_content-2">
</s:if>

<h3 id="menubar-components"><span><s:text name="menu.componentsAdmin" /></span></h3>
<ul class="menu vertical">
	<wp:ifauthorized permission="superuser">
	<li><a href="<s:url action="intro" namespace="/do/Group" />" id="menu_gruppi"><s:text name="menu.accountAdmin.groups" /></a></li>
	</wp:ifauthorized>

	<wp:ifauthorized permission="manageCategories">
		<li><a href="<s:url action="viewTree" namespace="/do/Category" />" id="menu_categorie"><s:text name="menu.categoryAdmin" /></a></li>
	</wp:ifauthorized>

	<wpsa:pluginsSubMenu objectName="pluginsSubMenus" />
	<li <s:if test="#pluginsSubMenus.size > 0">class="openmenu"</s:if> ><a href="#" <s:if test="#pluginsSubMenus.size > 0">rel="fagiano_plugins" class="subMenuToggler"</s:if> id="menu_plugins"><s:text name="menu.plugins" /></a>
		<s:if test="#pluginsSubMenus.size > 0">
			<div class="menuToggler" id="fagiano_plugins"><div class="menuToggler-1"><div class="menuToggler-2">
			<ul>
				<s:iterator value="#pluginsSubMenus" id="pluginSubMenu">
					<wpsa:include value="%{#pluginSubMenu.subMenuFilePath}"></wpsa:include>
				</s:iterator>
			</ul>
			</div></div></div>
		</s:if>
	</li>

</ul>

<wp:ifauthorized permission="managePages" var="isEditPages" />
<wp:ifauthorized permission="superuser" var="isSuperuser" />

<c:if test="${isEditPages || isSuperuser}">
<h3 id="menubar-portal"><span><s:text name="menu.portalAdmin" /></span></h3>
<ul class="menu vertical">
<wp:ifauthorized permission="managePages">
	<li><a href="<s:url action="viewTree" namespace="/do/Page" />" id="menu_pagine"><s:text name="menu.pageAdmin" /></a></li>
	<li><a href="<s:url action="viewShowlets" namespace="/do/Portal/WidgetType" />" id="menu_servizi"><s:text name="menu.showletAdmin" /></a></li>
</wp:ifauthorized>
<wp:ifauthorized permission="superuser">
	<li class="openmenu"><a href="#" rel="fagiano_apis" class="subMenuToggler" id="menu_apis"><s:text name="menu.apisAdmin" /></a>
		<div class="menuToggler" id="fagiano_apis"><div class="menuToggler-1"><div class="menuToggler-2">
		<ul>
			<li><a href="<s:url action="list" namespace="/do/Api/Resource" />" ><s:text name="menu.apisAdmin.resources" /></a></li>
			<li><a href="<s:url action="list" namespace="/do/Api/Service" />" ><s:text name="menu.apisAdmin.services" /></a></li>
			<li><a href="<s:url action="list" namespace="/do/Api/Consumer" />" ><s:text name="menu.apisAdmin.consumers" /></a></li>
		</ul>
		</div></div></div>
	</li>
</wp:ifauthorized>
</ul>
</c:if>

<wp:ifauthorized permission="editContents" var="isEditContents" />
<wp:ifauthorized permission="manageResources" var="isManageResources" />

<c:if test="${isEditContents || isManageResources}">
<h3 id="menubar-cms"><span><s:text name="jacms.menu.cmsAdmin" /></span></h3>
<ul class="menu vertical">
	<wp:ifauthorized permission="editContents">
		<li class="openmenu"><a href="#" rel="fagiano_contenuti" class="subMenuToggler" id="menu_contenuti"><s:text name="jacms.menu.contentAdmin" /></a>
			<div class="menuToggler" id="fagiano_contenuti"><div class="menuToggler-1"><div class="menuToggler-2">
			<ul>
				<li><a href="<s:url action="intro" namespace="/do/jacms/Content" />"><s:text name="jacms.menu.contentAdmin" /></a></li>
				<wp:ifauthorized permission="superuser">
				<li><a href="<s:url action="intro" namespace="/do/jacms/ContentModel" />"><s:text name="jacms.menu.contentModelAdmin" /></a></li>
				<li><a href="<s:url action="initViewEntityTypes" namespace="/do/Entity"><s:param name="entityManagerName">jacmsContentManager</s:param></s:url>"><s:text name="jacms.menu.contentTypeAdmin" /></a></li>
				</wp:ifauthorized>
			</ul>
			</div></div></div>
		</li>
	</wp:ifauthorized>
	<wp:ifauthorized permission="manageResources">
		<li class="openmenu"><a href="#" rel="fagiano_risorse" class="subMenuToggler" id="menu_risorse"><s:text name="jacms.menu.resourceAdmin" /></a>
			<div class="menuToggler" id="fagiano_risorse"><div class="menuToggler-1"><div class="menuToggler-2">
			<ul>
				<li><a href="<s:url action="intro" namespace="/do/jacms/Resource"><s:param name="resourceTypeCode" >Image</s:param></s:url>"><s:text name="jacms.menu.imageAdmin" /></a></li>
				<li><a href="<s:url action="intro" namespace="/do/jacms/Resource"><s:param name="resourceTypeCode" >Attach</s:param></s:url>"><s:text name="jacms.menu.attachAdmin" /></a></li>
			</ul>
			</div></div></div>
		</li>
	</wp:ifauthorized>

</ul>
</c:if>

<s:if test="#myClient == 'advanced'">
</div></div></div>
<div id="menubar_anchor">
	<img src="<wp:resourceURL />administration/mint/img/menubar-anchor.png" width="36" height="102" alt="MENU" />
</div>
</s:if>
</div>
