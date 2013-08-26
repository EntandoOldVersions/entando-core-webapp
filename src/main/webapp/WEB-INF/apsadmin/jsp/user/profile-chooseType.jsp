<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/aps-core" prefix="wp" %>
<%@ taglib uri="/apsadmin-core" prefix="wpsa" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<h1><s:text name="userprofile.menu.profileAdmin" /></h1>
<div id="main">
	<h2><s:text name="userprofile.title.profile.choose" />:&#32;<em><s:property value="username" /></em></h2>

	<s:form action="new">
		<p><s:text name="userprofile.note.intro" /></p>

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

		<p>
			<wpsf:hidden name="username" />
			<label for="profileTypeCode"><s:text name="name.profile" />:</label>
			<wpsf:select useTabindexAutoIncrement="true" list="userProfileTypes" id="profileTypeCode" name="profileTypeCode" listKey="typeCode" listValue="typeDescr" cssClass="text" />
			&#32;<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.next')}" cssClass="button"/>
		</p>
	</s:form>
</div>