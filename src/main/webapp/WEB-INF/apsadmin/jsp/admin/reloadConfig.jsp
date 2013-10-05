<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> / <s:text name="menu.reload.config" /></span>
</h1>

<div class="row">
	<div class="hidden-xs hidden-sm col-md-3 col-lg-3 ">
			<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/settings-nav-menu.jsp">
				<s:param name="activeItem" value="%{'reloadConfig'}" />
			</s:include>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
		<s:if test="1 == reloadingResult">
			<div class="alert alert-success">
				<strong><s:text name="messages.confirm" /></strong>!&#32;
				<s:text name="message.reloadConfig.ok" />.
			</div>
		</s:if>
		<s:else>
			<div class="alert alert-warning">
				<strong><s:text name="messages.error" /></strong>!&#32;
				<s:text name="message.reloadConfig.ko" />.
			</div>
		</s:else>
	</div>
</div>