<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<div class="wel margin-base-top">
	<s:set var="userConfigVar" value="userConfig" />
	<s:iterator value="#userConfigVar" var="userShortcutCode" status="rowstatus">
		<s:set var="userShortcut" value="%{getShortcut(#userShortcutCode)}" />
		<s:if test="null != #userShortcut">
			<s:set var="userShortcutSectionShortDescr" value="%{ null != #userShortcut.menuSection.descriptionKey ? getText(#userShortcut.menuSection.descriptionKey) : #userShortcut.menuSection.description }" />
			<s:set var="userShortcutSectionLongDescr" value="%{ null != #userShortcut.menuSection.longDescriptionKey ? getText(#userShortcut.menuSection.longDescriptionKey) : #userShortcut.menuSection.longDescription }" />
			<s:set var="userShortcutShortDescr" value="%{ null != #userShortcut.descriptionKey ? getText(#userShortcut.descriptionKey) : #userShortcut.description }" />
			<s:set var="userShortcutLongDescr" value="%{ null != #userShortcut.longDescriptionKey ? getText(#userShortcut.longDescriptionKey) : #userShortcut.longDescription }" />
		</s:if>
			<div role="toolbar" class="sc-t btn-toolbar margin-small-bottom <s:property value="#userShortcut.menuSectionCode" />">
				<div class="btn-group">
					<s:if test="null != #userShortcut">
						<a
							class="btn btn-default btn-xs"
							href="<s:url action="%{#userShortcut.actionName}" namespace="%{#userShortcut.namespace}"><wpsa:paramMap map="#userShortcut.parameters" /></s:url>"
							lang="en"
							title="[<s:property value="%{#userShortcutSectionShortDescr}" />] <s:property value="%{#userShortcutLongDescr}" />">
								<s:property value="%{#userShortcutShortDescr}" />
						</a>
					</s:if>
					<s:else>
					 <span class="btn btn-none btn-xs">&nbsp;</span>
					</s:else>
				</div>
				<div class="tt btn-group pull-right">
					<s:if test="null != #userShortcut">
						<a
							class="btn btn-default btn-xs"
							title="<s:text name="label.clear" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
							href="<s:url action="removeMyShortcut" namespace="/do/MyShortcut"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="4" /></s:url>">
								<span class="icon fa fa-eraser"><span class="sr-only"><s:text name="label.clear" /></span></span></a>
					</s:if>
					<s:else>
						<a
							class="btn btn-default btn-xs"
							href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="1" /></s:url>"
							title="<s:text name="label.configure" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
							<%-- data-toggle="modal" data-target="#shortcut-configure-modal" --%>
							>
								<span class="icon fa fa-plus-square"></span>
						</a>
					</s:else>
					<a
						class="btn btn-default btn-xs"
						rel="shortcut-configure-modal"
						title="<s:text name="label.configure" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
						href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="1" /></s:url>">
							<span class="icon fa fa-cog"><span class="sr-only"><s:text name="label.set" /></span></span>
					</a>
					<a
						class="btn btn-default btn-xs"
						title="<s:text name="label.move" />&#32;<s:text name="name.position" />&#32;<s:property value="%{#rowstatus.index + 1}" />"
						href="<s:url action="configPosition" namespace="/do/MyShortcut"><s:param name="positionTarget" value="%{#rowstatus.index}" /><s:param name="strutsAction" value="2" /></s:url>">
							<span class="icon fa fa-arrows"><span class="sr-only"><s:text name="label.move" /></span></span>
					</a>
					<a
						class="btn btn-default btn-xs <s:if test="#rowstatus.last"> disabled </s:if>"
						href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
							<s:param name="positionTarget" value="%{#rowstatus.index}" />
							<s:param name="strutsAction" value="2" />
							<s:param name="positionDest" value="%{#rowstatus.index+1}" /></s:url>">
							<span class="icon fa fa-long-arrow-down"></span>
					</a>
					<a
						class="btn btn-default btn-xs <s:if test="#rowstatus.first"> disabled </s:if>"
						href="<s:url namespace="/do/MyShortcut" action="swapMyShortcut">
							<s:param name="positionTarget" value="%{#rowstatus.index}" />
							<s:param name="strutsAction" value="2" />
							<s:param name="positionDest" value="%{#rowstatus.index-1}" /></s:url>">
							<span class="icon fa fa-long-arrow-up"></span>
					</a>
				</div>
			</div>
	</s:iterator>
</div>

<%-- shortucs available for the current user --%>
<s:set var="allowedShortcutsVar" value="allowedShortcuts" />
<%-- if there are shortcuts and if position not null, so show the configuration form --%>
<s:if test="((null != #allowedShortcutsVar) && (#allowedShortcutsVar.size() > 0) && (null != position)) || #myClient=='advanced'">
	<div class="subsection-light clear" id="shortcut-configure-container">
		<h2 class="margin-bit-bottom" id="shortcut-configure"><s:text name="label.configure" />&#32;<s:text name="name.position" />&#32;<span class="position-name"><s:property value="%{position + 1}" /></span></h2>
		<s:form namespace="/do/MyShortcut" action="joinMyShortcut">
			<p class="noscreen">
				<wpsf:hidden name="position" />
				<wpsf:hidden name="strutsAction" value="1" />
			</p>
			<p>
				<label for="shortcutCode" class="basic-mint-label"><s:text name="label.choose" />:</label>

				<select name="shortcutCode" id="shortcutCode" tabindex="<wpsa:counter />" >
				<wpsa:set var="tmpShortcutGroup" value="null" />
				<s:iterator value="allowedShortcutSelectItems" var="allowedShortcutItem">
					<s:if test="null != #tmpShortcutGroup && !#allowedShortcutItem.optgroup.equals(#tmpShortcutGroup)">
					</optgroup>
					</s:if>
					<s:if test="null == #tmpShortcutGroup || !#allowedShortcutItem.optgroup.equals(#tmpShortcutGroup)">
					<optgroup label="<s:property value="#allowedShortcutItem.optgroup" />">
					</s:if>
						<option value="<s:property value="#allowedShortcutItem.key" />"><s:property value="#allowedShortcutItem.value" /></option>
					<wpsa:set var="tmpShortcutGroup"><s:property value="#allowedShortcutItem.optgroup" /></wpsa:set>
				</s:iterator>
				</optgroup>
				</select>

				<wpsf:submit value="%{getText('label.set')}" cssClass="btn btn-default" />
			</p>
		</s:form>
	</div>
</s:if>


<%-- else show the swap form --%>
<s:elseif test="null != positionTarget">
	<div class="subsection-light clear" id="shortcut-swap-container">
	<h2 class="margin-bit-bottom" id="shortcut-swap"><s:text name="label.swap" />&#32;<s:text name="name.position" />: <s:property value="%{positionTarget + 1}" /> &ndash;
	<s:set var="userShortcutToMove" value="%{getShortcut(#userConfigVar[positionTarget])}" />
	<s:if test="null != #userShortcutToMove">
		<s:if test="null != #userShortcutToMove.descriptionKey"><s:text name="%{#userShortcutToMove.descriptionKey}" /></s:if><s:else><s:property value="%{#userShortcutToMove.description}" /></s:else>
	</s:if>
	<s:else><s:text name="label.empty.f" /></s:else>
	</h2>
	<s:form namespace="/do/MyShortcut" action="swapMyShortcut">
	<p class="noscreen">
		<wpsf:hidden name="positionTarget" />
		<wpsf:hidden name="strutsAction" value="2" />
	</p>

	<p>
	<label for="positionDest" class="basic-mint-label"><s:text name="label.choose" />:</label>
	<select name="positionDest" id="positionDest" tabindex="<wpsa:counter />" >
	<s:iterator var="userShortcutCodeDestVar" value="#userConfigVar" status="rowstatus">
		<s:set var="userShortcut" value="%{getShortcut(#userShortcutCodeDestVar)}"></s:set>
		<s:if test="null != #userShortcut">
			<s:set var="userShortcutShortDestDescr"><s:if test="null != #userShortcut.descriptionKey" ><s:text name="%{#userShortcut.descriptionKey}" /></s:if><s:else><s:property value="%{#userShortcut.description}" /></s:else></s:set>
		</s:if>
		<s:else>
			<s:set var="userShortcutShortDestDescr"><s:text name="label.empty.f" /></s:set>
		</s:else>
		<option value="<s:property value="#rowstatus.index" />"><s:property value="%{#rowstatus.index + 1}" /> &ndash; <s:property value="%{#userShortcutShortDestDescr}" /></option>
	</s:iterator>
	</select>

	<wpsf:submit value="%{getText('label.set')}" cssClass="btn btn-default" />
	</p>
	</s:form>
	</div>
</s:elseif>
<%--
<button class="btn btn-primary btn-lg" data-toggle="modal" data-target="#shortcut-configure-modal">
	Launch demo modal
</button>
<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="shortcut-configure-modal" aria-labelledby="shortcut-configure-modal" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">
				we
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
		</div>
	</div>
</div>
--%>
