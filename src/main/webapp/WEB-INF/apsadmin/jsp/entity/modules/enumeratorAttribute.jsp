<%@ taglib uri="/apsadmin-form" prefix="wpsf" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="#lang.default">
	<wpsf:select useTabindexAutoIncrement="true" name="%{#attributeTracer.getFormFieldName(#attribute)}" id="%{#attributeTracer.getFormFieldName(#attribute)}" 
		headerKey="" headerValue="%{getText('label.none')}" 
		list="#attribute.items" value="%{#attribute.getText()}" />
</s:if>
<s:else>
	<s:if test="#attributeTracer.listElement">
		<wpsf:select useTabindexAutoIncrement="true" name="%{#attributeTracer.getFormFieldName(#attribute)}" id="%{#attributeTracer.getFormFieldName(#attribute)}" 
			headerKey="" headerValue="%{getText('label.none')}" 
			list="#attribute.items" value="%{#attribute.getText()}" />
	</s:if>
	<s:else>
		<s:text name="note.editContent.doThisInTheDefaultLanguage.must" />.
	</s:else>
</s:else>