<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<fieldset>
<legend>
<c:set var="i18n_Attribute_Key" value="${userFilterOptionVar.attribute.name}" />
<wp:i18n key="${i18n_Attribute_Key}" />
</legend>

<p>
	<c:set var="formFieldStartNameVar" value="${userFilterOptionVar.formFieldNames[0]}" />
	<label for="<c:out value="${formFieldStartNameVar}" />">
		<wp:i18n key="NUMBER_FROM" />
	</label>
	<br />
	<input id="<c:out value="${formFieldStartNameVar}" />" name="<c:out value="${formFieldStartNameVar}" />" value="${userFilterOptionVar.formFieldValues[formFieldStartNameVar]}" type="text" class="text" />
</p>
<p>
	<c:set var="formFieldEndNameVar" value="${userFilterOptionVar.formFieldNames[1]}" />
	<label for="<c:out value="${formFieldEndNameVar}" />">
		<wp:i18n key="NUMBER_TO" />
	</label>
	<br />
	<input id="<c:out value="${formFieldEndNameVar}" />" name="<c:out value="${formFieldEndNameVar}" />" value="${userFilterOptionVar.formFieldValues[formFieldEndNameVar]}" type="text" class="text"/>
</p>
</fieldset>