<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<h1><s:text name="userprofile.menu.profileAdmin" /></h1>

<div id="main">
	<h2 class="margin-more-bottom"><s:text name="userprofile.title.changeUserProfile" /></h2>
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
		
		<p class="centerText">
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" action="save" />
		</p>
		
	</s:form>
</div>