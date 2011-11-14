<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<wpsf:textarea useTabindexAutoIncrement="true"  cols="50" rows="3" id="%{#attributeTracer.getFormFieldName(#attribute)}" 
	name="%{#attributeTracer.getFormFieldName(#attribute)}" value="%{#attribute.getTextForLang(#lang.code)}" cssClass="text" />