<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<s:set var="currentDateAttributeName" value="%{#attributeTracer.getFormFieldName(#attribute)}" />
<s:if test="#attribute.failedDateString == null"></s:if>
	<s:set var="dateAttributeValue" value="#attribute.getFormattedDate('dd/MM/yyyy')" />
<s:else>
	<s:set name="dateAttributeValue" value="#attribute.failedDateString"></s:set>
</s:else>
<wpsf:textfield id="%{#currentDateAttributeName}"
		name="%{#currentDateAttributeName}" value="%{#dateAttributeValue}"
		maxlength="254" cssClass="form-control datepicker" />
<%-- //TODO: create label for dd/MM/yyyy --%>
<span class="help help-block">dd/MM/yyyy</span>