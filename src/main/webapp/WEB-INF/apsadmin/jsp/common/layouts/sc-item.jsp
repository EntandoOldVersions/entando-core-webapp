<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
			<s:set var="icons" value="#{
			'components': 'icon fa fa-puzzle-piece',
			'tools': 'icon fa fa-gears',
			'cms': 'icon fa fa-paperclip',
			'plugin': 'icon fa fa-flask',
			'portal': 'icon fa fa-globe'
			}" />
			<wpsa:shortcut key="%{#userShortcutCode}" var="userShortcut" />
			<s:if test="null != #userShortcut">
				<s:set var="emptyShortcutConfigVar" value="%{false}" />
				<s:set var="userShortcutSectionShortDescr" value="%{ null != #userShortcut.menuSection.descriptionKey ? getText(#userShortcut.menuSection.descriptionKey) : #userShortcut.menuSection.description }" />
				<s:set var="userShortcutSectionLongDescr" value="%{ null != #userShortcut.menuSection.longDescriptionKey ? getText(#userShortcut.menuSection.longDescriptionKey) : #userShortcut.menuSection.longDescription }" />
				<s:set var="userShortcutShortDescr" value="%{ null != #userShortcut.descriptionKey ? getText(#userShortcut.descriptionKey) : #userShortcut.description }" />
				<s:set var="userShortcutLongDescr" value="%{ null != #userShortcut.longDescriptionKey ? getText(#userShortcut.longDescriptionKey) : #userShortcut.longDescription }" />
			</s:if>

			<div role="toolbar" data-entando-position="<s:property value="#rowstatus.index" />" class="
				col-lg-6
				<s:if test="null != #userShortcut"> full margin-small-bottom </s:if>
				<s:else> empty sc-hidden </s:else> btn-toolbar  <s:property value="#userShortcut.menuSectionCode" />">
				<s:if test="null != #userShortcut">
					<div class="btn-group btn-group-justified">
						<a
							class="btn btn-block btn-default btn-xs"
							href="<s:url action="%{#userShortcut.actionName}" namespace="%{#userShortcut.namespace}"><wpsa:paramMap map="#userShortcut.parameters" /></s:url>"
							lang="en"
							title="!<s:property value="#userShortcut.menuSectionCode" />![<s:property value="%{#userShortcutSectionShortDescr}" />] <s:property value="%{#userShortcutLongDescr}" />">
								<span class="shortcut-text">
								<span class="text-muted <s:property value="#icons.get(#userShortcut.menuSectionCode)" />"></span>
								<s:property value="%{#userShortcutShortDescr}" /></span>
						</a>
					</div>
				</s:if>
				<s:else>
					<a
						data-toggle="modal" data-target="#shortcut-configure-modal2"
						class="btn-group btn-group-justified sc-hidden"
						data-entando-action="shortcut-add"
						class="btn btn-default btn-xs"
						href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="1" /></s:url>"
						title="<s:text name="label.configure" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
						>
						 <span class="btn btn-default btn-xs btn-block">
						 	<span class="icon fa fa-plus-square"></span>
						 	<span data-entando-role="empty"><s:property value="#rowstatus.count" /></span>
					 	</span>
					</a>
				</s:else>

				<div class="shortcuts-configure-item-toolbar text-center sc-hidden">
					<s:if test="null != #userShortcut">
						<%-- clear --%>
						<a
							data-entando-action="remove"
							class=""
							title="<s:text name="label.clear" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
							href="<s:url action="removeMyShortcut" namespace="/do/MyShortcut"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="4" /></s:url>">
								<span class="icon fa fa-eraser"><span class="sr-only"><s:text name="label.clear" /></span></span>
						</a>
						<%-- configure
						<a
							data-entando-action="configure"
							class="btn btn-default btn-xs"
							rel="shortcut-configure-modal"
							title="<s:text name="label.configure" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
							href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="1" /></s:url>">
								<span class="icon fa fa-cog"><span class="sr-only"><s:text name="label.set" /></span></span>
						</a>
						--%>
						<%-- move
						<a
							data-entando-action="move"
							class="btn btn-default btn-xs"
							title="<s:text name="label.move" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
							href="<s:url action="configPosition" namespace="/do/MyShortcut"><s:param name="positionTarget" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="2" /></s:url>">
								<span class="icon fa fa-arrows"><span class="sr-only"><s:text name="label.move" /></span></span>
						</a>
						--%>
					</s:if>
						<%-- move down --%>
						<a
							data-entando-action="shortcut-move-down"
							class=""
							href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
								<s:param name="positionTarget" value="%{#rowstatus.index}" />
								<s:param name="strutsAction" value="2" />
								<s:param name="positionDest" value="%{#rowstatus.index+1}" /></s:url>">
								&ensp;<span class="icon fa fa-long-arrow-down"></span>&ensp;
						</a>
						<%-- move up --%>
						<a
							data-entando-action="shortcut-move-up"
							class=""
							href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
								<s:param name="positionTarget" value="%{#rowstatus.index}" />
								<s:param name="strutsAction" value="2" />
								<s:param name="positionDest" value="%{#rowstatus.index-1}" /></s:url>">
								&ensp;<span class="icon fa fa-long-arrow-up"></span>&ensp;
						</a>
				</div>
			</div>
			<s:set var="userShortcut" value="%{null}" />