<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url action="list" namespace="/do/Group"></s:url>" 
		title="<s:text name="note.goToSomewhere" />: <s:text name="title.groupManagement" />">
			<s:text name="title.groupManagement" />
		</a>
		&#32;/&#32;
		<s:if test="getStrutsAction() == 1">
			<s:text name="title.groupManagement.groupNew" />
		</s:if>
		<s:if test="getStrutsAction() == 2">
			<s:text name="title.groupManagement.groupEdit" />
		</s:if>
	</span>
</h1>
<s:form action="save" cssClass="form-horizontal" >
	<s:if test="hasActionErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
			<ul class="margin-base-top">
				<s:iterator value="actionErrors">
					<li><s:property escape="false" /></li>
				</s:iterator>
			</ul>
		</div>
	</s:if>
	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
			<%--<ul class="margin-base-top">
				<s:iterator value="fieldErrors">
						<s:iterator value="value">
							<li><s:property escape="false" /></li>
						</s:iterator>
					</s:iterator>
			</ul>--%>
		</div>
	</s:if>
	<p class="sr-only">
		<wpsf:hidden name="strutsAction" />
		<s:if test="getStrutsAction() == 2">
			<wpsf:hidden name="name" />
		</s:if>
	</p>
	<%-- name --%>
	<s:set var="fieldErrorsVar" value="%{fieldErrors['name']}" />
	<s:set var="fieldHasFieldErrorVar" value="#fieldErrorsVar != null && !#fieldErrorsVar.isEmpty()" />
	<s:set var="controlGroupErrorClassVar" value="%{#fieldHasFieldErrorVar ? ' has-error' : ''}" />
	<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
		<label class="control-label col-lg-3 col-md-3" for="name"><s:text name="name" /></label>
		<div class="col-md-9 col-lg-9">
			<s:textfield name="name" id="name" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
			<s:if test="#fieldHasFieldErrorVar">
				<span class="help-block text-danger">
					<s:iterator value="#fieldErrorsVar"><s:property />&#32;</s:iterator>
				</span>
			</s:if>
		</div>
	</div>
	<%-- description --%>
		<s:set var="fieldErrorsVar" value="%{fieldErrors['description']}" />
		<s:set var="fieldHasFieldErrorVar" value="#fieldErrorsVar != null && !#fieldErrorsVar.isEmpty()" />
		<s:set var="controlGroupErrorClassVar" value="%{#fieldHasFieldErrorVar ? ' has-error' : ''}" />
		<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
			<label class="control-label col-lg-3 col-md-3" for="description"><s:text name="description" /></label>
			<div class="col-md-9 col-lg-9">
				<s:textfield name="description" id="description" cssClass="form-control" />
				<s:if test="#fieldHasFieldErrorVar">
				<span class="help-block text-danger">
					<s:iterator value="#fieldErrorsVar"><s:property />&#32;</s:iterator>
				</span>
			</s:if>
			</div>
		</div>
	<%-- save --%>
	<div class="form-group">
		<div class="col-md-offset-3 col-lg-offset-3 col-md-9 col-lg-9">
			<s:submit type="button" cssClass="btn btn-primary">
				<s:text name="label.save" />
			</s:submit>
		</div>
	</div>
</s:form>