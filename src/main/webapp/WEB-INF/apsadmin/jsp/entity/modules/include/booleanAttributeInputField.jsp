<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="wpsf" uri="/apsadmin-form" %>
<s:set var="currentBooleanAttributeNameVar" value="%{#attributeTracer.getFormFieldName(#attribute)}" />
<label class="radio-inline" for="true_<s:property value="#currentBooleanAttributeNameVar" />">
	<wpsf:radio name="%{#currentBooleanAttributeNameVar}" id="true_%{#currentBooleanAttributeNameVar}" value="true" checked="%{#attribute.value == true}" />
	<s:text name="label.yes"/>
</label>
<label for="false_<s:property value="#currentBooleanAttributeNameVar" />" class="checkbox-inline">
	<wpsf:radio name="%{#currentBooleanAttributeNameVar}" id="false_%{#currentBooleanAttributeNameVar}" value="false" checked="%{#attribute.value == false}" />
	<s:text name="label.no"/>
</label>