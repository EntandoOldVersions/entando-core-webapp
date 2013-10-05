<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a> / 
		<a href="<s:url namespace="/do/LocaleString" action="list" />"><s:text name="title.languageAdmin" /></a> / 
		<s:if test="getStrutsAction() == 1"><s:text name="title.generalSettings.locale.new" /></s:if> 
		<s:elseif test="getStrutsAction() == 2"><s:text name="title.generalSettings.locale.edit" /> </s:elseif>
	</span>
</h1>
<div class="row">
	<div class="hidden-xs hidden-sm col-md-3 col-lg-3 ">
			<s:include value="/WEB-INF/apsadmin/jsp/admin/inc/settings-nav-menu.jsp">
				<s:param name="activeItem" value="%{'localeStrings'}" />
			</s:include>
	</div>
	<div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
		<s:form action="save" namespace="/do/LocaleString" cssClass="form-horizontal">
			
			<s:if test="hasFieldErrors()">
				<div class="alert alert-warning">
					<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
					<h2 class="h4 margin-none">
						<s:text name="message.title.FieldErrors" />
					</h2>
					<ul class="margin-base-top">
					<s:iterator value="fieldErrors">
						<s:iterator value="value">
						<li><s:property escape="false" /></li>
						</s:iterator>
					</s:iterator>
					</ul>
				</div>
			</s:if>

			<p class="sr-only">
				<s:hidden value="%{getStrutsAction()}" name="strutsAction"/>
				<s:if test="getStrutsAction() == 2">
					<s:hidden value="%{key}" name="key" />
				</s:if>
			</p>
			<div class="form-group">
				<label class="control-label col-lg-3 col-md-3" for="editLabel_key"><s:text name="label.code" /></label>
				<div class="col-md-9 col-lg-9">
					<s:textfield value="%{key}" name="key" id="editLabel_key" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
				</div>
			</div>
			<s:iterator value="langs" var="l">
				<s:if test="#l.default">
					<div class="form-group">
						<label class="control-label col-lg-3 col-md-3" for="lang<s:property value="code"/>">
							(<s:property value="code" />)</span>&#32;<s:text name="label.description" />
						</label>
						<div class="col-md-9 col-lg-9">
							<s:textarea cols="50" rows="3" name="%{code}" id="%{'lang'+code}" value="%{labels[#l.code]}" cssClass="form-control" />
						</div>
					</div>
				</s:if>
			</s:iterator>
			<s:if test="%{langs.size() > 1}">
				<fieldset>
					<legend><s:text name="label.localeString.languages.optional" /></legend>
						<s:iterator value="langs" var="l">
							<s:if test="! #l.default">
								<div class="form-group">
									<label class="control-label col-lg-3 col-md-3" for="lang<s:property value="code"/>">
										(<s:property value="code" />)</span>&#32;<s:text name="label.description" />
									</label>
									<div class="col-md-9 col-lg-9">
										<s:textarea cols="50" rows="3" name="%{code}" id="%{'lang'+code}" value="%{labels[#l.code]}" cssClass="form-control" />
									</div>
								</div>
							</s:if>
						</s:iterator>
				</fieldset>
			</s:if>
			<div class="form-group">
				<div class="col-md-offset-3 col-lg-offset-3 col-md-9 col-lg-9">
					<s:submit type="button" cssClass="btn btn-primary">
						<s:text name="label.save" />
					</s:submit>
				</div>
			</div>
		</s:form>
	</div>
</div>