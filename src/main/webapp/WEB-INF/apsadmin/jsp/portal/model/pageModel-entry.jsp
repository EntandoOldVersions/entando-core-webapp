<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<s:form action="save" >
	<s:if test="hasActionErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon fa fa-times"></span></button>
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
			<button class="close" data-dismiss="alert"><span class="icon fa fa-times"></span></button>
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
	<p class="sr-only">
		<wpsf:hidden name="strutsAction" />
		<s:if test="getStrutsAction() == 2">
			<wpsf:hidden name="code" />
		</s:if>
	</p>
	
	CODE <wpsf:textfield name="code" id="code" disabled="%{getStrutsAction() == 2}" cssClass="form-control" />
	<br />
	DESCRIPTION <wpsf:textfield name="description" id="description" cssClass="form-control" />
	<br />
	PLUGIN CODE <wpsf:textfield name="pluginCode" id="pluginCode" cssClass="form-control" />
	<br />
	xmlConfiguration  ** THIS FIELD HAS TO BE REMOVED **<br />
	<wpsf:textarea name="xmlConfiguration" id="xmlConfiguration" cssClass="form-control" rows="8" cols="50" />
	<br />
	template<br />
	<wpsf:textarea name="template" id="template" cssClass="form-control" rows="8" cols="50" />
	<br />
	
    <div class="form-group">
      <div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
        <wpsf:submit type="button" cssClass="btn btn-primary btn-block">
          <span class="icon fa fa-floppy-o"></span>&#32;
          <s:text name="label.save" />
        </wpsf:submit>
      </div>
    </div>
</s:form>