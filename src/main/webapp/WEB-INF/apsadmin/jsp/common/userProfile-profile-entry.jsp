<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:form>
	<s:if test="hasFieldErrors()">
		<div class="message message_error">
			<h3><s:text name="message.title.FieldErrors" /></h3>
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
	
	<p>
		<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" action="save" />
	</p>
	
</s:form>