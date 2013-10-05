<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1 class="panel panel-default title-page">
	<span class="panel-body display-block">
		<a href="<s:url namespace="/do/BaseAdmin" action="settings" />"><s:text name="menu.configure" /></a>
		&#32;/&#32;
		<a href="<s:url namespace="/do/Role" action="list" />">
			<s:text name="title.roleManagement" />
		</a>
		&#32;/&#32;
		<s:if test="getStrutsAction() == 1">
			<s:text name="title.roleManagement.roleNew" />
		</s:if>
		<s:if test="getStrutsAction() == 2">
			<s:text name="title.roleManagement.roleEdit" />	
		</s:if>
	</span>
</h1>
<s:form action="save">
	<s:if test="hasFieldErrors()">
		<div class="alert alert-warning alert-dismissable fade in">
			<button class="close" data-dismiss="alert">&times;</button>
			<h2 class="h4 margin-none"><s:text name="message.title.FieldErrors" /></h2>
				<ul class="margin-base-top">
					<s:iterator value="fieldErrors">
						<s:iterator value="value">
				            <li><s:property escape="false" /></li>
						</s:iterator>
					</s:iterator>
				</ul>
		</div>
	</s:if>
	<s:if test="hasActionErrors()">
		<div class="alert alert-warning alert-dismissable fade in">
			<button class="close" data-dismiss="alert">&times;</button>
			<h2 class="h4 margin-none"><s:text name="message.title.ActionErrors" /></h2>
				<ul class="margin-base-top">
					<s:iterator value="actionErrors">
						<li><s:property escape="false" /></li>
					</s:iterator>
				</ul>
		</div>
	</s:if>
	<p class="sr-only">
		<wpsf:hidden name="strutsAction" />
		<s:if test="getStrutsAction() == 2">
			<wpsf:hidden name="name" />
		</s:if>
	</p>
	<div class="panel panel-default">
		<div class="panel panel-body">
			<s:set var="fieldFieldErrorsVar" value="%{fieldErrors['name']}" />
			<s:set var="fieldHasFieldErrorVar" value="#fieldFieldErrorsVar != null && !#fieldFieldErrorsVar.isEmpty()" />
			<s:set var="controlGroupErrorClassVar" value="%{#fieldHasFieldErrorVar ? ' has-error' : ''}" />
			<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
				<label for="name" class="control-label"><s:text name="name" /></label>
				<s:textfield name="name" id="name" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
				<s:if test="#fieldHasFieldErrorVar">
					<p class="text-danger padding-small-vertical">
						<s:iterator value="%{#fieldFieldErrorsVar}"><s:property />&#32;</s:iterator>
					</p>
				</s:if>
			</div>
			<s:set var="fieldFieldErrorsVar" value="%{fieldErrors['description']}" />
			<s:set var="fieldHasFieldErrorVar" value="#fieldFieldErrorsVar != null && !#fieldFieldErrorsVar.isEmpty()" />
			<s:set var="controlGroupErrorClassVar" value="%{#fieldHasFieldErrorVar ? ' has-error' : ''}" />
			<div class="form-group<s:property value="#controlGroupErrorClassVar" />">
				<label for="description" class="control-label"><s:text name="description" /></label>
				<s:textfield name="description" id="description" cssClass="form-control" />
				<s:if test="#fieldHasFieldErrorVar">
					<p class="text-danger padding-small-vertical">
						<s:iterator value="%{#fieldFieldErrorsVar}"><s:property />&#32;</s:iterator>
					</p>
				</s:if>
			</div>
			<div class="form-group">
				<label class="control-label"><s:text name="name.permissions" /></label>
				<span class="help-block"><s:text name="note.permissions.intro" /></span>
					<s:set var="permissionNamesVar" value="permissionNames" />
					<s:iterator value="%{systemPermissions}" var="permissionVar">
						<div class="checkbox">
							<label>
								<input 
									type="checkbox" 
									name="permissionNames" 
									value="<s:property value="%{#permissionVar.name}" />" 
									<s:if test="%{#permissionNamesVar.contains(#permissionVar.name)}"> checked="checked" </s:if>
									/>
									<s:property value="%{#permissionVar.description}" />
							</label>
						</div>
					</s:iterator>
			</div>
		</div>
	</div>
	<div class="form-group text-center">
		 <s:submit type="button" cssClass="btn btn-default">
				<s:text name="label.save" />
		 </s:submit>
	</div>
</s:form>