<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<%@ taglib prefix="wpsa" uri="/apsadmin-core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>
<s:set var="targetNS" value="%{'/do/Api/Consumer'}" />
<h1><s:text name="title.apiConsumerManagement" /><s:include value="/WEB-INF/apsadmin/jsp/common/inc/operations-context-general.jsp" /></h1>
<div id="main">
	<s:if test="strutsAction == 1">
		<h2 class="margin-more-bottom"><s:text name="title.apiConsumerManagement.new" /></h2>
	</s:if>
	<s:if test="strutsAction == 2">
		<h2 class="margin-more-bottom"><s:text name="title.apiConsumerManagement.edit" /></h2>
	</s:if>


	<s:form action="save" >
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
		<s:if test="hasActionErrors()">
			<div class="message message_error">
				<h3><s:text name="message.title.ActionErrors" /></h3>
				<ul>
					<s:iterator value="actionErrors">
						<li><s:property escape="false" /></li>
					</s:iterator>
				</ul>
			</div>
		</s:if>

		<fieldset><legend><s:text name="label.info" /></legend>
			<p>
				<wpsf:hidden name="strutsAction" />
				<s:if test="strutsAction == 2">
					<wpsf:hidden name="consumerKey" />
				</s:if>
				<label for="consumerKey" class="basic-mint-label"><s:text name="label.consumerKey" />:</label>
				<wpsf:textfield useTabindexAutoIncrement="true" name="consumerKey" id="consumerKey" disabled="%{getStrutsAction() == 2}" cssClass="text" />
			</p>
			<p>
				<label for="secret" class="basic-mint-label"><s:text name="label.secret" />:</label>
				<wpsf:textfield useTabindexAutoIncrement="true" name="secret" id="secret" cssClass="text" />
			</p>
			<p>
				<label for="description" class="basic-mint-label"><s:text name="label.description" />:</label>
				<wpsf:textarea useTabindexAutoIncrement="true"  cols="50" rows="3" name="description" id="description"cssClass="text" />
			</p>
			<p>
				<label for="callbackUrl" class="basic-mint-label"><s:text name="label.callbackUrl" />:</label>
				<wpsf:textfield useTabindexAutoIncrement="true" name="callbackUrl" id="callbackUrl" cssClass="text" />
			</p>
			<p>
				<label for="expirationDate" class="basic-mint-label"><s:text name="label.expirationDate" />:</label>
				<wpsf:textfield useTabindexAutoIncrement="true" name="expirationDate" id="expirationDate" cssClass="text" />
			</p>
		</fieldset>

		<p class="centerText">
			<wpsf:submit useTabindexAutoIncrement="true" value="%{getText('label.save')}" cssClass="button" />
		</p>

	</s:form>

</div>