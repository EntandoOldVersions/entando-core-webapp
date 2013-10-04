<%@ taglib prefix="s" uri="/struts-tags" %>
<s:if test="%{#lang.default || #attributeTracer.listElement}">
	<abbr title="<s:property value="#attribute.getFormattedDate('EEEE dd MMMM yyyy, HH:mm')" />">
		<s:property value="#attribute.getFormattedDate('dd/MM/yyyy')" />&#32;&ndash;&#32;
		<s:property value="#attribute.getFormattedDate('HH')" />:<s:property value="#attribute.getFormattedDate('mm')" />
	</abbr>
</s:if>
<s:else>
	<s:text name="EntityAttribute.monolang.defaultValue" />
</s:else>