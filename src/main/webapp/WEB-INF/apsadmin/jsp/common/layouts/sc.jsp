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
						<span class="sr-only">edit&#32;</span>
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
						<span class="sr-only">add shortcut</span>
			</a>
		</s:else>
	</div>
	<div class="shortcuts-container row" id="entando-menu-shortcuts-2-container">
		<s:iterator value="#userConfigVar" var="userShortcutCode" status="rowstatus">
			<s:include value="sc-item.jsp" />
		</s:iterator>
	</div>
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