<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="wp" uri="/aps-core" %>

<c:set var="formFieldNameVar" value="${userFilterOptionVar.formFieldNames[0]}" />
<c:set var="formFieldValue" value="${userFilterOptionVar.formFieldValues[formFieldNameVar]}" />
<c:set var="i18n_Attribute_Key" value="${userFilterOptionVar.attribute.name}" />

<fieldset>
<legend><wp:i18n key="${i18n_Attribute_Key}" /></legend>
<p><c:import url="/WEB-INF/plugins/jacms/aps/jsp/showlets/inc/userFilter-module-entity-Boolean-ignoreOption.jsp" /></p>

<p>
<input name="<c:out value="${formFieldNameVar}" />" id="true_<c:out value="${formFieldNameVar}" />" <c:if test="${null != formFieldValue && formFieldValue == 'true'}">checked="checked"</c:if> value="true" type="radio" />
<label for="true_<c:out value="${formFieldNameVar}" />"><wp:i18n key="YES"/></label>
<input name="<c:out value="${formFieldNameVar}" />" id="false_<c:out value="${formFieldNameVar}" />" <c:if test="${null == formFieldValue || formFieldValue == 'false'}">checked="checked"</c:if> value="false" type="radio" />
<label for="false_<c:out value="${formFieldNameVar}" />"><wp:i18n key="NO"/></label>
<input name="<c:out value="${formFieldNameVar}" />" id="both_<c:out value="${formFieldNameVar}" />" <c:if test="${null != formFieldValue && formFieldValue == 'both'}">checked="checked"</c:if> value="both" type="radio" />
<label for="both_<c:out value="${formFieldNameVar}" />"><wp:i18n key="BOTH"/></label>
</p>
</fieldset>
