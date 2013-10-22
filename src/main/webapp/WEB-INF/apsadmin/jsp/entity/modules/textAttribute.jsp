<%@ taglib uri="/struts-tags" prefix="s" %>
<wpsf:textfield id="%{#attributeTracer.getFormFieldName(#attribute)}"
	name="%{#attributeTracer.getFormFieldName(#attribute)}" value="%{#attribute.getTextForLang(#lang.code)}"
	maxlength="254" cssClass="form-control" />