<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:form namespace="/do/currentuser/profile" action="save" cssClass="form-horizontal">
	<s:if test="hasFieldErrors()">
		<div class="alert alert-danger alert-dismissable fade in">
			<button class="close" data-dismiss="alert"><span class="icon icon-remove"></span></button>
			<ul>
				<s:iterator value="fieldErrors">
					<s:iterator value="value">
						<li><s:property escape="false" /></li>
					</s:iterator>
				</s:iterator>
			</ul>
		</div>
	</s:if>

	<s:include value="/WEB-INF/apsadmin/jsp/common/inc/profile-formFields.jsp" />

	<div class="form-group">
		<div class="col-xs-12 col-sm-4 col-md-3 margin-small-vertical">
			<s:submit action="save" type="button" cssClass="btn btn-primary btn-block">
				<s:text name="label.save" />
			</s:submit>
		</div>
	</div>

</s:form>