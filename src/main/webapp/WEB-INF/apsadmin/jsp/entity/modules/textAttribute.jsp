<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<wpsf:textfield useTabindexAutoIncrement="true" id="%{#attributeTracer.getFormFieldName(#attribute)}" 
	name="%{#attributeTracer.getFormFieldName(#attribute)}" value="%{#attribute.getTextForLang(#lang.code)}"
	maxlength="254" cssClass="text" />