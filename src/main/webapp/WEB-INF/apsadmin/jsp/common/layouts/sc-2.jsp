<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
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
		Shortcuts
		<s:if test="!#emptyShortcutConfigVar">
				<a
					href="#entando-menu-shortcuts-2-container"
					class="pull-right" id="edit-2">
						edit&#32;<span class="icon fa fa-cog"></span>
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
						<span class="sr-only">add shortcut</span>
			</a>
		</s:else>
	</div>
	<div class="shortcuts-container row" id="entando-menu-shortcuts-2-container">
		<s:iterator value="#userConfigVar" var="userShortcutCode" status="rowstatus">
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
								<s:property value="%{#userShortcutShortDescr}" />
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
		</s:iterator>
	</div>
	<%--
	<s:if test="#emptyShortcutConfigVar">
		<a
				role="toolbar"
				data-toggle="modal" data-target="#shortcut-configure-modal2" data-entando-action="shortcut-add"
				data-entando-position="0"
				class="btn-toolbar"
				href="<s:url action="configPosition" namespace="/do/MyShortcut" anchor="shortcut-configure-modal"><s:param name="position" value="0" /><s:param name="strutsAction" value="1" /></s:url>"
				title="<s:text name="label.configure" />" >
					<span class="btn btn-default btn-xs sc-hidden">
						<span class="icon fa fa-plus-square"></span>
						<s:text name="label.configure" /> Shortcut
					</span>
		</a>
	</s:if>
	--%>
<script>
jQuery(function(){
	$('#edit-2').on('click', function(ev){
		ev.preventDefault();
		$('.shortcuts-container').toggleClass('edit-mode');
		$('.shortcuts-container .empty').toggleClass('margin-small-bottom');
	});

	var scAjax = function(url) {
		$.ajax({url: url});
	};

	var scBarFind = function(item) {
		if ( $(item).hasClass('btn-toolbar') ) { return $(item); }
		return $(item).parents('.btn-toolbar');
	};
	var scGetPosition = function(item) {
		return scBarFind(item).attr('data-entando-position');
	};
	var scSetPosition = function(item, sign) {
		var el = scBarFind(item);
		var oldv = parseInt(el.attr('data-entando-position'));
		var newv = oldv;
		if (sign == '+') {
			newv = (newv+1) > 10 ? 10 : (newv+1);
		}
		else {
			newv = (newv-1) < 0 ? 0 : ((-1)+newv);
		}
		el.attr('data-entando-position', newv);
		$('[data-entando-role="empty"]', el).text(newv+1);
		var as = $('a[href]', el);
		$.each(as, function(index, a){
			////console.log(a);
			var a = $(a);
			var href = a.attr('href');
			href = href.replace(/position=\d+/gi, 'position='+ newv +'');
			href = href.replace(/positionTarget=\d+/gi, 'positionTarget='+ newv +'');
			if (a.attr('data-entando-action')=='shortcut-move-down') {
					href = href.replace(/positionDest=\d+/gi, 'positionDest='+ (newv+1) +'');
			}
			else {
				href = href.replace(/positionDest=\d+/gi, 'positionDest='+ (newv-1) +'');
			}
			a.attr('href', href);
		});
	};
	var scMoveUp = function(ev) {
		ev.preventDefault();
		scAjax($(this).attr('href'));
		var scBlock = scBarFind(this);
		var otherEl = scBlock.prev();
		if (otherEl.length>0) {
			scSetPosition(scBlock, '-');
			scSetPosition(otherEl, '+');
			scBlock.insertBefore(otherEl);
		}
	};
	var scMoveDown = function(ev) {
		ev.preventDefault();
		scAjax($(this).attr('href'));
		var scBlock = scBarFind(this);
		var otherEl = scBlock.next();
		if (otherEl.length>0) {
			scSetPosition(scBlock, '+');
			scSetPosition(otherEl, '-');
			scBlock.insertAfter(otherEl);
		}
	};
	var scAdd = function(ev) {
		ev.preventDefault();
		var position = scGetPosition(this);
		$('#shortcut-configure-modal2 [name="position"]').val(position);
	};

	var scClear = function(ev) {
		//var pos = scGetPosition(this);
		//ev.preventDefault();
		//scAjax($(this).attr('href'));
	};

	$('body').delegate('[data-entando-action="shortcut-add"]', 'click', scAdd);
	$('body').delegate('[data-entando-action="shortcut-move-up"]', 'click', scMoveUp);
	$('body').delegate('[data-entando-action="shortcut-move-down"]', 'click', scMoveDown);
	$('body').delegate('[data-entando-action="remove""]', 'click', scClear);
})
</script>

	<div class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" id="shortcut-configure-modal2" aria-labelledby="shortcut-configure-modal" aria-hidden="true">
		<div class="modal-dialog modal-sm">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					<h4 class="modal-title" id="myModalLabel">Configure Shortcut</h4>
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
								<label for="shortcutCode" class="control-label sr-only"><s:text name="label.choose" /></label>
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
							<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
							<wpsf:submit
								type="button"
								cssClass="btn btn-primary"
								value="%{getText('label.set')}"><s:text name="label.set" /></wpsf:submit>
						</div>
				</s:form>
			</div>
		</div>
	</div>

</div>