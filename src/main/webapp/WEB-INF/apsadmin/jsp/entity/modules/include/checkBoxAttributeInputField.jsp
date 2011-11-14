<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>

<s:set name="checkedValue" value="%{#attribute.booleanValue != null && #attribute.booleanValue ==true}" />
<wpsf:checkbox useTabindexAutoIncrement="true" name="%{#attributeTracer.getFormFieldName(#attribute)}" id="%{#attributeTracer.getFormFieldName(#attribute)}" value="#checkedValue" />&#32;
<label for="<s:property value="#attributeTracer.getFormFieldName(#attribute)" />"><s:text name="label.true" /></label>