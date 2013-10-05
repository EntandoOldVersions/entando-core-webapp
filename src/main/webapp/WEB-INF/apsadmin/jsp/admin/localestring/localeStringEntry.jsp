<%@ taglib uri="/struts-tags" prefix="s" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>&#32;/&#32;
		<a href="<s:url namespace="/do/LocaleString" action="list" />"><s:text name="title.languageAdmin.labels" /></a>&#32;/&#32;
		<s:if test="getStrutsAction() == 1"><s:text name="title.generalSettings.locale.new" /></s:if> 
		<s:elseif test="getStrutsAction() == 2"><s:text name="title.generalSettings.locale.edit" /> </s:elseif>
	</span>
</h1>
<s:form action="save" namespace="/do/LocaleString" cssClass="form-horizontal">
	<s:if test="hasFieldErrors()">
		<div class="alert alert-warning">
			<button class="close" data-dismiss="alert">&times;</button>
			<h2 class="h4 margin-none">
				<s:text name="message.title.FieldErrors" />
			</h2>
			<%--
				<ul class="margin-base-top">
				<s:iterator value="fieldErrors">
					<s:iterator value="value">
					<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
				</ul>
			--%>
		</div>
	</s:if>
	<p class="sr-only">
		<s:hidden value="%{getStrutsAction()}" name="strutsAction"/>
		<s:if test="getStrutsAction() == 2">
			<s:hidden value="%{key}" name="key" />
		</s:if>
	</p>
	<s:set var="keyFieldErrorsVar" value="%{fieldErrors['key']}" />
	<s:set var="keyHasFieldErrorVar" value="#keyFieldErrorsVar != null && !#keyFieldErrorsVar.isEmpty()" />
  <s:set var="controlGroupErrorClassVar" value="%{#keyHasFieldErrorVar ? ' has-error' : ''}" />
	<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
		<label class="control-label col-lg-3 col-md-3" for="editLabel_key"><s:text name="label.code" /></label>
		<div class="col-md-9 col-lg-9">
			<s:textfield value="%{key}" name="key" id="editLabel_key" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
			<s:if test="#keyHasFieldErrorVar">
				<p class="text-danger padding-small-vertical"><s:iterator value="#keyFieldErrorsVar"><s:property />&#32;</s:iterator></p>
			</s:if>
		</div>
	</div>
	<s:iterator value="langs" var="l">
		<s:if test="#l.default">
			<s:set var="currentFieldErrorsVar" value="%{fieldErrors[#l.code]}" />
			<s:set var="currentHasFieldErrorVar" value="#currentFieldErrorsVar != null && !#currentFieldErrorsVar.isEmpty()" />
			<s:set var="controlGroupErrorClassVar" value="%{#currentHasFieldErrorVar ? ' has-error' : ''}" />
			<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
				<label class="control-label col-lg-3 col-md-3" for="lang<s:property value="#l.code"/>">
					<%-- (<s:property value="#l.code" />)&#32;<s:text name="label.description" /> --%>
					<span lang="<s:property value="#l.code" />"><s:property value="#l.descr" /></span>
				</label>
				<div class="col-md-9 col-lg-9">
					<s:textarea cols="50" rows="3" name="%{code}" id="%{'lang'+code}" value="%{labels[#l.code]}" cssClass="form-control" />
					<s:if test="#currentHasFieldErrorVar">
						<p class="text-danger padding-small-vertical"><s:iterator value="#currentFieldErrorsVar"><s:property />&#32;</s:iterator></p>
					</s:if>
				</div>
			</div>
		</s:if>
	</s:iterator>
	<s:if test="%{langs.size() > 1}">
		<fieldset>
			<legend><s:text name="label.localeString.languages.optional" /></legend>
				<s:iterator value="langs" var="l">
					<s:if test="! #l.default">
						<s:set var="currentFieldErrorsVar" value="%{fieldErrors[#l.code]}" />
						<s:set var="currentHasFieldErrorVar" value="#currentFieldErrorsVar != null && !#currentFieldErrorsVar.isEmpty()" />
						<s:set var="controlGroupErrorClassVar" value="%{#currentHasFieldErrorVar ? ' has-error' : ''}" />
						<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
							<label class="control-label col-lg-3 col-md-3" for="lang<s:property value="#l.code"/>">
								<%-- (<s:property value="#l.code" />)</span>&#32;<s:text name="label.description" />--%>
								<span lang="<s:property value="#l.code" />"><s:property value="#l.descr" /></span>
							</label>
							<div class="col-md-9 col-lg-9">
								<s:textarea cols="50" rows="3" name="%{code}" id="%{'lang'+code}" value="%{labels[#l.code]}" cssClass="form-control" />
								<s:if test="#currentHasFieldErrorVar">
									<p class="text-danger padding-small-vertical"><s:iterator value="#currentFieldErrorsVar"><s:property />&#32;</s:iterator></p>
								</s:if>
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