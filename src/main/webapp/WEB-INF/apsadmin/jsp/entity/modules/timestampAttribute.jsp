<%@ taglib prefix="s" uri="/struts-tags" %>

<s:if test="%{#lang.default || #attributeTracer.listElement}">
	<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/dateAttributeInputField.jsp" />
	<s:include value="/WEB-INF/apsadmin/jsp/entity/modules/include/timestampAttributeExtraInputField.jsp" />
</s:if>
<s:else>
	<s:text name="note.editContent.doThisInTheDefaultLanguage.must" />.  
</s:else>