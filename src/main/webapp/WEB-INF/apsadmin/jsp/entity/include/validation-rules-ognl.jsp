<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>

<fieldset><legend class="accordion_toggler"><s:text name="name.ognlCodes" /></legend>
<div class="accordion_element">

<p><s:text name="note.ognlCodes.intro.1" /></p>

<p>
	<label for="ognlValidationRule.expression" class="basic-mint-label"><s:text name="name.expression" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="ognlValidationRule.expression" name="ognlValidationRule.expression" cssClass="text" />
</p>

<p>
	<wpsf:checkbox useTabindexAutoIncrement="true" name="ognlValidationRule.evalExpressionOnValuedAttribute" id="attributeEnhanced" cssClass="radiocheck" />
	<label for="attributeEnhanced"><s:text name="name.attributeEnhanced" /></label>
</p>

<p><s:text name="note.ognlCodes.intro.2" /></p>

<p>
	<label for="ognlValidationRule.helpMessage" class="basic-mint-label"><s:text name="name.helpMessage.text" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="ognlValidationRule.helpMessage" name="ognlValidationRule.helpMessage" cssClass="text" />
</p>

<p>
	<label for="ognlValidationRule.helpMessageKey" class="basic-mint-label"><s:text name="name.helpMessage.key" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="ognlValidationRule.helpMessageKey" name="ognlValidationRule.helpMessageKey" cssClass="text" />
</p>

<p>
	<label for="ognlValidationRule.errorMessage" class="basic-mint-label"><s:text name="name.errorMessage.text" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="ognlValidationRule.errorMessage" name="ognlValidationRule.errorMessage" cssClass="text" />
</p>

<p>
	<label for="ognlValidationRule.errorMessageKey" class="basic-mint-label"><s:text name="name.errorMessage.key" />:</label>
	<wpsf:textfield useTabindexAutoIncrement="true" id="ognlValidationRule.errorMessageKey" name="ognlValidationRule.errorMessageKey" cssClass="text" />
</p>
</div>
</fieldset>