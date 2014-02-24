<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%--
properties label to add:

shortcuts.modal.button.close=Close
shortcuts.modal.label.set=Set
shortcuts.label.add=Add Shortcut
shortcuts.label.title=Shortcuts
shortcuts.label.configure=Configure Shortcuts
shortcuts.label.edit=Edit
shortcuts.label.moveup=Move Up
shortcuts.label.movedown=Move Down
shortcuts.label.clear=Clear
shortcuts.label.choose=Choose
shortcuts.label.position=Position
--%>
<s:set var="shortcutsIconsVar" value="#{
'components': 'icon fa fa-puzzle-piece',
'tools': 'icon fa fa-gears',
'cms': 'icon fa fa-paperclip',
'plugins': 'icon fa fa-flask',
'portal': 'icon fa fa-globe'
}" />
<wpsa:userShortcutsConfig var="userConfigVar" />
<s:set var="userConfigVar" value="#userConfigVar.config" />
<div id="entando-menu-shortcuts-2" class="margin-base-bottom">
	<s:set var="emptyShortcutConfigVar" value="%{true}" />
	<s:set var="fullShortcutConfigVar" value="%{0}" />
	<s:iterator value="#userConfigVar" var="userShortcutCode" status="rowstatus">
		<wpsa:shortcut key="%{#userShortcutCode}" var="userShortcut" />
		<s:if test="null != #userShortcut">
				<s:set var="emptyShortcutConfigVar" value="%{false}" />
		</s:if>
		<s:else>
			<s:set var="fullShortcutConfigVar" value="%{#fullShortcutConfigVar+1}" />
		</s:else>
		<s:set var="userShortcut" value="%{null}" />
	</s:iterator>

	<div class="text-muted small display-block">
		<s:text name="shortcuts.label.title" />
		<s:if test="!#emptyShortcutConfigVar">
				<a
					href="#entando-menu-shortcuts-container"
					class="pull-right" id="edit-shortcuts"
					title="<s:text name="shortcuts.label.edit" />"
					>
						<span class="sr-only"><s:text name="shortcuts.label.edit" />&#32;</span>
						<span class="icon fa fa-cog"></span>
				</a>
		</s:if>
		<s:else>
			<a
				data-toggle="modal" data-target="#shortcut-configure-modal2" data-entando-action="shortcut-add"
				data-entando-position="0"
				class="btn-toolbar pull-right"
				href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="0" /><s:param name="strutsAction" value="1" /></s:url>"
				title="add shortcut" >
						<span class="icon fa fa-plus-square"></span>
						<span class="sr-only"><s:text name="shortcuts.label.add" /></span>
			</a>
		</s:else>
	</div>
	<div class="shortcuts-container row" id="entando-menu-shortcuts-container">
		<s:iterator value="#userConfigVar" var="userShortcutCode" status="rowstatus">
		<%-- single shortcut start --%>
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
							title="[<s:property value="%{#userShortcutSectionShortDescr}" />] <s:property value="%{#userShortcutLongDescr}" />">
								<span class="shortcut-text">
								<span class="text-info <s:property value="#shortcutsIconsVar.get(#userShortcut.menuSectionCode)" />"></span>
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
						title="<s:text name="shortcuts.label.configure" />&#32;<s:text name="shortcuts.label.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
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
							title="<s:text name="shortcuts.label.clear" />&#32;<s:property value="%{null != #userShortcut ? #userShortcutShortDescr : #rowstatus.count}" />"
							href="<s:url action="removeMyShortcut" namespace="/do/MyShortcut"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="4" /></s:url>">
								<span class="sr-only"><s:text name="shortcuts.label.clear" /></span>
								<span class="icon fa fa-eraser"></span>
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
							title="<s:text name="shortcuts.label.movedown" />&#32;<s:property value="%{null != #userShortcut ? #userShortcutShortDescr : #rowstatus.count}" />"
							href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
								<s:param name="positionTarget" value="%{#rowstatus.index}" />
								<s:param name="strutsAction" value="2" />
								<s:param name="positionDest" value="%{#rowstatus.index+1}" /></s:url>">
								<span class="sr-only"><s:text name="shortcuts.label.movedown" /></span>
								&ensp;<span class="icon fa fa-long-arrow-down"></span>&ensp;
						</a>
						<%-- move up --%>
						<a
							data-entando-action="shortcut-move-up"
							class=""
							title="<s:text name="shortcuts.label.moveup" />&#32;<s:property value="%{null != #userShortcut ? #userShortcutShortDescr : #rowstatus.count}" />"
							href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
								<s:param name="positionTarget" value="%{#rowstatus.index}" />
								<s:param name="strutsAction" value="2" />
								<s:param name="positionDest" value="%{#rowstatus.index-1}" /></s:url>">
								<span class="sr-only"><s:text name="shortcuts.label.moveup" /></span>
								&ensp;<span class="icon fa fa-long-arrow-up"></span>&ensp;
						</a>
				</div>
			</div>
			<s:set var="userShortcut" value="%{null}" />
		<%-- single shortcut end --%>
		</s:iterator>
	</div>

	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="shortcut-configure-modal2" aria-labelledby="shortcut-configure-modal" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel"><label for="shortcutCode"><s:text name="shortcuts.label.configure" /></label></h4>
				</div>
				<s:form
					namespace="/do/MyShortcut"
					action="joinMyShortcut"
					cssClass="modal-body">
							<p class="noscreen">
								<wpsf:hidden name="position" />
								<wpsf:hidden name="strutsAction" value="1" />
							</p>
							<div class="form-group">
								<label for="shortcutCode" class="control-label sr-only"><s:text name="shortcuts.label.choose" /></label>
								<select name="shortcutCode" id="shortcutCode" class="form-control">
									<s:set var="tmpShortcutGroup" value="%{null}" />
									<s:iterator value="allowedShortcutSelectItems" var="allowedShortcutItem">
										<s:if test="null != #tmpShortcutGroup && !#allowedShortcutItem.optgroup.equals(#tmpShortcutGroup)">
											</optgroup>
										</s:if>
										<s:if test="null == #tmpShortcutGroup || !#allowedShortcutItem.optgroup.equals(#tmpShortcutGroup)">
											<optgroup label="<s:property value="#allowedShortcutItem.optgroup" />">
										</s:if>
											<option value="<s:property value="#allowedShortcutItem.key" />">
												<s:property value="#allowedShortcutItem.value" />
											</option>
											<s:set var="tmpShortcutGroup" value="#allowedShortcutItem.optgroup" />
									</s:iterator>
									</optgroup>
								</select>
							</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								<s:text name="shortcuts.modal.button.close" />
							</button>
							<button type="submit" class="btn btn-primary">
								<s:property value="shortcuts.modal.label.set" />
							</button>
						</div>
				</s:form>
			</div>
		</div>
	</div>

</div>
