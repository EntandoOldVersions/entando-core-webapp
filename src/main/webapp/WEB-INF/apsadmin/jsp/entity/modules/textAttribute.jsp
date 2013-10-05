<%@ taglib uri="/struts-tags" prefix="s" %>
<s:textfield id="%{#attributeTracer.getFormFieldName(#attribute)}"
	name="%{#attributeTracer.getFormFieldName(#attribute)}" value="%{#attribute.getTextForLang(#lang.code)}"
	maxlength="254" cssClass="form-control" />