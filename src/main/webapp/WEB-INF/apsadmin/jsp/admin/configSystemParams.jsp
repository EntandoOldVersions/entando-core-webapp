<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form"  %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core"  %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> / <s:text name="menu.settings.general" /></span>
</h1>

<div class="row">
	
	<div class="hidden-xs hidden-sm col-md-3 col-lg-3 ">
			<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/settings-nav-menu.jsp">
				<s:param name="activeItem" value="%{'configSystemParams'}" />
			</s:include>
	</div>

	<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">

		<s:form action="updateSystemParams" cssClass="form-horizontal">
			<s:if test="hasActionMessages()">
				<div class="alert alert-success alert-dismissable fade in">
					<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
					<h2 class="h4 margin-none"><s:text name="messages.confirm" /></h2>
					<ul class="margin-base-vertical">
							<s:iterator value="actionMessages">
								<li><s:property escape="false" /></li>
							</s:iterator>
					</ul>
				</div>
			</s:if>

			<fieldset>
				<legend><s:text name="name.pages" /></legend>
				<p class="text-right">
					<span class="label label-default"><s:text name="sysconfig.legend.systemPages" /></span>
				</p>
				

				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-homePageCode"><s:text name="sysconfig.homePageCode" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'homePageCode'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-notFoundPageCode"><s:text name="sysconfig.notFoundPageCode" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'notFoundPageCode'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
					</div>
				</div>
			
				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-errorPageCode"><s:text name="sysconfig.errorPageCode" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'errorPageCode'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
					</div>
				</div>
				
				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-loginPageCode"><s:text name="sysconfig.loginPageCode" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'loginPageCode'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/selectPageParamBlock.jsp" />
					</div>
				</div>
				
				<div class="form-group">
					<s:set name="paramName" value="'urlStyle'" />
					<label class="control-label col-md-3 col-lg-3"><s:text name="sysconfig.URLstyle" /></label>
					<div class="btn-group col-md-9 col-lg-9" data-toggle="buttons">
						
							<label class="btn btn-default <s:if test="systemParams['urlStyle'] == 'classic'"> active</s:if>">
								<input type="radio" class="radiocheck" id="admin-settings-area-urlStyle-classic" name="urlStyle" value="classic" <s:if test="systemParams['urlStyle'] == 'classic'">checked="checked"</s:if> />
								<s:text name="URLstyle.classic" />
							</label>
							<label class="btn btn-default <s:if test="systemParams['urlStyle'] == 'breadcrumbs'"> active</s:if>">
								<input type="radio" class="radiocheck" id="admin-settings-area-urlStyle-breadcrumbs" name="urlStyle" value="breadcrumbs" <s:if test="systemParams['urlStyle'] == 'breadcrumbs'">checked="checked"</s:if> />
								<s:text name="URLstyle.breadcrumbs" />
							</label>
					</div>
				</div>
				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3"><s:text name="sysconfig.lang.browser" /></label>
					<div class="btn-group col-md-9 col-lg-9" data-toggle="buttons">
						<s:set name="paramName" value="'startLangFromBrowser'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/booleanParamBlock.jsp" />
					</div>
				</div>
			</fieldset>

			<fieldset class="margin-large-top"><legend><s:text name="sysconfig.legend.privacyModule" /></legend>
				<div class="form-group">
					<s:set name="paramName" value="'extendedPrivacyModuleEnabled'" />
					<div class="col-lg-offset-3 col-lg-9">
						<div class="checkbox">
							<label>
								<input type="checkbox" class="radiocheck" 
									id="admin-settings-area-extendedPrivacyModuleEnabled" 
									name="extendedPrivacyModuleEnabled" 
									value="true" 
									<s:if test="systemParams['extendedPrivacyModuleEnabled']"> checked="checked" </s:if> 
									/>
								&#32;<strong><s:text name="label.active" /></strong>
							</label>
						</div>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-maxMonthsSinceLastAccess"><s:text name="sysconfig.maxMonthsSinceLastAccess" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'maxMonthsSinceLastAccess'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/textParamBlock.jsp" />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3" for="admin-settings-area-maxMonthsSinceLastPasswordChange"><s:text name="sysconfig.maxMonthsSinceLastPasswordChange" /></label>
					<div class="col-md-9 col-lg-9">
						<s:set name="paramName" value="'maxMonthsSinceLastPasswordChange'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/textParamBlock.jsp" />
					</div>
				</div>
			</fieldset>

			<fieldset class="margin-large-top"><legend><s:text name="sysconfig.legend.misc" /></legend>
				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3"><s:text name="sysconfig.chooseYourEditor" /></label>
					<div class="btn-group col-md-9 col-lg-9" data-toggle="buttons">
							<label class="btn btn-default <s:if test="systemParams['hypertextEditor'] == 'none'"> active</s:if>">
								<input type="radio" id="admin-settings-area-hypertextEditor_none" name="hypertextEditor" value="none" <s:if test="systemParams['hypertextEditor'] == 'none'">checked="checked"</s:if> />
								<s:text name="label.none" />
							</label>
							<label class="btn btn-default <s:if test="systemParams['hypertextEditor'] == 'fckeditor'"> active</s:if>">
								<input type="radio" id="admin-settings-area-hypertextEditor_fckeditor" name="hypertextEditor" value="fckeditor" <s:if test="systemParams['hypertextEditor'] == 'fckeditor'">checked="checked"</s:if> />
								<s:text name="name.editor.ckeditor" />
							</label>
							<label class="btn btn-default <s:if test="systemParams['hypertextEditor'] == 'hoofed'"> active</s:if>">
								<input type="radio" id="admin-settings-area-hypertextEditor_hoofed" name="hypertextEditor" value="hoofed" <s:if test="systemParams['hypertextEditor'] == 'hoofed'">checked="checked"</s:if> />
								<s:text name="name.editor.hoofed" />
							</label>
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3"><s:text name="sysconfig.chooseYourPagesTreeStyle" /></label>
					<div class="btn-group col-md-9 col-lg-9" data-toggle="buttons">
						<s:set name="paramName" value="'treeStyle_page'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/treeStyleParamBlock.jsp" />
					</div>
				</div>

				<div class="form-group">
					<label class="control-label col-md-3 col-lg-3"><s:text name="sysconfig.chooseYourCategoriesTreeStyle" /></label>
					<div class="btn-group col-md-9 col-lg-9" data-toggle="buttons">
						<s:set name="paramName" value="'treeStyle_category'" />
						<s:include value="/WEB-INF/apsadmin/jsp/admin/treeStyleParamBlock.jsp" />
					</div>
				</div>

			</fieldset>

			<wpsa:hookPoint key="core.configSystemParams" objectName="hookPointElements_core_configSystemParams">
				<s:iterator value="#hookPointElements_core_configSystemParams" var="hookPointElement">
					<wpsa:include value="%{#hookPointElement.filePath}"></wpsa:include>
				</s:iterator>
			</wpsa:hookPoint>

			<div class="btn-toolbar">
				<div class="btn-group margin-small-vertical">
					<s:submit type="button" value="" cssClass="btn btn-success"><span class="icon icon-ok"></span>&#32;<s:text name="label.save" /></s:submit>
				</div>
			</div>
			
		</s:form>

	</div>
</div>